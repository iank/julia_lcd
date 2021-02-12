EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1150 1200 0    50   Output ~ 0
TDI
Text HLabel 1150 1100 0    50   Output ~ 0
TMS
Text HLabel 1150 900  0    50   Output ~ 0
TCK
Text HLabel 1150 1000 0    50   Input ~ 0
TDO
$Comp
L power:+3V3 #PWR0125
U 1 1 60515CBE
P 1200 700
F 0 "#PWR0125" H 1200 550 50  0001 C CNN
F 1 "+3V3" H 1215 873 50  0000 C CNN
F 2 "" H 1200 700 50  0001 C CNN
F 3 "" H 1200 700 50  0001 C CNN
	1    1200 700 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 60515F89
P 2100 1300
F 0 "#PWR0126" H 2100 1050 50  0001 C CNN
F 1 "GND" H 2105 1127 50  0000 C CNN
F 2 "" H 2100 1300 50  0001 C CNN
F 3 "" H 2100 1300 50  0001 C CNN
	1    2100 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 900  1450 900 
Wire Wire Line
	1150 1000 1450 1000
Wire Wire Line
	1150 1100 1450 1100
Wire Wire Line
	1150 1200 1450 1200
Text HLabel 2250 1100 2    50   BiDi ~ 0
C2D
Text HLabel 2250 1000 2    50   BiDi ~ 0
C2CK
Text HLabel 2250 800  2    50   Input ~ 0
UART0_TX
Text HLabel 2250 900  2    50   Output ~ 0
UART0_RX
Text HLabel 1200 3100 0    50   Input ~ 0
MCU_LED1
Wire Wire Line
	2250 1100 1950 1100
Wire Wire Line
	2250 1000 1950 1000
Wire Wire Line
	1950 800  2250 800 
Wire Wire Line
	1950 900  2250 900 
$Comp
L Device:R R1
U 1 1 60789387
P 1350 2800
F 0 "R1" H 1420 2846 50  0000 L CNN
F 1 "470" H 1420 2755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1280 2800 50  0001 C CNN
F 3 "~" H 1350 2800 50  0001 C CNN
	1    1350 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 6078BBE1
P 1350 2350
F 0 "D1" V 1389 2232 50  0000 R CNN
F 1 "green" V 1298 2232 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 1350 2350 50  0001 C CNN
F 3 "~" H 1350 2350 50  0001 C CNN
	1    1350 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1200 3100 1350 3100
Wire Wire Line
	1350 3100 1350 2950
Wire Wire Line
	1350 2650 1350 2500
$Comp
L power:+3V3 #PWR0129
U 1 1 6078D58F
P 1350 2050
F 0 "#PWR0129" H 1350 1900 50  0001 C CNN
F 1 "+3V3" H 1365 2223 50  0000 C CNN
F 2 "" H 1350 2050 50  0001 C CNN
F 3 "" H 1350 2050 50  0001 C CNN
	1    1350 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 2050 1350 2200
Text HLabel 2050 3100 0    50   Input ~ 0
MCU_LED2
$Comp
L Device:R R2
U 1 1 607966DA
P 2200 2800
F 0 "R2" H 2270 2846 50  0000 L CNN
F 1 "470" H 2270 2755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2130 2800 50  0001 C CNN
F 3 "~" H 2200 2800 50  0001 C CNN
	1    2200 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 607966E4
P 2200 2350
F 0 "D2" V 2239 2232 50  0000 R CNN
F 1 "red" V 2148 2232 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 2200 2350 50  0001 C CNN
F 3 "~" H 2200 2350 50  0001 C CNN
	1    2200 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2050 3100 2200 3100
Wire Wire Line
	2200 3100 2200 2950
Wire Wire Line
	2200 2650 2200 2500
$Comp
L power:+3V3 #PWR0130
U 1 1 607966F1
P 2200 2050
F 0 "#PWR0130" H 2200 1900 50  0001 C CNN
F 1 "+3V3" H 2215 2223 50  0000 C CNN
F 2 "" H 2200 2050 50  0001 C CNN
F 3 "" H 2200 2050 50  0001 C CNN
	1    2200 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2050 2200 2200
Text HLabel 2950 3100 0    50   Input ~ 0
FPGA_LED1
$Comp
L Device:R R3
U 1 1 6079A682
P 3100 2800
F 0 "R3" H 3170 2846 50  0000 L CNN
F 1 "470" H 3170 2755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3030 2800 50  0001 C CNN
F 3 "~" H 3100 2800 50  0001 C CNN
	1    3100 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D3
U 1 1 6079A68C
P 3100 2350
F 0 "D3" V 3139 2232 50  0000 R CNN
F 1 "green" V 3048 2232 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3100 2350 50  0001 C CNN
F 3 "~" H 3100 2350 50  0001 C CNN
	1    3100 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 3100 3100 3100
Wire Wire Line
	3100 3100 3100 2950
