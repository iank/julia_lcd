EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_01x40_Female J4
U 1 1 6071FF35
P 9050 2750
F 0 "J4" H 9078 2726 50  0000 L CNN
F 1 "Molex 0541044031" H 9078 2635 50  0000 L CNN
F 2 "ik:Molex_54104-4031_1x40-P0.5mm_Horizontal" H 9050 2750 50  0001 C CNN
F 3 "~" H 9050 2750 50  0001 C CNN
	1    9050 2750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x06_Female J5
U 1 1 60721DA4
P 9050 5600
F 0 "J5" H 9078 5576 50  0000 L CNN
F 1 "Molex 0522710679" H 9078 5485 50  0000 L CNN
F 2 "ik:Molex_52271-0679_1x06-1MP_P1.00mm_Horizontal" H 9050 5600 50  0001 C CNN
F 3 "~" H 9050 5600 50  0001 C CNN
	1    9050 5600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0137
U 1 1 60725F4B
P 1100 1550
F 0 "#PWR0137" H 1100 1400 50  0001 C CNN
F 1 "+5V" H 1115 1723 50  0000 C CNN
F 2 "" H 1100 1550 50  0001 C CNN
F 3 "" H 1100 1550 50  0001 C CNN
	1    1100 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C43
U 1 1 60726867
P 1150 2050
F 0 "C43" H 1265 2096 50  0000 L CNN
F 1 "4.7uF" H 1265 2005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1188 1900 50  0001 C CNN
F 3 "~" H 1150 2050 50  0001 C CNN
	1    1150 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:L L1
U 1 1 60726B3A
P 2500 1650
F 0 "L1" V 2690 1650 50  0000 C CNN
F 1 "10uH" V 2599 1650 50  0000 C CNN
F 2 "ik:Murata_D53LC_A915AY-100M" H 2500 1650 50  0001 C CNN
F 3 "~" H 2500 1650 50  0001 C CNN
	1    2500 1650
	0    -1   -1   0   
$EndComp
$Comp
L Device:D D5
U 1 1 6072739D
P 3350 1650
F 0 "D5" H 3350 1433 50  0000 C CNN
F 1 "MBR0540" H 3350 1524 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-123" H 3350 1650 50  0001 C CNN
F 3 "~" H 3350 1650 50  0001 C CNN
	1    3350 1650
	-1   0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 60728526
P 3250 2550
F 0 "R10" H 3320 2596 50  0000 L CNN
F 1 "3.3" H 3320 2505 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" V 3180 2550 50  0001 C CNN
F 3 "~" H 3250 2550 50  0001 C CNN
	1    3250 2550
	1    0    0    -1  
$EndComp
Text HLabel 1600 2250 0    50   Input ~ 0
LIGHT
Text Label 4600 1650 2    50   ~ 0
LED+
Text Label 4600 2450 2    50   ~ 0
LED-
$Comp
L power:GND #PWR0140
U 1 1 6073FDBF
P 3700 2200
F 0 "#PWR0140" H 3700 1950 50  0001 C CNN
F 1 "GND" H 3705 2027 50  0000 C CNN
F 2 "" H 3700 2200 50  0001 C CNN
F 3 "" H 3700 2200 50  0001 C CNN
	1    3700 2200
	1    0    0    -1  
$EndComp
Text Label 8400 1850 1    50   ~ 0
RGB[0..23]
Entry Wire Line
	8400 1150 8500 1250
Entry Wire Line
	8400 1250 8500 1350
Entry Wire Line
	8400 1350 8500 1450
Entry Wire Line
	8400 1450 8500 1550
Entry Wire Line
	8400 1550 8500 1650
Entry Wire Line
	8400 1650 8500 1750
Entry Wire Line
	8400 1750 8500 1850
Entry Wire Line
	8400 1850 8500 1950
Entry Wire Line
	8400 1950 8500 2050
Entry Wire Line
	8400 2050 8500 2150
Entry Wire Line
	8400 2150 8500 2250
Entry Wire Line
	8400 2250 8500 2350
Entry Wire Line
	8400 2350 8500 2450
