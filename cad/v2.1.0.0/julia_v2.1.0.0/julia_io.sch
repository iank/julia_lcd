EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 7
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
Text HLabel 1150 1000 0    50   Output ~ 0
TMS
Text HLabel 1150 800  0    50   Output ~ 0
TCK
Text HLabel 1150 900  0    50   Input ~ 0
TDO
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J2
U 1 1 605143A5
P 1650 1000
F 0 "J2" H 1700 1417 50  0000 C CNN
F 1 "JTAG Header" H 1700 1326 50  0000 C CNN
F 2 "" H 1650 1000 50  0001 C CNN
F 3 "~" H 1650 1000 50  0001 C CNN
	1    1650 1000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0125
U 1 1 60515CBE
P 2150 700
F 0 "#PWR0125" H 2150 550 50  0001 C CNN
F 1 "+3V3" H 2165 873 50  0000 C CNN
F 2 "" H 2150 700 50  0001 C CNN
F 3 "" H 2150 700 50  0001 C CNN
	1    2150 700 
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
NoConn ~ 1450 1100
NoConn ~ 1950 1100
NoConn ~ 1950 1000
Wire Wire Line
	1150 800  1450 800 
Wire Wire Line
	1150 900  1450 900 
Wire Wire Line
	1150 1000 1450 1000
Wire Wire Line
	1150 1200 1450 1200
Wire Wire Line
	1950 1200 2100 1200
Wire Wire Line
	1950 900  2150 900 
Wire Wire Line
	2150 700  2150 900 
Wire Wire Line
	1950 800  2100 800 
Wire Wire Line
	2100 800  2100 1200
Wire Wire Line
	2100 1200 2100 1300
Connection ~ 2100 1200
Text Notes 1400 1350 0    50   ~ 0
Key on odd side
Text HLabel 2900 1050 0    50   BiDi ~ 0
C2D
Text HLabel 2900 1150 0    50   BiDi ~ 0
C2CK
Text HLabel 4000 950  2    50   Input ~ 0
UART0_TX
Text HLabel 4000 1050 2    50   Output ~ 0
UART0_RX
Text HLabel 1200 3100 0    50   Input ~ 0
MCU_LED1
$Comp
L power:+3V3 #PWR0127
U 1 1 6077B2CF
P 2900 700
F 0 "#PWR0127" H 2900 550 50  0001 C CNN
F 1 "+3V3" H 2915 873 50  0000 C CNN
F 2 "" H 2900 700 50  0001 C CNN
F 3 "" H 2900 700 50  0001 C CNN
	1    2900 700 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 6077B7DB
P 3850 1350
F 0 "#PWR0128" H 3850 1100 50  0001 C CNN
F 1 "GND" H 3855 1177 50  0000 C CNN
F 2 "" H 3850 1350 50  0001 C CNN
F 3 "" H 3850 1350 50  0001 C CNN
	1    3850 1350
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J3
U 1 1 6077C6A3
P 3400 1050
F 0 "J3" H 3450 1367 50  0000 C CNN
F 1 "MCU Debug Interface / UART" H 3450 1276 50  0000 C CNN
F 2 "" H 3400 1050 50  0001 C CNN
F 3 "~" H 3400 1050 50  0001 C CNN
	1    3400 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 700  2900 950 
Wire Wire Line
	2900 950  3200 950 
Wire Wire Line
	3850 1350 3850 1150
Wire Wire Line
	3850 1150 3700 1150
Wire Wire Line
	2900 1050 3200 1050
Wire Wire Line
	2900 1150 3200 1150
Wire Wire Line
	3700 950  4000 950 
Wire Wire Line
	3700 1050 4000 1050
$Comp
L Device:R R1
U 1 1 60789387
P 1350 2800
F 0 "R1" H 1420 2846 50  0000 L CNN
F 1 "470" H 1420 2755 50  0000 L CNN
F 2 "" V 1280 2800 50  0001 C CNN
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
F 2 "" H 1350 2350 50  0001 C CNN
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
F 2 "" V 2130 2800 50  0001 C CNN
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
F 2 "" H 2200 2350 50  0001 C CNN
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
F 2 "" V 3030 2800 50  0001 C CNN
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
F 2 "" H 3100 2350 50  0001 C CNN
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
F 2 "" V 3830 2800 50  0001 C CNN
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
F 2 "" H 3900 2350 50  0001 C CNN
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
$EndSCHEMATC
