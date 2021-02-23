#!/usr/bin/env python3
import sys

def twos_comp(val, bits):
    if (val & (1 << (bits - 1))) != 0:
        val = val - (1 << bits) 
    return val

def convert_32bit_int_to_Q5_27(x):
    val = twos_comp(x, 32)
    return "{}".format(val / (2**27))

def convert_64bit_int_to_Q5_27(x):
    extracted_product = (x & 0x7FFFFFFF8000000) >> 27 # x[58:27]
    return convert_32bit_int_to_Q5_27(extracted_product)

input = int(sys.argv[1], 16)
print("32 bit         -> Q5.27: {}".format(convert_32bit_int_to_Q5_27(input)))
print("64 bit product -> Q5.27: {}".format(convert_64bit_int_to_Q5_27(input)))
