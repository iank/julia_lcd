#!/usr/bin/env python3
import serial

with serial.Serial('/dev/ttyUSB0', 9600) as ser:
    ser.write(b'\xCA\xFE\x00')    # Write erase command
    resp = ser.read(4)
    print(resp)
