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
Text HLabel 5400 2550 2    50   Output ~ 0
DCLK
Text HLabel 5400 2650 2    50   Output ~ 0
DATA0
Text HLabel 5400 2250 2    50   Output ~ 0
nCONFIG
Text HLabel 5400 2150 2    50   Input ~ 0
nSTATUS
Text HLabel 5400 2050 2    50   Input ~ 0
CONF_DONE
$Comp
L MCU_SiliconLabs:EFM8BB10F8G-A-QFN20 U6
U 1 1 6074B974
P 4300 2450
F 0 "U6" H 4300 3331 50  0000 C CNN
F 1 "EFM8BB21F16I-C-QFN20" H 4300 3240 50  0000 C CNN
F 2 "ik:SiliconLabs_QFN-20-1EP_3x3mm_P0.5mm_EP1.8x1.8mm" H 4300 3250 50  0001 C CNN
F 3 "https://www.silabs.com/documents/public/data-sheets/efm8bb1-datasheet.pdf" H 4300 2450 50  0001 C CNN
	1    4300 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 6074CE22
P 3150 1750
F 0 "R5" H 3220 1796 50  0000 L CNN
F 1 "10k" H 3220 1705 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3080 1750 50  0001 C CNN
F 3 "~" H 3150 1750 50  0001 C CNN
	1    3150 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C41
U 1 1 6074D1A6
P 2300 1750
F 0 "C41" H 2415 1796 50  0000 L CNN
F 1 "1uF" H 2415 1705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2338 1600 50  0001 C CNN
F 3 "~" H 2300 1750 50  0001 C CNN
	1    2300 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C42
U 1 1 6074D56D
P 2650 1750
F 0 "C42" H 2765 1796 50  0000 L CNN
F 1 "0.1uF" H 2765 1705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2688 1600 50  0001 C CNN
F 3 "~" H 2650 1750 50  0001 C CNN
	1    2650 1750
	1    0    0    -1  
$EndComp
Text HLabel 5400 2750 2    50   BiDi ~ 0
C2D
Text HLabel 3000 2050 0    50   BiDi ~ 0
C2CK
$Comp
L power:+3V3 #PWR0133
U 1 1 6074E0A2
P 3150 1300
F 0 "#PWR0133" H 3150 1150 50  0001 C CNN
F 1 "+3V3" H 3165 1473 50  0000 C CNN
F 2 "" H 3150 1300 50  0001 C CNN
F 3 "" H 3150 1300 50  0001 C CNN
	1    3150 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0134
U 1 1 6074E469
P 4300 3450
F 0 "#PWR0134" H 4300 3200 50  0001 C CNN
F 1 "GND" H 4305 3277 50  0000 C CNN
F 2 "" H 4300 3450 50  0001 C CNN
F 3 "" H 4300 3450 50  0001 C CNN
	1    4300 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 1300 3150 1450
Wire Wire Line
	3150 1900 3150 2050
Wire Wire Line
	3150 2050 3600 2050
Wire Wire Line
	3000 2050 3150 2050
Connection ~ 3150 2050
Wire Wire Line
	3150 1450 4300 1450
Wire Wire Line
	4300 1450 4300 1750
Connection ~ 3150 1450
Wire Wire Line
	3150 1450 3150 1600
Wire Wire Line
	3150 1450 2650 1450
Wire Wire Line
	2300 1450 2300 1600
Wire Wire Line
	2650 1450 2650 1600
Connection ~ 2650 1450
Wire Wire Line
	2650 1450 2300 1450
Wire Wire Line
	2650 1900 2650 3350
Wire Wire Line
	2650 3350 4300 3350
Wire Wire Line
	4300 3350 4300 3450
Wire Wire Line
	4300 3350 4300 3150
Connection ~ 4300 3350
Wire Wire Line
	2300 1900 2300 3350
Wire Wire Line
	2300 3350 2650 3350
Connection ~ 2650 3350
Wire Wire Line
	5400 2750 5000 2750
Text HLabel 3100 2550 0    50   Output ~ 0
UART0_TX
Text HLabel 3100 2650 0    50   Input ~ 0
UART0_RX
Wire Wire Line
	3100 2550 3600 2550
Wire Wire Line
	3100 2650 3600 2650
Wire Wire Line
	3050 2150 3600 2150
Wire Wire Line
	3050 2350 3600 2350
Wire Wire Line
	5000 2050 5400 2050
Wire Wire Line
	5000 2150 5400 2150
Wire Wire Line
	5000 2250 5400 2250
Text HLabel 5400 2350 2    50   Output ~ 0
MCU_LED1
Text HLabel 5400 2450 2    50   Output ~ 0
MCU_LED2
Wire Wire Line
	5000 2350 5400 2350
