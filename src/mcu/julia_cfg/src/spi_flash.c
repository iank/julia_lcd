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

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------

#define RDID 0x90
#define WRDI 0x04
#define RDSR 0x05
#define WRSR 0x01
#define EWSR 0x50
#define FLASH_TXN_LENGTH 6

#define SR_WIP 0x01

#define SPI_NO_ADDRESS_COMMAND 0xFFFFFFFF

#define WAIT_BUSY_RETRIES 100

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
    uint8_t retries = 0;
    uint8_t status;
    do {
        retries++;

        _SPI_General_Command(RDSR, SPI_NO_ADDRESS_COMMAND, 0, NULL, 1, &status);
    } while ((status & SR_WIP) && retries < WAIT_BUSY_RETRIES);

    if (status & SR_WIP)
    {
        return false;
    }

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

//-----------------------------------------------------------------------------
// SPI0 callbacks
//-----------------------------------------------------------------------------
void SPI0_transferCompleteCb(void)
{
    SPI0_Busy = false;
}
