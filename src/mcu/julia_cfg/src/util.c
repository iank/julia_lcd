/*
 * util.c
 *
 *  Created on: Feb 26, 2021
 *      Author: ian
 */

// https://stackoverflow.com/a/12839870
void bin_to_hexstr(unsigned char *str, const unsigned char *buf, unsigned int num_bytes)
{
    const char * hex = "0123456789ABCDEF";
    const unsigned char *pin = buf;
    for(; pin < buf+num_bytes; str+=2, pin++){
        str[0] = hex[(*pin>>4) & 0xF];
        str[1] = hex[ *pin     & 0xF];
    }
    str[0] = '\r';
    str[1] = '\n';
}