Entry Wire Line
	8400 2450 8500 2550
Entry Wire Line
	8400 2550 8500 2650
Entry Wire Line
	8400 2650 8500 2750
Entry Wire Line
	8400 2750 8500 2850
Entry Wire Line
	8400 2850 8500 2950
Entry Wire Line
	8400 2950 8500 3050
Entry Wire Line
	8400 3050 8500 3150
Entry Wire Line
	8400 3150 8500 3250
Entry Wire Line
	8400 3250 8500 3350
Entry Wire Line
	8400 3350 8500 3450
Entry Wire Line
	8400 3450 8500 3550
Text HLabel 8100 1100 0    50   Input ~ 0
RGB[0..23]
Wire Bus Line
	8400 1100 8100 1100
Wire Wire Line
	8500 1250 8850 1250
Wire Wire Line
	8500 1350 8850 1350
Wire Wire Line
	8500 1450 8850 1450
Wire Wire Line
	8500 1550 8850 1550
Wire Wire Line
	8500 1650 8850 1650
Wire Wire Line
	8500 1750 8850 1750
Wire Wire Line
	8500 1850 8850 1850
Wire Wire Line
	8500 1950 8850 1950
Wire Wire Line
	8500 2050 8850 2050
Wire Wire Line
	8500 2150 8850 2150
Wire Wire Line
	8500 2250 8850 2250
Wire Wire Line
	8500 2350 8850 2350
Wire Wire Line
	8500 2450 8850 2450
Wire Wire Line
	8500 2550 8850 2550
Wire Wire Line
	8500 2650 8850 2650
Wire Wire Line
	8500 2750 8850 2750
Wire Wire Line
	8500 2850 8850 2850
Wire Wire Line
	8500 2950 8850 2950
Wire Wire Line
	8500 3050 8850 3050
Wire Wire Line
	8500 3150 8850 3150
Wire Wire Line
	8500 3250 8850 3250
Wire Wire Line
	8500 3350 8850 3350
Wire Wire Line
	8500 3450 8850 3450
Wire Wire Line
	8500 3550 8850 3550
Text Label 8550 1250 0    50   ~ 0
RGB0
Text Label 8550 1350 0    50   ~ 0
RGB1
Text Label 8550 1450 0    50   ~ 0
RGB2
Text Label 8550 1550 0    50   ~ 0
RGB3
Text Label 8550 1650 0    50   ~ 0
RGB4
Text Label 8550 1750 0    50   ~ 0
RGB5
Text Label 8550 1850 0    50   ~ 0
RGB6
Text Label 8550 1950 0    50   ~ 0
RGB7
Text Label 8550 2050 0    50   ~ 0
RGB8
Text Label 8550 2150 0    50   ~ 0
RGB9
Text Label 8550 2250 0    50   ~ 0
RGB10
Text Label 8550 2350 0    50   ~ 0
RGB11
Text Label 8550 2450 0    50   ~ 0
RGB12
Text Label 8550 2550 0    50   ~ 0
RGB13
Text Label 8550 2650 0    50   ~ 0
RGB14
Text Label 8550 2750 0    50   ~ 0
RGB15
Text Label 8550 2850 0    50   ~ 0
RGB16
Text Label 8550 2950 0    50   ~ 0
RGB17
Text Label 8550 3050 0    50   ~ 0
RGB18
Text Label 8550 3150 0    50   ~ 0
RGB19
Text Label 8550 3250 0    50   ~ 0
RGB20
Text Label 8550 3350 0    50   ~ 0
RGB21
Text Label 8550 3450 0    50   ~ 0
RGB22
Text Label 8550 3550 0    50   ~ 0
RGB23
$Comp
L power:+3V3 #PWR0141
U 1 1 60803A43
P 8550 700
F 0 "#PWR0141" H 8550 550 50  0001 C CNN
F 1 "+3V3" H 8565 873 50  0000 C CNN
F 2 "" H 8550 700 50  0001 C CNN
F 3 "" H 8550 700 50  0001 C CNN
	1    8550 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8550 700  8550 1150
Wire Wire Line
	8550 1150 8850 1150
