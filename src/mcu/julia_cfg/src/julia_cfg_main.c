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

/* */
// FPGA config outputs
SI_SBIT(CONFIG_N, SFR_P1, 2);     // P1.2 CONFIG_N
SI_SBIT(DCLK, SFR_P1, 5);         // P1.5 DCLK
SI_SBIT(DATA0, SFR_P1, 6);        // P1.6 DATA0

// FPGA config inputs
SI_SBIT(STATUS_N, SFR_P1, 1);     // P1.1 STATUS_N
SI_SBIT(CONF_DONE, SFR_P1, 0);    // P1.0 CONF_DONE

/* */

#define MCU_LED_OFF 1
#define MCU_LED_ON  0
SI_SBIT(MCU_LED_GREEN, SFR_P1, 3);// P1.3 MCU_LED1
SI_SBIT(MCU_LED_RED,   SFR_P1, 4);// P1.4 MCU_LED2

/* */

#define PAGE_LENGTH   256

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
#define RSP_CONTINUE 0x02
#define RSP_LENGTH 4

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
SI_SEGMENT_VARIABLE(buffer[PAGE_LENGTH], uint8_t, SI_SEG_XDATA);
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

static uint8_t wait_for_command(void)
{
    uint16_t wait;

    wait = DELAY_10_MS * 50;

    rx_complete = false;
    UART0_readBuffer(buffer, CMD_LENGTH);
    while (!rx_complete && wait > 0)
    {
        delay(DELAY_10_MS);
        wait--;
    }

    if (!rx_complete)
        return CMD_NONE;

    if (!(buffer[0] == CMD_MAGIC1 && buffer[1] == CMD_MAGIC2))
        return CMD_NONE;

    return buffer[2];
}

static void respond(uint8_t cmd, uint8_t status)
{
    buffer[0] = RSP_MAGIC1;
    buffer[1] = RSP_MAGIC2;
    buffer[2] = cmd;
    buffer[3] = status;

    tx_complete = false;
    UART0_writeBuffer(buffer, RSP_LENGTH);
    while (!tx_complete);
}

static void bail(void)
{
    MCU_LED_RED = MCU_LED_ON;
    while (1) {}
}

static bool receive_and_write(void)
{
    uint32_t length, bytes_read, addr;
    uint16_t bytes_to_read;

    rx_complete = false;
    UART0_readBuffer(buffer, sizeof(uint32_t));
    while (!rx_complete);

    length = 0;
    length |= buffer[0]; length <<= 8;
    length |= buffer[1]; length <<= 8;
    length |= buffer[2]; length <<= 8;
    length |= buffer[3];

    addr = 0;
    if (!SPI_Program_Page(addr, buffer))
        return false;

    addr += PAGE_LENGTH;

    bytes_read = 0;
    while (bytes_read < length)
    {
        if (length - bytes_read > PAGE_LENGTH)
            bytes_to_read = PAGE_LENGTH;
        else
            bytes_to_read = length - bytes_read;

        respond(CMD_WRITE, RSP_CONTINUE);

        rx_complete = false;
        UART0_readBuffer(buffer, bytes_to_read>>2);
        while (!rx_complete);

        rx_complete = false;
        UART0_readBuffer(buffer + (bytes_to_read>>2), bytes_to_read - (bytes_to_read>>2));
        while (!rx_complete);

        bytes_read += bytes_to_read;

        if (!SPI_Program_Page(addr, buffer))
            return false;

        addr += bytes_to_read;
    }

    return true;
}

static bool read_and_transmit(void)
{
    uint32_t length, bytes_read, addr;
    uint16_t bytes_to_read;

    addr = 0;
    if (!SPI_Read_Page(addr, buffer))
        return false;

    length = 0;
    length |= buffer[0]; length <<= 8;
    length |= buffer[1]; length <<= 8;
    length |= buffer[2]; length <<= 8;
    length |= buffer[3];

    tx_complete = false;
    UART0_writeBuffer(buffer, 4);
    while (!tx_complete);

    addr += PAGE_LENGTH;

    bytes_read = 0;
    while (bytes_read < length)
    {
        if (length - bytes_read > PAGE_LENGTH)
            bytes_to_read = PAGE_LENGTH;
        else
            bytes_to_read = length - bytes_read;

        bytes_read += bytes_to_read;

        if (!SPI_Read_Page(addr, buffer))
            return false;

        tx_complete = false;
        UART0_writeBuffer(buffer, bytes_to_read>>2);
        while (!tx_complete);

        tx_complete = false;
        UART0_writeBuffer(buffer + (bytes_to_read>>2), bytes_to_read - (bytes_to_read>>2));
        while (!tx_complete);

        addr += bytes_to_read;
    }

    return true;
}

static void FPGA_bitstream_write(const uint8_t *buffer, uint16_t bytes)
{
    uint16_t i;
    uint8_t byte,j;
    for (i=0; i<bytes; i++)
    {
        // Clock out data LSB first. Bits are latched on rising edge of DCLK
        byte = buffer[i];
        for (j=0; j<8; j++)
        {
            DATA0 = byte & 1;
            DCLK = 1;
            DCLK = 0;
            byte = byte >> 1;
        }
    }
}

static bool configure_fpga()
{
    uint32_t length, bytes_read, addr;
    uint16_t bytes_to_read;
    uint16_t i;

    CONFIG_N = 1;
    delay(DELAY_10_MS);
    if (!STATUS_N)
        return false;

    CONFIG_N = 0;
    delay(DELAY_10_MS);

    addr = 0;
    if (!SPI_Read_Page(addr, buffer))
        return false;

    length = 0;
    length |= buffer[0]; length <<= 8;
    length |= buffer[1]; length <<= 8;
    length |= buffer[2]; length <<= 8;
    length |= buffer[3];

    addr += PAGE_LENGTH;

    // TODO: magic value to indicate config is valid

    if (STATUS_N || CONF_DONE)
        return false;

    // Begin configuration
    CONFIG_N = 1;
    while (!STATUS_N); // TODO: timeout

    bytes_read = 0;
    while (bytes_read < length)
    {
        if (length - bytes_read > PAGE_LENGTH)
            bytes_to_read = PAGE_LENGTH;
        else
            bytes_to_read = length - bytes_read;

        bytes_read += bytes_to_read;

        if (!SPI_Read_Page(addr, buffer))
            return false;

        FPGA_bitstream_write(buffer, bytes_to_read);
        if (!STATUS_N) // Failure
            return false;

        addr += bytes_to_read;
        MCU_LED_GREEN = ~MCU_LED_GREEN;
    }

    for (i=0; i<1024; i++) {
        DCLK = ~DCLK;
    }

    if (!CONF_DONE)
        return false;

    return true;
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
    CONFIG_N = 1;
    DCLK = 0;
    DATA0 = 0;

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
            if (read_and_transmit()) {
                MCU_LED_GREEN = MCU_LED_ON;
                respond(CMD_DUMP, RSP_SUCCESS);
            }
            else {
                respond(CMD_DUMP, RSP_FAIL);
                bail();
            }
            break;
          case CMD_WRITE:
            if (receive_and_write()) {
                MCU_LED_GREEN = MCU_LED_ON;
                respond(CMD_WRITE, RSP_SUCCESS);
            }
            else {
                respond(CMD_WRITE, RSP_FAIL);
                bail();
            }
            break;

          default:
            if (configure_fpga()) {
                MCU_LED_GREEN = MCU_LED_ON;
                goto shutdown_success;
            }
            else {
                bail();
            }
            break;
        }
    }

shutdown_success:
    // TODO: power down SPI flash
    // TODO: power down self

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

