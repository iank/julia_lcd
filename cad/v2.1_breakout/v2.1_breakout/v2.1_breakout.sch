EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L Connector_Generic:Conn_02x05_Odd_Even J1
U 1 1 615C0E8F
P 2100 1650
F 0 "J1" H 2150 2067 50  0000 C CNN
F 1 "Altera Byte Blaster" H 2150 1976 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x05_P2.54mm_Vertical" H 2100 1650 50  0001 C CNN
F 3 "~" H 2100 1650 50  0001 C CNN
	1    2100 1650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J3
U 1 1 615C1A2D
P 3500 1650
F 0 "J3" H 3550 2067 50  0000 C CNN
F 1 "SiLabs USB Debug Header" H 3550 1976 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x05_P2.54mm_Vertical" H 3500 1650 50  0001 C CNN
F 3 "~" H 3500 1650 50  0001 C CNN
	1    3500 1650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J4
U 1 1 615C5D22
P 4600 2200
F 0 "J4" H 4680 2192 50  0000 L CNN
F 1 "UART" H 4680 2101 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 4600 2200 50  0001 C CNN
F 3 "~" H 4600 2200 50  0001 C CNN
	1    4600 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 2600 2550 2600
Wire Wire Line
	2600 2700 2500 2700
Wire Wire Line
	2600 2800 2450 2800
Wire Wire Line
	2600 2900 2400 2900
Wire Wire Line
	2600 3000 2350 3000
Wire Wire Line
	3100 3000 3200 3000
Wire Wire Line
	3100 2900 3250 2900
Wire Wire Line
	3100 2800 3300 2800
Wire Wire Line
	3100 2700 3350 2700
Wire Wire Line
	3100 2600 3400 2600
Text Notes 2400 2000 0    50   ~ 0
Locating keys on odd sides
$Comp
L Connector_Generic:Conn_02x05_Top_Bottom J2
U 1 1 615CD619
P 2800 2800
F 0 "J2" H 2850 3217 50  0000 C CNN
F 1 "Julia v2.1.0.0 connector" H 2850 3126 50  0000 C CNN
F 2 "ik:Hirose_DF23_DF23C-10DS-0.5V_2x05_P0.50mm_Vertical" H 2800 2800 50  0001 C CNN
F 3 "~" H 2800 2800 50  0001 C CNN
	1    2800 2800
	1    0    0    -1  
$EndComp
Text Label 2200 2600 0    50   ~ 0
+3V3
Text Label 2200 2700 0    50   ~ 0
UART0_TX
Text Label 2200 2800 0    50   ~ 0
TCK
Text Label 2200 2900 0    50   ~ 0
UART0_RX
Text Label 2200 3000 0    50   ~ 0
TDO
Text Label 3450 3000 0    50   ~ 0
GND
Text Label 3450 2900 0    50   ~ 0
TDI
Text Label 3450 2800 0    50   ~ 0
C2D
Text Label 3450 2700 0    50   ~ 0
TMS
Text Label 3450 2600 0    50   ~ 0
C2CK
$Comp
L Connector:TestPoint TP10
U 1 1 615D37E1
P 3400 2600
F 0 "TP10" H 3458 2672 50  0000 L CNN
F 1 "TestPoint" H 3458 2627 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3600 2600 50  0001 C CNN
F 3 "~" H 3600 2600 50  0001 C CNN
	1    3400 2600
	1    0    0    -1  
$EndComp
Connection ~ 3400 2600
Wire Wire Line
	3400 2600 3450 2600
$Comp
L Connector:TestPoint TP9
U 1 1 615D41BF
P 3350 2700
F 0 "TP9" H 3408 2772 50  0000 L CNN
F 1 "TestPoint" H 3408 2727 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3550 2700 50  0001 C CNN
F 3 "~" H 3550 2700 50  0001 C CNN
	1    3350 2700
	1    0    0    -1  
$EndComp
Connection ~ 3350 2700
Wire Wire Line
	3350 2700 3450 2700
$Comp
L Connector:TestPoint TP8
U 1 1 615D44E7
P 3300 2800
F 0 "TP8" H 3358 2872 50  0000 L CNN
F 1 "TestPoint" H 3358 2827 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3500 2800 50  0001 C CNN
F 3 "~" H 3500 2800 50  0001 C CNN
	1    3300 2800
	1    0    0    -1  
$EndComp
Connection ~ 3300 2800
Wire Wire Line
	3300 2800 3450 2800
$Comp
L Connector:TestPoint TP7
U 1 1 615D47A1
P 3250 2900
F 0 "TP7" H 3308 2972 50  0000 L CNN
F 1 "TestPoint" H 3308 2927 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3450 2900 50  0001 C CNN
F 3 "~" H 3450 2900 50  0001 C CNN
	1    3250 2900
	1    0    0    -1  
$EndComp
Connection ~ 3250 2900
Wire Wire Line
	3250 2900 3450 2900