$Comp
L power:GND #PWR0142
U 1 1 60805F70
P 7350 1200
F 0 "#PWR0142" H 7350 950 50  0001 C CNN
F 1 "GND" H 7355 1027 50  0000 C CNN
F 2 "" H 7350 1200 50  0001 C CNN
F 3 "" H 7350 1200 50  0001 C CNN
	1    7350 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 1050 7350 1050
Wire Wire Line
	7350 1050 7350 1200
Wire Wire Line
	5950 1650 5950 950 
Wire Wire Line
	5950 950  8850 950 
Wire Wire Line
	6100 2450 6100 850 
Wire Wire Line
	6100 850  8850 850 
$Comp
L power:GND #PWR0143
U 1 1 6080CC1D
P 7900 3800
F 0 "#PWR0143" H 7900 3550 50  0001 C CNN
F 1 "GND" H 7905 3627 50  0000 C CNN
F 2 "" H 7900 3800 50  0001 C CNN
F 3 "" H 7900 3800 50  0001 C CNN
	1    7900 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 3650 7900 3650
Wire Wire Line
	7900 3650 7900 3800
Text HLabel 8550 3750 0    50   Input ~ 0
LCDCLK
Wire Wire Line
	8550 3750 8850 3750
Text HLabel 8550 3850 0    50   Input ~ 0
STBYB
Text HLabel 8550 3950 0    50   Input ~ 0
HSD
Text HLabel 8550 4050 0    50   Input ~ 0
VSD
Text HLabel 8550 4150 0    50   Input ~ 0
DEN
NoConn ~ 8850 4250
NoConn ~ 8850 4450
NoConn ~ 8850 4550
NoConn ~ 8850 4650
NoConn ~ 8850 4750
$Comp
L power:GND #PWR0144
U 1 1 6082184D
P 8500 4450
F 0 "#PWR0144" H 8500 4200 50  0001 C CNN
F 1 "GND" H 8505 4277 50  0000 C CNN
F 2 "" H 8500 4450 50  0001 C CNN
F 3 "" H 8500 4450 50  0001 C CNN
	1    8500 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 4450 8500 4350
Wire Wire Line
	8500 4350 8850 4350
Wire Wire Line
	8850 4150 8550 4150
Wire Wire Line
	8850 4050 8550 4050
Wire Wire Line
	8850 3950 8550 3950
Wire Wire Line
	8550 3850 8850 3850
$Comp
L power:+3V3 #PWR0145
U 1 1 6082CE3F
P 8500 5300
F 0 "#PWR0145" H 8500 5150 50  0001 C CNN
F 1 "+3V3" H 8515 5473 50  0000 C CNN
F 2 "" H 8500 5300 50  0001 C CNN
F 3 "" H 8500 5300 50  0001 C CNN
	1    8500 5300
	1    0    0    -1  
$EndComp
Text Notes 8650 700  0    50   ~ 0
40-pin 0.5mm FPC (top contact) to TFT LCD
Text Notes 8200 6200 0    50   ~ 0
NHD-5.0-800480TF-ATXL-CTP
Wire Notes Line
	6800 500  11000 500 
Wire Notes Line
	11000 6500 6800 6500
Text Notes 8650 5300 0    50   ~ 0
6-pin 1mm FPC (bottom contact) to LCD touch controller
$Comp
L power:GND #PWR0146
U 1 1 6084619B
P 8500 5950
F 0 "#PWR0146" H 8500 5700 50  0001 C CNN
F 1 "GND" H 8505 5777 50  0000 C CNN
F 2 "" H 8500 5950 50  0001 C CNN
F 3 "" H 8500 5950 50  0001 C CNN
	1    8500 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 5950 8500 5900
Wire Wire Line
	8500 5900 8850 5900
Wire Wire Line
	8500 5300 8500 5400
Wire Wire Line
	8500 5400 8850 5400
Wire Wire Line
	8850 5800 7850 5800
Wire Wire Line
	8850 5700 8050 5700
