/*
 * spi_flash.c
 *
 *  Created on: Feb 26, 2021
 *
 *  Loose port of https://github.com/ARMmbed/spif-driver/
 */

#include <SI_EFM8BB2_Register_Enums.h>                // SFR declarations
#include <spi_0.h>
#include "spi_flash.h"
#include "util.h"
#include "string.h"

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------

#define PAGE_LENGTH 256

#define WRSR 0x01
#define PAGE_PROGRAM 0x02
#define READ_DATA 0x03
#define WRDI 0x04
#define RDSR 0x05
#define WREN 0x06
#define EWSR 0x50
#define ERASE_ALL 0x60
#define RDID 0x90

#define FLASH_TXN_LENGTH 16

#define SR_WIP 0x01
#define SR_WEL 0x02

#define SPI_NO_ADDRESS_COMMAND 0xFFFFFFFF

#define WAIT_BUSY_RETRIES 1000

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------

SI_SEGMENT_VARIABLE(SPI_TxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_TX_SEGTYPE);
SI_SEGMENT_VARIABLE(SPI_RxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_RX_SEGTYPE);

volatile bool SPI0_Busy = false;

//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------

static void _SPI_General_Command(uint8_t instruction, uint32_t addr,
                                 uint8_t tx_length, uint8_t *txbuf,
                                 uint8_t rx_length, uint8_t *rxbuf)
{
    uint8_t txbuf_idx = 0;
    uint8_t rxbuf_idx;
    uint8_t total_tx_length;

    // Setup Tx Buf
    SPI_TxBuf[txbuf_idx++] = instruction;

    if (addr != SPI_NO_ADDRESS_COMMAND)
    {
        SPI_TxBuf[txbuf_idx++] = (addr & 0x00FF0000) >> 16;
        SPI_TxBuf[txbuf_idx++] = (addr & 0x0000FF00) >>  8;
        SPI_TxBuf[txbuf_idx++] = (addr & 0x000000FF);
    }

    total_tx_length = txbuf_idx + tx_length;
    for (; txbuf_idx < total_tx_length; txbuf_idx++)
    {
        SPI_TxBuf[txbuf_idx] = *(txbuf++);
    }

    total_tx_length = txbuf_idx + rx_length;
    rxbuf_idx = txbuf_idx;
    for (; txbuf_idx < total_tx_length; txbuf_idx++)
    {
        SPI_TxBuf[txbuf_idx] = 0x00;
    }

    // Do transfer
    SPI0_Busy = true;
    SPI_CS_N = SPI_CS_N_ENABLE;

    SPI0_transfer(SPI_TxBuf, SPI_RxBuf, SPI0_TRANSFER_RXTX, total_tx_length);

    while (SPI0_Busy);
    SPI_CS_N = SPI_CS_N_DISABLE;

    // Copy out RX data
    for (; rxbuf_idx < total_tx_length; rxbuf_idx++)
    {
        *(rxbuf++) = SPI_RxBuf[rxbuf_idx];
    }
}

// Check if memory is ready / wait for write to complete
static bool _WaitBusy()
{
    unsigned int retries = 0;
    uint8_t status;
    do {
        delay(DELAY_10_MS);
        retries++;

        _SPI_General_Command(RDSR, SPI_NO_ADDRESS_COMMAND, 0, NULL, 1, &status);
    } while ((status & SR_WIP) && retries < WAIT_BUSY_RETRIES);

    if (status & SR_WIP)
    {
        return false;
    }

    return true;
}

static bool _Set_Write_Enable()
{
    uint8_t status;

    _SPI_General_Command(WREN, SPI_NO_ADDRESS_COMMAND, 0, NULL, 0, NULL);
    if (!_WaitBusy)
        return false;

    _SPI_General_Command(RDSR, SPI_NO_ADDRESS_COMMAND, 0, NULL, 1, &status);
    if ((status & SR_WEL) == 0)
        return false;

    return true;
}

bool SPI_Flash_Init(void)
{
    uint8_t ids[2];
    uint8_t tmp;
    _SPI_General_Command(RDID, 0x00, 0, NULL, 2, ids);

    // Expecting Mfg ID 0xEF, Device ID 0x13
    if (ids[0] == 0xEF && ids[1] == 0x13)
    {
        // Clear pending writes
        _SPI_General_Command(WRDI, SPI_NO_ADDRESS_COMMAND, 0, NULL, 0, NULL);
        // Enable write status register
        _SPI_General_Command(EWSR, SPI_NO_ADDRESS_COMMAND, 0, NULL, 0, NULL);
        // Clear write-protect on all memory locations
        tmp = 0;
        _SPI_General_Command(WRSR, SPI_NO_ADDRESS_COMMAND, 1, &tmp, 0, NULL);

        return true;
    }
    else
    {
        return false;
    }

    // Send WRDI
    // Send EWSR
    // WRSR, 0x00
}

bool SPI_Flash_Erase(void)
{
    uint8_t retries = 0;
    if (!_Set_Write_Enable())
        return false;

    _SPI_General_Command(ERASE_ALL, SPI_NO_ADDRESS_COMMAND, 0, NULL, 0, NULL);

    while (retries++ < 10)
    {
        if (_WaitBusy())
            return true;
    }
    return false;
}

bool SPI_Program_Page(uint32_t addr, const uint8_t *buffer)
{
    uint8_t i;

    if (!_Set_Write_Enable())
        return false;

    // Do transfer
    SPI0_Busy = true;
    SPI_CS_N = SPI_CS_N_ENABLE;

    SPI_TxBuf[0] = PAGE_PROGRAM;
    SPI_TxBuf[1] = (addr & 0x00FF0000) >> 16;
    SPI_TxBuf[2] = (addr & 0x0000FF00) >>  8;
    SPI_TxBuf[3] = (addr & 0x000000FF);

    SPI0_transfer(SPI_TxBuf, NULL, SPI0_TRANSFER_TX, 4);
    while (SPI0_Busy);

    for (i=0; i<16; i++)
    {
        memcpy(SPI_TxBuf, buffer, 16);
        buffer += 16;

        SPI0_Busy = true;
        SPI0_transfer(SPI_TxBuf, NULL, SPI0_TRANSFER_TX, 16);

        while (SPI0_Busy);
    }

    SPI_CS_N = SPI_CS_N_DISABLE;

    if (_WaitBusy())
        return true;
    else
        return false;
}

bool SPI_Read_Page(uint32_t addr, const uint8_t *buffer)
{
    uint8_t i;

    // Do transfer
    SPI0_Busy = true;
    SPI_CS_N = SPI_CS_N_ENABLE;

    SPI_TxBuf[0] = READ_DATA;
    SPI_TxBuf[1] = (addr & 0x00FF0000) >> 16;
    SPI_TxBuf[2] = (addr & 0x0000FF00) >>  8;
    SPI_TxBuf[3] = (addr & 0x000000FF);

    SPI0_transfer(SPI_TxBuf, NULL, SPI0_TRANSFER_TX, 4);
    while (SPI0_Busy);

    for (i=0; i<16; i++)
    {
        SPI0_Busy = true;
        SPI0_transfer(NULL, SPI_RxBuf, SPI0_TRANSFER_RX, 16);

        while (SPI0_Busy);

        memcpy(buffer, SPI_RxBuf, 16);
        buffer += 16;
    }

    SPI_CS_N = SPI_CS_N_DISABLE;

    return true;
}

//-----------------------------------------------------------------------------
// SPI0 callbacks
//-----------------------------------------------------------------------------
void SPI0_transferCompleteCb(void)
{
    SPI0_Busy = false;
}
