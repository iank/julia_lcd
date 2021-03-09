#!/usr/bin/env python3
import colorsys

header = '''
module color_map
(
    input [7:0] value,
    output reg [23:0] rgb
);
    always @(*) begin
        case (value)
'''

footer = '''
        endcase
    end
endmodule
'''

print(header)

for i in range(256):
    hue = i / 256;
    sat = 0.6
    val = 1

    rgb = colorsys.hsv_to_rgb(hue, sat, val)
    rgb_hex = ''.join(['%02x' % round(i*255) for i in rgb])

    print(' '*12, "8'd{0: <3} : rgb = 24'h{1};".format(i, rgb_hex))

print(footer)