Text HLabel 7350 5800 0    50   Input ~ 0
TOUCH_RSTN
Text HLabel 7350 5700 0    50   Output ~ 0
TOUCH_INTN
Text HLabel 7350 5600 0    50   BiDi ~ 0
SDA
Text HLabel 7350 5500 0    50   Input ~ 0
SCL
$Comp
L Device:R R14
U 1 1 608D9DFD
P 8050 5250
F 0 "R14" H 8120 5296 50  0000 L CNN
F 1 "10k" H 8120 5205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7980 5250 50  0001 C CNN
F 3 "~" H 8050 5250 50  0001 C CNN
	1    8050 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 608DA43E
P 7450 5250
F 0 "R11" H 7520 5296 50  0000 L CNN
F 1 "10k" H 7520 5205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7380 5250 50  0001 C CNN
F 3 "~" H 7450 5250 50  0001 C CNN
	1    7450 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 608DA7FB
P 7750 5250
F 0 "R12" H 7820 5296 50  0000 L CNN
F 1 "10k" H 7820 5205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7680 5250 50  0001 C CNN
F 3 "~" H 7750 5250 50  0001 C CNN
	1    7750 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 608DABE9
P 7850 6000
F 0 "R13" H 7920 6046 50  0000 L CNN
F 1 "10k" H 7920 5955 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7780 6000 50  0001 C CNN
F 3 "~" H 7850 6000 50  0001 C CNN
	1    7850 6000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0147
U 1 1 608DFF78
P 7450 4900
F 0 "#PWR0147" H 7450 4750 50  0001 C CNN
F 1 "+3V3" H 7465 5073 50  0000 C CNN
F 2 "" H 7450 4900 50  0001 C CNN
F 3 "" H 7450 4900 50  0001 C CNN
	1    7450 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 4900 7450 5000
Wire Wire Line
	7450 5400 7450 5500
Wire Wire Line
	7750 5100 7750 5000
Wire Wire Line
	7750 5000 7450 5000
Connection ~ 7450 5000
Wire Wire Line
	7450 5000 7450 5100
Wire Wire Line
	7750 5400 7750 5600
Connection ~ 7450 5500
Wire Wire Line
	7450 5500 7350 5500
Connection ~ 7750 5600
Wire Wire Line
	7750 5600 7350 5600
Wire Wire Line
	7750 5600 8850 5600
Wire Wire Line
	7450 5500 8850 5500
$Comp
L power:GND #PWR0148
U 1 1 609019D4
P 7850 6300
F 0 "#PWR0148" H 7850 6050 50  0001 C CNN
F 1 "GND" H 7855 6127 50  0000 C CNN
F 2 "" H 7850 6300 50  0001 C CNN
F 3 "" H 7850 6300 50  0001 C CNN
	1    7850 6300
	1    0    0    -1  
$EndComp
Wire Notes Line
	6800 500  6800 6500
Wire Notes Line
	11000 500  11000 6500
Wire Wire Line
	7850 5850 7850 5800
Connection ~ 7850 5800
Wire Wire Line
	7850 5800 7350 5800
Wire Wire Line
	7850 6150 7850 6300
Wire Wire Line
	8050 5400 8050 5700
Connection ~ 8050 5700
Wire Wire Line
	8050 5700 7350 5700
Wire Wire Line
	8050 5100 8050 5000
Wire Wire Line
	8050 5000 7750 5000
Connection ~ 7750 5000
Wire Wire Line
	2100 2050 1800 2050
Wire Wire Line
	1800 2050 1800 1650
Wire Wire Line
	1800 1650 2350 1650
Wire Wire Line
	2650 1650 2850 1650
Wire Wire Line
	2900 2050 3050 2050
Wire Wire Line
	3050 2050 3050 1650
Connection ~ 3050 1650
Wire Wire Line
	3050 1650 3200 1650
$Comp
L Device:C C44
U 1 1 5FF614BE
P 1800 2800
F 0 "C44" H 1915 2846 50  0000 L CNN
F 1 "220nF" H 1915 2755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1838 2650 50  0001 C CNN
F 3 "~" H 1800 2800 50  0001 C CNN
	1    1800 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C45