$Comp
L Connector:TestPoint TP6
U 1 1 615D4ACA
P 3200 3000
F 0 "TP6" H 3258 3072 50  0000 L CNN
F 1 "TestPoint" H 3258 3027 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 3400 3000 50  0001 C CNN
F 3 "~" H 3400 3000 50  0001 C CNN
	1    3200 3000
	1    0    0    -1  
$EndComp
Connection ~ 3200 3000
Wire Wire Line
	3200 3000 3450 3000
$Comp
L Connector:TestPoint TP5
U 1 1 615D4E08
P 2550 2600
F 0 "TP5" H 2608 2672 50  0000 L CNN
F 1 "TestPoint" H 2608 2627 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 2750 2600 50  0001 C CNN
F 3 "~" H 2750 2600 50  0001 C CNN
	1    2550 2600
	1    0    0    -1  
$EndComp
Connection ~ 2550 2600
Wire Wire Line
	2550 2600 2200 2600
$Comp
L Connector:TestPoint TP4
U 1 1 615D5375
P 2500 2700
F 0 "TP4" H 2558 2772 50  0000 L CNN
F 1 "TestPoint" H 2558 2727 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 2700 2700 50  0001 C CNN
F 3 "~" H 2700 2700 50  0001 C CNN
	1    2500 2700
	1    0    0    -1  
$EndComp
Connection ~ 2500 2700
Wire Wire Line
	2500 2700 2200 2700
$Comp
L Connector:TestPoint TP3
U 1 1 615D56C7
P 2450 2800
F 0 "TP3" H 2508 2872 50  0000 L CNN
F 1 "TestPoint" H 2508 2827 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 2650 2800 50  0001 C CNN
F 3 "~" H 2650 2800 50  0001 C CNN
	1    2450 2800
	1    0    0    -1  
$EndComp
Connection ~ 2450 2800
Wire Wire Line
	2450 2800 2200 2800
$Comp
L Connector:TestPoint TP2
U 1 1 615D5A9F
P 2400 2900
F 0 "TP2" H 2458 2972 50  0000 L CNN
F 1 "TestPoint" H 2458 2927 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 2600 2900 50  0001 C CNN
F 3 "~" H 2600 2900 50  0001 C CNN
	1    2400 2900
	1    0    0    -1  
$EndComp
Connection ~ 2400 2900
Wire Wire Line
	2400 2900 2200 2900
$Comp
L Connector:TestPoint TP1
U 1 1 615D5E6F
P 2350 3000
F 0 "TP1" H 2408 3072 50  0000 L CNN
F 1 "TestPoint" H 2408 3027 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 2550 3000 50  0001 C CNN
F 3 "~" H 2550 3000 50  0001 C CNN
	1    2350 3000
	1    0    0    -1  
$EndComp
Connection ~ 2350 3000
Wire Wire Line
	2350 3000 2200 3000
NoConn ~ 3300 1450
NoConn ~ 3800 1750
NoConn ~ 3300 1650
NoConn ~ 3800 1650
Wire Wire Line
	3800 1450 4100 1450
Text Label 4100 1450 0    50   ~ 0
GND
Wire Wire Line
	3800 1550 4100 1550
Text Label 4100 1550 0    50   ~ 0
C2D
Wire Wire Line
	3300 1750 3000 1750
Text Label 3000 1750 0    50   ~ 0
C2CK
Wire Wire Line
	3300 1550 3000 1550
Text Label 3000 1550 0    50   ~ 0
GND
Wire Wire Line
	3300 1850 3000 1850
Text Label 3000 1850 0    50   ~ 0
GND
Wire Wire Line
	4400 2100 4050 2100
Text Label 4050 2100 0    50   ~ 0
+3V3
Wire Wire Line
	4400 2400 4050 2400
Text Label 4050 2400 0    50   ~ 0
GND
Wire Wire Line
	4050 2200 4400 2200
Wire Wire Line
	4400 2300 4050 2300
Text Label 4050 2300 0    50   ~ 0
UART0_RX
Text Label 4050 2200 0    50   ~ 0
UART0_TX
NoConn ~ 3800 1850
Text Notes 3850 1900 0    50   ~ 0
Pin 10 is 5V from debug adapter
Wire Wire Line
	1900 1450 1600 1450
Wire Wire Line
	1900 1550 1600 1550
Wire Wire Line
	1900 1650 1600 1650
Wire Wire Line
	1900 1850 1600 1850
Wire Wire Line
	2400 1850 2700 1850
Wire Wire Line
	2400 1550 2700 1550
Wire Wire Line
	2400 1450 2700 1450
Text Label 2700 1450 0    50   ~ 0
GND
Text Label 2700 1550 0    50   ~ 0
+3V3
Text Label 2700 1850 0    50   ~ 0
GND
Text Label 1600 1850 0    50   ~ 0
TDI
Text Label 1600 1650 0    50   ~ 0
TMS
Text Label 1600 1550 0    50   ~ 0
TDO
Text Label 1600 1450 0    50   ~ 0
TCK
NoConn ~ 2400 1750
NoConn ~ 2400 1650
NoConn ~ 1900 1750
$EndSCHEMATC
