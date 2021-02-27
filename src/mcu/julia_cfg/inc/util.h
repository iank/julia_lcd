/*
 * util.h
 *
 *  Created on: Feb 26, 2021
 *      Author: ian
 */

#ifndef INC_UTIL_H_
#define INC_UTIL_H_

#define DELAY_10_MS 1

void bin_to_hexstr(unsigned char *str, const unsigned char *buf, unsigned int num_bytes);
void delay(unsigned int tenths);

#endif /* INC_UTIL_H_ */