U 1 1 5FF618DE
P 3700 1900
F 0 "C45" H 3815 1946 50  0000 L CNN
F 1 "1uF" H 3815 1855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3738 1750 50  0001 C CNN
F 3 "~" H 3700 1900 50  0001 C CNN
	1    3700 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1100 1550 1100 1650
Wire Wire Line
	1100 1650 1150 1650
Connection ~ 1800 1650
Wire Wire Line
	3700 2050 3700 2200
Wire Wire Line
	3500 1650 3700 1650
Wire Wire Line
	3500 2450 3500 2250
Wire Wire Line
	3500 2250 3250 2250
Wire Wire Line
	3250 2400 3250 2250
Wire Wire Line
	3000 2450 2900 2450
Connection ~ 3250 2250
Wire Wire Line
	3250 2250 2900 2250
Wire Wire Line
	3500 2450 3950 2450
Wire Wire Line
	3700 1750 3700 1650
Connection ~ 3700 1650
Wire Wire Line
	3700 1650 3950 1650
Wire Wire Line
	1150 1900 1150 1650
Connection ~ 1150 1650
Wire Wire Line
	1150 1650 1800 1650
Wire Wire Line
	1800 2650 1800 2450
Wire Wire Line
	1800 2450 2100 2450
$Comp
L power:GND #PWR0138
U 1 1 5FF97960
P 2400 3150
F 0 "#PWR0138" H 2400 2900 50  0001 C CNN
F 1 "GND" H 2405 2977 50  0000 C CNN
F 2 "" H 2400 3150 50  0001 C CNN
F 3 "" H 2400 3150 50  0001 C CNN
	1    2400 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 3100 1800 3100
Wire Wire Line
	3250 3100 3250 2700
Wire Wire Line
	1150 2200 1150 3100
Wire Wire Line
	3000 2450 3000 3100
Connection ~ 3000 3100
Wire Wire Line
	3000 3100 3250 3100
Wire Wire Line
	1800 2950 1800 3100
Connection ~ 1800 3100
Wire Wire Line
	1800 3100 2400 3100
Wire Wire Line
	1600 2250 2100 2250
Wire Wire Line
	2400 3150 2400 3100
Connection ~ 2400 3100
Wire Wire Line
	2400 3100 3000 3100
$Comp
L Connector:TestPoint TP13
U 1 1 6001CBAC
P 3950 1650
F 0 "TP13" H 4008 1768 50  0000 L CNN
F 1 "TestPoint" H 4008 1677 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 4150 1650 50  0001 C CNN
F 3 "~" H 4150 1650 50  0001 C CNN
	1    3950 1650
	1    0    0    -1  
$EndComp
Connection ~ 3950 1650
Wire Wire Line
	3950 1650 5950 1650
$Comp
L Connector:TestPoint TP14
U 1 1 6001D2C8
P 3950 2450
F 0 "TP14" H 4008 2568 50  0000 L CNN
F 1 "TestPoint" H 4008 2477 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 4150 2450 50  0001 C CNN
F 3 "~" H 4150 2450 50  0001 C CNN
	1    3950 2450
	1    0    0    -1  
$EndComp
Connection ~ 3950 2450
Wire Wire Line
	3950 2450 6100 2450
$Comp
L Connector:TestPoint TP12
U 1 1 6001D676
P 2850 1650
F 0 "TP12" H 2908 1768 50  0000 L CNN
F 1 "TestPoint" H 2908 1677 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3050 1650 50  0001 C CNN
F 3 "~" H 3050 1650 50  0001 C CNN
	1    2850 1650
	1    0    0    -1  
$EndComp
Connection ~ 2850 1650
Wire Wire Line
	2850 1650 3050 1650
Wire Bus Line
	8400 1100 8400 3550
$Comp
L ik:TPS61165_SOT23 U7
U 1 1 601ACB88
P 2500 2250
F 0 "U7" H 2500 2717 50  0000 C CNN
F 1 "TPS61165_SOT23" H 2500 2626 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 2450 1350 50  0001 C CNN
F 3 "" H 2500 2250 50  0001 C CNN
	1    2500 2250
	1    0    0    -1  
$EndComp
$EndSCHEMATC