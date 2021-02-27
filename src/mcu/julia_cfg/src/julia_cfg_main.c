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
#define UART_BUFFER_LENGTH   258  // Enough for a full page + checksum

#define MCU_LED_OFF 1
#define MCU_LED_ON  0
SI_SBIT(MCU_LED_GREEN, SFR_P1, 3);// P1.3 MCU_LED1
SI_SBIT(MCU_LED_RED,   SFR_P1, 4);// P1.4 MCU_LED2

#define CMD_ERASE 0
#define CMD_DUMP 1
#define CMD_WRITE 2
#define CMD_NONE 0xFF

#define CMD_MAGIC1 0xCA
#define CMD_MAGIC2 0xFE
#define CMD_LENGTH 3

#define RSP_MAGIC1 0x48
#define RSP_MAGIC2 0x49
#define RSP_FAIL 0x00
#define RSP_SUCCESS 0x01
#define RSP_LENGTH 4

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
SI_SEGMENT_VARIABLE(buffer[UART_BUFFER_LENGTH], uint8_t, SI_SEG_XDATA);
volatile bool tx_complete, rx_complete;

//-----------------------------------------------------------------------------
// SiLabs_Startup() Routine
// ----------------------------------------------------------------------------
// This function is called immediately after reset, before the initialization
// code is run in SILABS_STARTUP.A51 (which runs before main() ).
//-----------------------------------------------------------------------------
void SiLabs_Startup (void)
{
}

uint8_t wait_for_command(void)
{
    rx_complete = false;
    UART0_readBuffer(buffer, CMD_LENGTH);
    while (!rx_complete);

    if (!(buffer[0] == CMD_MAGIC1 && buffer[1] == CMD_MAGIC2))
        return CMD_NONE;

    return buffer[2];
}

void respond(uint8_t cmd, uint8_t status)
{
    buffer[0] = RSP_MAGIC1;
    buffer[1] = RSP_MAGIC2;
    buffer[2] = cmd;
    buffer[3] = status;

    tx_complete = false;
    UART0_writeBuffer(buffer, RSP_LENGTH);
    while (!tx_complete);
}

void bail(void)
{
    MCU_LED_RED = MCU_LED_ON;
    while (1) {}
}

void succeed(void)
{
    MCU_LED_GREEN = MCU_LED_ON;
    while (1) {}
}

//-----------------------------------------------------------------------------
// main() Routine
// ----------------------------------------------------------------------------
int main (void)
{
    uint8_t cmd;

    SPI_CS_N = SPI_CS_N_DISABLE;
    MCU_LED_GREEN = MCU_LED_OFF;
    MCU_LED_RED = MCU_LED_OFF;
    enter_DefaultMode_from_RESET();
    IE_EA = 1;                                // Enable global interrupts

    UART0_init(UART0_RX_ENABLE, UART0_WIDTH_8, UART0_MULTIPROC_DISABLE);

    if (SPI_Flash_Init())
        MCU_LED_GREEN = MCU_LED_ON;
    else
        bail();

    while (1)
    {
        cmd = wait_for_command();
        MCU_LED_GREEN = MCU_LED_OFF;
        switch (cmd)
        {
          case CMD_ERASE:
            if (SPI_Flash_Erase()) {
                MCU_LED_GREEN = MCU_LED_ON;
                respond(CMD_ERASE, RSP_SUCCESS);
            }
            else {
                respond(CMD_ERASE, RSP_FAIL);
                bail();
            }

            break;
          case CMD_DUMP:
            // TODO:
            bail();
            break;
          case CMD_WRITE:
            // TODO:
            bail();
            break;

          default:
            // TODO: timeout, config FPGA
            bail();
            break;
        }
    }

shutdown_success:
    succeed();

    while (1);
}

//-----------------------------------------------------------------------------
// UART ISR Callbacks
//-----------------------------------------------------------------------------
void UART0_receiveCompleteCb ()
{
    rx_complete = true;
}

void UART0_transmitCompleteCb ()
{
    tx_complete = true;
}

