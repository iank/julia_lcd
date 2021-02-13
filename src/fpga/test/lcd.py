#!/usr/bin/env python3
import sys
import os
import re
import struct
from PIL import Image

def render_lcd(file):
    lcd_file = open(file, 'r')

    res_x = 800
    res_y = 480

    x_counter = 0
    y_counter = 0

    frame_count = 0
    lcd_output = Image.new('RGB', (res_x, res_y), (0,0,0))

    for lcd_line in lcd_file:
        pattern = re.compile(r"^.*VID:\s+(\d+),1,([0-9a-fA-F]+),([01]),[01],[01].*$")
        match = pattern.match(lcd_line)

        if (match):
            time_ns = int(match.group(1))
            rgb = int(match.group(2), 16)
            den = int(match.group(3))

            if not den:
                continue

            x_counter += 1
            if x_counter == res_x:
                x_counter = 0
                y_counter += 1
                if (y_counter == res_y):
                    lcd_output.show()                    
                    frame_count += 1
                    x_counter = 0
                    y_counter = 0

            lcd_output.putpixel((x_counter, y_counter),
                                ((rgb & 0xFF0000) >> 16,
                                 (rgb & 0x00FF00) >>  8,
                                 (rgb & 0x0000FF)))

    print("Decoded {} frames".format(frame_count))
    print("{} {}".format(x_counter,y_counter))

if os.path.isfile(sys.argv[1]):
    render_lcd(sys.argv[1])
