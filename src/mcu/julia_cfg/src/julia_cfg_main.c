//-----------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------
#include <SI_EFM8BB2_Register_Enums.h>                // SFR declarations
#include <InitDevice.h>
#include <uart_0.h>

//-----------------------------------------------------------------------------
// Global Constants
//-----------------------------------------------------------------------------
#define BUFFER_LENGTH   5

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
SI_SEGMENT_VARIABLE(buffer[BUFFER_LENGTH], uint8_t, SI_SEG_XDATA);

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
    enter_DefaultMode_from_RESET();
    UART0_init(UART0_RX_ENABLE, UART0_WIDTH_8, UART0_MULTIPROC_DISABLE);
    IE_EA = 1;                                // Enable global interrupts
    while (1)
    {
        if ((UART0_rxBytesRemaining() == 0) && (UART0_txBytesRemaining() == 0))
        {
           UART0_readBuffer(buffer, BUFFER_LENGTH);
        }
    }
}

//-----------------------------------------------------------------------------
// UART ISR Callbacks
//-----------------------------------------------------------------------------
void UART0_receiveCompleteCb ()
{
   uint8_t i;
   unsigned char byte;

   for (i = 0; i<BUFFER_LENGTH; i++)
   {
      byte = buffer[i];

      // if lower case letter
      if ((byte >= 'a') && (byte <= 'z'))
      {
         byte -= 32;
      }

      buffer[i] = byte;
   }
   UART0_writeBuffer(buffer, BUFFER_LENGTH);
}

void UART0_transmitCompleteCb ()
{
}
