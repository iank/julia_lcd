/*
 * spi_flash.h
 *
 *  Created on: Feb 26, 2021
 *      Author: ian
 */

#ifndef INC_SPI_FLASH_H_
#define INC_SPI_FLASH_H_

#define SPI_CS_N_ENABLE 0
#define SPI_CS_N_DISABLE 1
SI_SBIT(SPI_CS_N, SFR_P0, 7);// P0.7 SPI_CS_N

bool SPI_Flash_Init(void);
bool SPI_Flash_Erase(void);

#endif /* INC_SPI_FLASH_H_ */
