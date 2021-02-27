#!/usr/bin/env python3
import serial
import sys
import hashlib
import time

with serial.Serial('/dev/ttyUSB0', 38400) as ser:
    ser.write(b'\xCA\xFE\x00')    # Send erase command
    resp = ser.read(4)
    if resp != b'HI\x00\x01':
        print("Failed to erase chip")
        sys.exit(1)

    print("Chip erased")

#############################################################
    with open('julia.rbf', mode='rb') as file:
        rbf_bytes = file.read()
    checksum = hashlib.sha256(rbf_bytes).hexdigest()

    rbf_len = len(rbf_bytes)
    ser.write(b'\xCA\xFE\x02')    # Send write command
    time.sleep(1);
    ser.write(rbf_len.to_bytes(length=4, byteorder='big'))
    
    resp = ser.read(4)
    if resp != b'HI\x02\x02':
        print("Failure sending length")
        sys.exit(1)

    length = rbf_len
    i = 0
    while (length):
        to_write = min(length, 256)
        ser.write(rbf_bytes[:to_write])
        rbf_bytes = rbf_bytes[to_write:]

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

#############################################################
    ser.write(b'\xCA\xFE\x01')    # Send dump command
    resp = ser.read(4)
    print(resp)
    length = int.from_bytes(resp, byteorder='big')

    print("Expecting length {}".format(length))

    rbf_bytes = b''
    i = 0
    while (length):
        to_read = min(length, 256)
        resp = ser.read(to_read)
        rbf_bytes = rbf_bytes + resp
        print(i)

        length = length - to_read
        i = i + 1

    resp = ser.read(4)
    if resp == b'HI\x01\x01':
        print("Dump complete")
    else:
        print("Failure during dump")
        sys.exit(1)

    checksum2 = hashlib.sha256(rbf_bytes).hexdigest()
    if checksum != checksum2:
        print("Checksum mismatch, aborting")
        sys.exit(1)
    else:
        print("Verified, configuring")
