/*
 * spi_flash.c
 *
 *  Created on: Feb 26, 2021
 *      Author: ian
 */

#include <SI_EFM8BB2_Register_Enums.h>                // SFR declarations
#include <spi_0.h>
#include "spi_flash.h"

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------

#define FLASH_RDID 0x90
#define FLASH_TXN_LENGTH 6

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------

SI_SEGMENT_VARIABLE(SPI_TxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_TX_SEGTYPE);
SI_SEGMENT_VARIABLE(SPI_RxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_RX_SEGTYPE);

volatile bool SPI0_Busy = false;

//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------

bool SPI_Flash_Init(void)
{
    SPI_TxBuf[0] = FLASH_RDID;
    SPI_TxBuf[1] = 0x00;
    SPI_TxBuf[2] = 0x00;
    SPI_TxBuf[3] = 0x00;
    SPI_TxBuf[4] = 0x00;
    SPI_TxBuf[5] = 0x00;

    SPI0_Busy = true;
    SPI_CS_N = SPI_CS_N_ENABLE;
    SPI0_transfer(SPI_TxBuf, SPI_RxBuf, SPI0_TRANSFER_RXTX, FLASH_TXN_LENGTH);

    while (SPI0_Busy);
    SPI_CS_N = SPI_CS_N_DISABLE;

    // Expecting Mfg ID 0xEF, Device ID 0x13
    if (SPI_RxBuf[4] == 0xEF && SPI_RxBuf[5] == 0x13)
    {
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