Wire Wire Line
	3100 2650 3100 2500
$Comp
L power:+3V3 #PWR0131
U 1 1 6079A699
P 3100 2050
F 0 "#PWR0131" H 3100 1900 50  0001 C CNN
F 1 "+3V3" H 3115 2223 50  0000 C CNN
F 2 "" H 3100 2050 50  0001 C CNN
F 3 "" H 3100 2050 50  0001 C CNN
	1    3100 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 2050 3100 2200
Text HLabel 3750 3100 0    50   Input ~ 0
FPGA_LED2
$Comp
L Device:R R4
U 1 1 6079F6CC
P 3900 2800
F 0 "R4" H 3970 2846 50  0000 L CNN
F 1 "470" H 3970 2755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3830 2800 50  0001 C CNN
F 3 "~" H 3900 2800 50  0001 C CNN
	1    3900 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D4
U 1 1 6079F6D6
P 3900 2350
F 0 "D4" V 3939 2232 50  0000 R CNN
F 1 "red" V 3848 2232 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric" H 3900 2350 50  0001 C CNN
F 3 "~" H 3900 2350 50  0001 C CNN
	1    3900 2350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3750 3100 3900 3100
Wire Wire Line
	3900 3100 3900 2950
Wire Wire Line
	3900 2650 3900 2500
$Comp
L power:+3V3 #PWR0132
U 1 1 6079F6E3
P 3900 2050
F 0 "#PWR0132" H 3900 1900 50  0001 C CNN
F 1 "+3V3" H 3915 2223 50  0000 C CNN
F 2 "" H 3900 2050 50  0001 C CNN
F 3 "" H 3900 2050 50  0001 C CNN
	1    3900 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 2050 3900 2200
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J2
U 1 1 605143A5
P 1650 1000
F 0 "J2" H 1700 1417 50  0000 C CNN
F 1 "JTAG/C2/UART Header" H 1700 1326 50  0000 C CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_2x05_P1.27mm_Vertical" H 1650 1000 50  0001 C CNN
F 3 "~" H 1650 1000 50  0001 C CNN
	1    1650 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 1200 2100 1200
Wire Wire Line
	2100 1200 2100 1300
Wire Wire Line
	1450 800  1200 800 
Wire Wire Line
	1200 800  1200 700 
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 602EC864
P 4100 900
F 0 "H1" H 4200 949 50  0000 L CNN
F 1 "MountingHole_Pad" H 4200 858 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 4100 900 50  0001 C CNN
F 3 "~" H 4100 900 50  0001 C CNN
	1    4100 900 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 602ECFC1
P 4450 900
F 0 "H2" H 4550 949 50  0000 L CNN
F 1 "MountingHole_Pad" H 4550 858 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 4450 900 50  0001 C CNN
F 3 "~" H 4450 900 50  0001 C CNN
	1    4450 900 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 602EEC46
P 4800 900
F 0 "H3" H 4900 949 50  0000 L CNN
F 1 "MountingHole_Pad" H 4900 858 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 4800 900 50  0001 C CNN
F 3 "~" H 4800 900 50  0001 C CNN
	1    4800 900 
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 602EED6C
P 5150 900
F 0 "H4" H 5250 949 50  0000 L CNN
F 1 "MountingHole_Pad" H 5250 858 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2_Pad" H 5150 900 50  0001 C CNN
F 3 "~" H 5150 900 50  0001 C CNN
	1    5150 900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 602F5A2A
P 4100 1150
F 0 "#PWR0128" H 4100 900 50  0001 C CNN
F 1 "GND" H 4105 977 50  0000 C CNN
F 2 "" H 4100 1150 50  0001 C CNN
F 3 "" H 4100 1150 50  0001 C CNN
	1    4100 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0139
U 1 1 602F61BE
P 4450 1150
F 0 "#PWR0139" H 4450 900 50  0001 C CNN
F 1 "GND" H 4455 977 50  0000 C CNN
F 2 "" H 4450 1150 50  0001 C CNN
F 3 "" H 4450 1150 50  0001 C CNN
	1    4450 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0162
U 1 1 602F6553
P 4800 1150
F 0 "#PWR0162" H 4800 900 50  0001 C CNN
F 1 "GND" H 4805 977 50  0000 C CNN
F 2 "" H 4800 1150 50  0001 C CNN
F 3 "" H 4800 1150 50  0001 C CNN
	1    4800 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0163
U 1 1 602F6A33
P 5150 1150
F 0 "#PWR0163" H 5150 900 50  0001 C CNN
F 1 "GND" H 5155 977 50  0000 C CNN
F 2 "" H 5150 1150 50  0001 C CNN
F 3 "" H 5150 1150 50  0001 C CNN
	1    5150 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 1000 4100 1150
Wire Wire Line
	4450 1000 4450 1150
Wire Wire Line
	4800 1000 4800 1150
Wire Wire Line
	5150 1000 5150 1150
$EndSCHEMATC