Wire Wire Line
	5000 2450 5400 2450
Text HLabel 3100 2750 0    50   Input ~ 0
UART1_RX
Wire Wire Line
	3100 2750 3600 2750
Text HLabel 3100 2450 0    50   Input ~ 0
UART1_TX
Wire Wire Line
	3100 2450 3600 2450
Wire Wire Line
	5000 2550 5400 2550
Wire Wire Line
	5000 2650 5400 2650
Wire Wire Line
	3600 2250 3050 2250
Text Label 3050 2150 0    50   ~ 0
SPI_SCK
Text Label 3050 2250 0    50   ~ 0
SPI_MISO
Text Label 3050 2350 0    50   ~ 0
SPI_MOSI
Wire Wire Line
	3600 2850 3050 2850
Text Label 3050 2850 0    50   ~ 0
SPI_CS_N
$Comp
L Memory_Flash:W25Q32JVSS U5
U 1 1 5FF249B0
P 4250 5150
F 0 "U5" H 4250 5731 50  0000 C CNN
F 1 "W25Q80DVSNIG" H 4250 5640 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4250 5150 50  0001 C CNN
F 3 "" H 4250 5150 50  0001 C CNN
	1    4250 5150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0135
U 1 1 5FF264FD
P 4250 4400
F 0 "#PWR0135" H 4250 4250 50  0001 C CNN
F 1 "+3V3" H 4265 4573 50  0000 C CNN
F 2 "" H 4250 4400 50  0001 C CNN
F 3 "" H 4250 4400 50  0001 C CNN
	1    4250 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 4400 4250 4500
$Comp
L power:GND #PWR0136
U 1 1 5FF27675
P 4250 6000
F 0 "#PWR0136" H 4250 5750 50  0001 C CNN
F 1 "GND" H 4255 5827 50  0000 C CNN
F 2 "" H 4250 6000 50  0001 C CNN
F 3 "" H 4250 6000 50  0001 C CNN
	1    4250 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 5550 4250 6000
$Comp
L Device:R R6
U 1 1 5FF28992
P 3450 4800
F 0 "R6" H 3520 4846 50  0000 L CNN
F 1 "10k" H 3520 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3380 4800 50  0001 C CNN
F 3 "~" H 3450 4800 50  0001 C CNN
	1    3450 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 4950 3450 5050
Wire Wire Line
	3450 5050 3750 5050
Wire Wire Line
	3450 4650 3450 4500
Wire Wire Line
	3450 4500 4250 4500
Connection ~ 4250 4500
Wire Wire Line
	4250 4500 4250 4750
Wire Wire Line
	3450 5050 2950 5050
Connection ~ 3450 5050
Text Label 2950 5050 0    50   ~ 0
SPI_CS_N
Wire Wire Line
	2950 5250 3750 5250
Text Label 2950 5250 0    50   ~ 0
SPI_SCK
Wire Wire Line
	4750 4950 5350 4950
Text Label 5350 4950 0    50   ~ 0
SPI_MOSI
Wire Wire Line
	4750 5050 5350 5050
Text Label 5350 5050 0    50   ~ 0
SPI_MISO
Wire Wire Line
	4750 5250 5850 5250
Wire Wire Line
	4750 5350 6200 5350
Text Label 6400 5250 0    50   ~ 0
WP_N
$Comp
L Device:R R7
U 1 1 5FF2FA83
P 5850 4800
F 0 "R7" H 5920 4846 50  0000 L CNN
F 1 "10k" H 5920 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5780 4800 50  0001 C CNN
F 3 "~" H 5850 4800 50  0001 C CNN
	1    5850 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5FF2FEB4
P 6200 4800
F 0 "R8" H 6270 4846 50  0000 L CNN
F 1 "10k" H 6270 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6130 4800 50  0001 C CNN
F 3 "~" H 6200 4800 50  0001 C CNN
	1    6200 4800
	1    0    0    -1  
$EndComp
Text Label 6400 5350 0    50   ~ 0
HOLD_N
Wire Wire Line
	5850 4950 5850 5250
Connection ~ 5850 5250
Wire Wire Line
	5850 5250 6400 5250
Wire Wire Line
	6200 4950 6200 5350
Connection ~ 6200 5350
Wire Wire Line
	6200 5350 6400 5350
Wire Wire Line
	5850 4650 5850 4500
Wire Wire Line
	5850 4500 4250 4500
Wire Wire Line
	6200 4650 6200 4500
Wire Wire Line
	6200 4500 5850 4500
Connection ~ 5850 4500
$EndSCHEMATC
