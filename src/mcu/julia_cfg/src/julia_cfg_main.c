//-----------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------
#include <SI_EFM8BB2_Register_Enums.h>                // SFR declarations
#include <InitDevice.h>
#include <uart_0.h>
#include <spi_0.h>

#include <util.h>

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------
#define UART_BUFFER_LENGTH   16

#define SPI_CS_N_ENABLE 0
#define SPI_CS_N_DISABLE 1
SI_SBIT(SPI_CS_N, SFR_P0, 7);// P0.7 SPI_CS_N

#define MCU_LED_OFF 1
#define MCU_LED_ON  0
SI_SBIT(MCU_LED1, SFR_P1, 3);// P1.3 MCU_LED1
SI_SBIT(MCU_LED2, SFR_P1, 4);// P1.4 MCU_LED2

#define FLASH_RDID 0x90
#define FLASH_TXN_LENGTH 6

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
SI_SEGMENT_VARIABLE(buffer[UART_BUFFER_LENGTH], uint8_t, SI_SEG_XDATA);

SI_SEGMENT_VARIABLE(SPI_TxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_TX_SEGTYPE);
SI_SEGMENT_VARIABLE(SPI_RxBuf[FLASH_TXN_LENGTH+1], uint8_t, EFM8PDL_SPI0_RX_SEGTYPE);

volatile bool SPI0_Busy = false;

//-----------------------------------------------------------------------------
// SiLabs_Startup() Routine
// ----------------------------------------------------------------------------
// This function is called immediately after reset, before the initialization
// code is run in SILABS_STARTUP.A51 (which runs before main() ).
//-----------------------------------------------------------------------------
void SiLabs_Startup (void)
{
}

void SPI_Flash_Init(void)
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
        MCU_LED1 = MCU_LED_ON;
    }
}

//-----------------------------------------------------------------------------
// main() Routine
// ----------------------------------------------------------------------------
// Note: the software watchdog timer is not disabled by default in this
// example, so a long-running program will reset periodically unless
// the timer is disabled or your program periodically writes to it.
//
// Review the "Watchdog Timer" section under the part family's datasheet
// for details. To find the datasheet, select your part in the
// Simplicity Launcher and click on "Data Sheet".
//-----------------------------------------------------------------------------
int main (void)
{
    SPI_CS_N = SPI_CS_N_DISABLE;
    MCU_LED1 = MCU_LED_OFF;
    enter_DefaultMode_from_RESET();
    IE_EA = 1;                                // Enable global interrupts

    UART0_init(UART0_RX_ENABLE, UART0_WIDTH_8, UART0_MULTIPROC_DISABLE);

    SPI_Flash_Init();

    bin_to_hexstr(buffer, SPI_RxBuf, FLASH_TXN_LENGTH);

    UART0_writeBuffer(buffer, 14);
    while (1)
    {
    }
}

//-----------------------------------------------------------------------------
// UART ISR Callbacks
//-----------------------------------------------------------------------------
void UART0_receiveCompleteCb ()
{
}

void UART0_transmitCompleteCb ()
{
}

//-----------------------------------------------------------------------------
// SPI0 callbacks
//-----------------------------------------------------------------------------
void SPI0_transferCompleteCb(void)
{
    SPI0_Busy = false;
}
