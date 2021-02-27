#!/usr/bin/env python3
import serial
import sys

with serial.Serial('/dev/ttyUSB0', 9600) as ser:
    ser.write(b'\xCA\xFE\x00')    # Send erase command
    resp = ser.read(4)
    if resp != b'HI\x00\x01':
        print("Failed to erase chip")
        sys.exit(1)

    print("Chip erased")

    ser.write(b'\xCA\xFE\x02')    # Send write command
    ser.write(b'\x00\x00\x04\x99') # test: 1177 bytes
    
    resp = ser.read(4)
    if resp != b'HI\x02\x02':
        print("Failure sending length")
        sys.exit(1)

    length = 1177
    i = 0
    while (length):
        to_write = min(length, 256)
        ser.write(bytes([i]*to_write))
        resp = ser.read(4)
        if resp == b'HI\x02\x02':
            print(i)
        elif resp == b'HI\x02\x01':
            print("Write complete")
        else:
            print("Failure during write")
            sys.exit(1)

        length = length - to_write
        i = i + 1

    ser.write(b'\xCA\xFE\x01')    # Send dump command
    resp = ser.read(4)
    print(resp)
    length = int.from_bytes(resp, byteorder='big')

    print("Expecting length {}".format(length))

    while (length):
        to_read = min(length, 256)
        resp = ser.read(to_read)
        print(resp)

        length = length - to_read

    resp = ser.read(4)
    print(resp)
