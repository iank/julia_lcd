//-----------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------
#include <SI_EFM8BB2_Register_Enums.h>                // SFR declarations
#include <InitDevice.h>
#include <uart_0.h>

#include <util.h>
#include <spi_flash.h>

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------
#define UART_BUFFER_LENGTH   16

#define MCU_LED_OFF 1
#define MCU_LED_ON  0
SI_SBIT(MCU_LED1, SFR_P1, 3);// P1.3 MCU_LED1
SI_SBIT(MCU_LED2, SFR_P1, 4);// P1.4 MCU_LED2


//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
SI_SEGMENT_VARIABLE(buffer[UART_BUFFER_LENGTH], uint8_t, SI_SEG_XDATA);

//-----------------------------------------------------------------------------
// SiLabs_Startup() Routine
// ----------------------------------------------------------------------------
// This function is called immediately after reset, before the initialization
// code is run in SILABS_STARTUP.A51 (which runs before main() ).
//-----------------------------------------------------------------------------
void SiLabs_Startup (void)
{
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

