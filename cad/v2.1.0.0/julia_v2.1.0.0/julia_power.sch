EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 7
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
L Regulator_Linear:AZ1117-3.3 U2
U 1 1 60156AD2
P 3650 1250
F 0 "U2" H 3650 1492 50  0000 C CNN
F 1 "AZ1117-3.3" H 3650 1401 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 3650 1500 50  0001 C CIN
F 3 "https://www.diodes.com/assets/Datasheets/AZ1117.pdf" H 3650 1250 50  0001 C CNN
	1    3650 1250
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:AZ1117-2.5 U3
U 1 1 60157102
P 3650 2350
F 0 "U3" H 3650 2592 50  0000 C CNN
F 1 "AZ1117-2.5" H 3650 2501 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 3650 2600 50  0001 C CIN
F 3 "https://www.diodes.com/assets/Datasheets/AZ1117.pdf" H 3650 2350 50  0001 C CNN
	1    3650 2350
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:AZ1117-1.2 U4
U 1 1 60158A64
P 3650 3400
F 0 "U4" H 3650 3642 50  0000 C CNN
F 1 "NCP565ST12T3G" H 3650 3551 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 3650 3650 50  0001 C CIN
F 3 "https://www.diodes.com/assets/Datasheets/AZ1117.pdf" H 3650 3400 50  0001 C CNN
	1    3650 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+2V5 #PWR0101
U 1 1 60159910
P 4200 2150
F 0 "#PWR0101" H 4200 2000 50  0001 C CNN
F 1 "+2V5" H 4215 2323 50  0000 C CNN
F 2 "" H 4200 2150 50  0001 C CNN
F 3 "" H 4200 2150 50  0001 C CNN
	1    4200 2150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 60159CB4
P 1950 2000
F 0 "#PWR0102" H 1950 1750 50  0001 C CNN
F 1 "GND" H 1955 1827 50  0000 C CNN
F 2 "" H 1950 2000 50  0001 C CNN
F 3 "" H 1950 2000 50  0001 C CNN
	1    1950 2000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0103
U 1 1 60159F42
P 2650 3200
F 0 "#PWR0103" H 2650 3050 50  0001 C CNN
F 1 "+3V3" H 2665 3373 50  0000 C CNN
F 2 "" H 2650 3200 50  0001 C CNN
F 3 "" H 2650 3200 50  0001 C CNN
	1    2650 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0104
U 1 1 6015A240
P 4650 3200
F 0 "#PWR0104" H 4650 3050 50  0001 C CNN
F 1 "+1V2" H 4665 3373 50  0000 C CNN
F 2 "" H 4650 3200 50  0001 C CNN
F 3 "" H 4650 3200 50  0001 C CNN
	1    4650 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0105
U 1 1 6015A662
P 1950 1500
F 0 "#PWR0105" H 1950 1350 50  0001 C CNN
F 1 "+5V" H 1965 1673 50  0000 C CNN
F 2 "" H 1950 1500 50  0001 C CNN
F 3 "" H 1950 1500 50  0001 C CNN
	1    1950 1500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack_Switch J1
U 1 1 6015B056
P 1000 1800
F 0 "J1" H 1057 2117 50  0000 C CNN
F 1 "Barrel_Jack_Switch" H 1057 2026 50  0000 C CNN
F 2 "ik:BarrelJack_GCT_DCJ200-05-A-K1-A_SMD_Horizontal" H 1050 1760 50  0001 C CNN
F 3 "~" H 1050 1760 50  0001 C CNN
	1    1000 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 1800 1950 1800
Wire Wire Line
	1950 1800 1950 1900
Wire Wire Line
	1300 1900 1950 1900
Connection ~ 1950 1900
Wire Wire Line
	1950 1900 1950 2000
$Comp
L Device:Fuse_Small F1
U 1 1 601632E6
P 1650 1700
F 0 "F1" H 1650 1885 50  0000 C CNN
F 1 "Fuse_Small" H 1650 1794 50  0000 C CNN
F 2 "Fuse:Fuse_1206_3216Metric" H 1650 1700 50  0001 C CNN
F 3 "~" H 1650 1700 50  0001 C CNN
	1    1650 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 1700 1550 1700
Wire Wire Line
	1750 1700 1950 1700
Wire Wire Line
	1950 1700 1950 1500
$Comp
L power:+5V #PWR0106
U 1 1 60166112
P 3050 1100
F 0 "#PWR0106" H 3050 950 50  0001 C CNN
F 1 "+5V" H 3065 1273 50  0000 C CNN
F 2 "" H 3050 1100 50  0001 C CNN
F 3 "" H 3050 1100 50  0001 C CNN
	1    3050 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0107
U 1 1 6016BE13
P 4200 1100
F 0 "#PWR0107" H 4200 950 50  0001 C CNN
F 1 "+3V3" H 4215 1273 50  0000 C CNN
F 2 "" H 4200 1100 50  0001 C CNN
F 3 "" H 4200 1100 50  0001 C CNN
	1    4200 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0108
U 1 1 60172CE2
P 3050 2150
F 0 "#PWR0108" H 3050 2000 50  0001 C CNN
F 1 "+5V" H 3065 2323 50  0000 C CNN
F 2 "" H 3050 2150 50  0001 C CNN
F 3 "" H 3050 2150 50  0001 C CNN
	1    3050 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 601739C9
P 3150 3650
F 0 "C10" H 3265 3696 50  0000 L CNN
F 1 "0.1uF" H 3265 3605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3188 3500 50  0001 C CNN
F 3 "~" H 3150 3650 50  0001 C CNN
	1    3150 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 6017852D
P 4150 3650
F 0 "C13" H 4265 3696 50  0000 L CNN
F 1 "0.1uF" H 4265 3605 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4188 3500 50  0001 C CNN
F 3 "~" H 4150 3650 50  0001 C CNN
	1    4150 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C5
U 1 1 60178C85
P 2650 3650
F 0 "C5" H 2768 3696 50  0000 L CNN
F 1 "4.7uF" H 2768 3605 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-2012-15_AVX-P" H 2688 3500 50  0001 C CNN
F 3 "~" H 2650 3650 50  0001 C CNN
	1    2650 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C17
U 1 1 60179216
P 4650 3650
F 0 "C17" H 4768 3696 50  0000 L CNN
F 1 "4.7uF" H 4768 3605 50  0000 L CNN
F 2 "Capacitor_Tantalum_SMD:CP_EIA-2012-15_AVX-P" H 4688 3500 50  0001 C CNN
F 3 "~" H 4650 3650 50  0001 C CNN
	1    4650 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 6017BAE4
P 3650 4050
F 0 "#PWR0109" H 3650 3800 50  0001 C CNN
F 1 "GND" H 3655 3877 50  0000 C CNN
F 2 "" H 3650 4050 50  0001 C CNN
F 3 "" H 3650 4050 50  0001 C CNN
	1    3650 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 3200 2650 3400
Wire Wire Line
	2650 3400 3150 3400
Wire Wire Line
	2650 3500 2650 3400
Connection ~ 2650 3400
Wire Wire Line
	3150 3500 3150 3400
Connection ~ 3150 3400
Wire Wire Line
	3150 3400 3350 3400
Wire Wire Line
	2650 3800 2650 3950
Wire Wire Line
	2650 3950 3150 3950
Wire Wire Line
	4650 3950 4650 3800
Wire Wire Line
	4650 3500 4650 3400
Wire Wire Line
	4650 3400 4150 3400
Connection ~ 4650 3400
Wire Wire Line
	4650 3400 4650 3200
Wire Wire Line
	4150 3500 4150 3400
Connection ~ 4150 3400
Wire Wire Line
	4150 3400 3950 3400
Wire Wire Line
	4150 3800 4150 3950
Connection ~ 4150 3950
Wire Wire Line
	4150 3950 4650 3950
Wire Wire Line
	3150 3800 3150 3950
Connection ~ 3150 3950
Wire Wire Line
	3150 3950 3650 3950
Wire Wire Line
	3650 3700 3650 3950
Connection ~ 3650 3950
Wire Wire Line
	3650 3950 4150 3950
Wire Wire Line
	3650 4050 3650 3950
$Comp
L Device:C C7
U 1 1 601831D3
P 3050 1500
F 0 "C7" H 3165 1546 50  0000 L CNN
F 1 "10uF" H 3165 1455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3088 1350 50  0001 C CNN
F 3 "~" H 3050 1500 50  0001 C CNN
	1    3050 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 60187FBC
P 3650 1800
F 0 "#PWR0110" H 3650 1550 50  0001 C CNN
F 1 "GND" H 3655 1627 50  0000 C CNN
F 2 "" H 3650 1800 50  0001 C CNN
F 3 "" H 3650 1800 50  0001 C CNN
	1    3650 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 1650 3050 1700
Wire Wire Line
	3050 1700 3650 1700
Wire Wire Line
	3650 1700 3650 1550
Wire Wire Line
	3650 1800 3650 1700
Connection ~ 3650 1700
Wire Wire Line
	3050 1100 3050 1250
Wire Wire Line
	3350 1250 3050 1250
Connection ~ 3050 1250
Wire Wire Line
	3050 1250 3050 1350
$Comp
L Device:C C14
U 1 1 6018B080
P 4200 1500
F 0 "C14" H 4315 1546 50  0000 L CNN
F 1 "22uF" H 4315 1455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4238 1350 50  0001 C CNN
F 3 "~" H 4200 1500 50  0001 C CNN
	1    4200 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 1700 4200 1700
Wire Wire Line
	4200 1700 4200 1650
Wire Wire Line
	4200 1350 4200 1250
Wire Wire Line
	4200 1250 3950 1250
Connection ~ 4200 1250
Wire Wire Line
	4200 1250 4200 1100
$Comp
L Device:C C15
U 1 1 601A6E7B
P 4200 2600
F 0 "C15" H 4315 2646 50  0000 L CNN
F 1 "22uF" H 4315 2555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4238 2450 50  0001 C CNN
F 3 "~" H 4200 2600 50  0001 C CNN
	1    4200 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 601A757E
P 3050 2600
F 0 "C8" H 3165 2646 50  0000 L CNN
F 1 "10uF" H 3165 2555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3088 2450 50  0001 C CNN
F 3 "~" H 3050 2600 50  0001 C CNN
	1    3050 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2150 3050 2350
Wire Wire Line
	3050 2350 3350 2350
Connection ~ 3050 2350
Wire Wire Line
	3050 2350 3050 2450
$Comp
L power:GND #PWR0111
U 1 1 601A9018
P 3650 2850
F 0 "#PWR0111" H 3650 2600 50  0001 C CNN
F 1 "GND" H 3655 2677 50  0000 C CNN
F 2 "" H 3650 2850 50  0001 C CNN
F 3 "" H 3650 2850 50  0001 C CNN
	1    3650 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2650 3650 2800
Wire Wire Line
	3050 2750 3050 2800
Wire Wire Line
	3050 2800 3650 2800
Connection ~ 3650 2800
Wire Wire Line
	3650 2800 3650 2850
Wire Wire Line
	3650 2800 4200 2800
Wire Wire Line
	4200 2800 4200 2750
Wire Wire Line
	4200 2450 4200 2350
Wire Wire Line
	4200 2350 3950 2350
Connection ~ 4200 2350
Wire Wire Line
	4200 2350 4200 2150
$Comp
L Connector:TestPoint TP1
U 1 1 601B7C9B
P 5250 1250
F 0 "TP1" H 5192 1322 50  0000 R CNN
F 1 "TestPoint" H 5192 1367 50  0001 R CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 5450 1250 50  0001 C CNN
F 3 "~" H 5450 1250 50  0001 C CNN
	1    5250 1250
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 601B8ECF
P 5500 1250
F 0 "TP2" H 5442 1322 50  0000 R CNN
F 1 "TestPoint" H 5442 1367 50  0001 R CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 5700 1250 50  0001 C CNN
F 3 "~" H 5700 1250 50  0001 C CNN
	1    5500 1250
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP3
U 1 1 601B9390
P 5750 1250
F 0 "TP3" H 5692 1322 50  0000 R CNN
F 1 "TestPoint" H 5692 1367 50  0001 R CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 5950 1250 50  0001 C CNN
F 3 "~" H 5950 1250 50  0001 C CNN
	1    5750 1250
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 601B97B5
P 6000 1250
F 0 "TP4" H 5942 1322 50  0000 R CNN
F 1 "TestPoint" H 5942 1367 50  0001 R CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 6200 1250 50  0001 C CNN
F 3 "~" H 6200 1250 50  0001 C CNN
	1    6000 1250
	-1   0    0    1   
$EndComp
$Comp
L power:+3V3 #PWR0112
U 1 1 601C1A7E
P 5500 1050
F 0 "#PWR0112" H 5500 900 50  0001 C CNN
F 1 "+3V3" H 5515 1223 50  0000 C CNN
F 2 "" H 5500 1050 50  0001 C CNN
F 3 "" H 5500 1050 50  0001 C CNN
	1    5500 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0113
U 1 1 601C2008
P 5250 1050
F 0 "#PWR0113" H 5250 900 50  0001 C CNN
F 1 "+5V" H 5265 1223 50  0000 C CNN
F 2 "" H 5250 1050 50  0001 C CNN
F 3 "" H 5250 1050 50  0001 C CNN
	1    5250 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+2V5 #PWR0114
U 1 1 601C24E5
P 5750 1050
F 0 "#PWR0114" H 5750 900 50  0001 C CNN
F 1 "+2V5" H 5765 1223 50  0000 C CNN
F 2 "" H 5750 1050 50  0001 C CNN
F 3 "" H 5750 1050 50  0001 C CNN
	1    5750 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0115
U 1 1 601C2A29
P 6000 1050
F 0 "#PWR0115" H 6000 900 50  0001 C CNN
F 1 "+1V2" H 6015 1223 50  0000 C CNN
F 2 "" H 6000 1050 50  0001 C CNN
F 3 "" H 6000 1050 50  0001 C CNN
	1    6000 1050
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP5
U 1 1 601C2F60
P 6250 1100
F 0 "TP5" H 6308 1172 50  0000 L CNN
F 1 "TestPoint" H 6308 1127 50  0001 L CNN
F 2 "TestPoint:TestPoint_THTPad_D1.0mm_Drill0.5mm" H 6450 1100 50  0001 C CNN
F 3 "~" H 6450 1100 50  0001 C CNN
	1    6250 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 601C34F0
P 6250 1300
F 0 "#PWR0116" H 6250 1050 50  0001 C CNN
F 1 "GND" H 6255 1127 50  0000 C CNN
F 2 "" H 6250 1300 50  0001 C CNN
F 3 "" H 6250 1300 50  0001 C CNN
	1    6250 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 1050 5250 1250
Wire Wire Line
	5500 1050 5500 1250
Wire Wire Line
	5750 1050 5750 1250
Wire Wire Line
	6000 1050 6000 1250
Wire Wire Line
	6250 1100 6250 1300
$Comp
L Device:C C24
U 1 1 601E6B9C
P 6750 4200
F 0 "C24" H 6865 4246 50  0000 L CNN
F 1 "0.1uF" H 6865 4155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6788 4050 50  0001 C CNN
F 3 "~" H 6750 4200 50  0001 C CNN
	1    6750 4200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C27
U 1 1 601E96E2
P 7200 4200
F 0 "C27" H 7315 4246 50  0000 L CNN
F 1 "0.1uF" H 7315 4155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7238 4050 50  0001 C CNN
F 3 "~" H 7200 4200 50  0001 C CNN
	1    7200 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 5900 6200 6000
Wire Wire Line
	5750 5900 5750 6000
Wire Wire Line
	6200 5600 6200 5550
Wire Wire Line
	5750 5600 5750 5550
Wire Wire Line
	6850 6100 6850 6000
Wire Wire Line
	5600 5500 5600 5550
$Comp
L power:GND #PWR0117
U 1 1 6020D2AD
P 6850 6100
F 0 "#PWR0117" H 6850 5850 50  0001 C CNN
F 1 "GND" H 6855 5927 50  0000 C CNN
F 2 "" H 6850 6100 50  0001 C CNN
F 3 "" H 6850 6100 50  0001 C CNN
	1    6850 6100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C38
U 1 1 6020C7C1
P 6200 5750
F 0 "C38" H 6315 5796 50  0000 L CNN
F 1 "0.1uF" H 6315 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6238 5600 50  0001 C CNN
F 3 "~" H 6200 5750 50  0001 C CNN
	1    6200 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C32
U 1 1 6020B6A5
P 5750 5750
F 0 "C32" H 5865 5796 50  0000 L CNN
F 1 "0.1uF" H 5865 5705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5788 5600 50  0001 C CNN
F 3 "~" H 5750 5750 50  0001 C CNN
	1    5750 5750
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR0118
U 1 1 60207A27
P 5600 5500
F 0 "#PWR0118" H 5600 5350 50  0001 C CNN
F 1 "+1V2" H 5615 5673 50  0000 C CNN
F 2 "" H 5600 5500 50  0001 C CNN
F 3 "" H 5600 5500 50  0001 C CNN
	1    5600 5500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C22
U 1 1 601F2557
P 6300 5000
F 0 "C22" H 6415 5046 50  0000 L CNN
F 1 "0.1uF" H 6415 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6338 4850 50  0001 C CNN
F 3 "~" H 6300 5000 50  0001 C CNN
	1    6300 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C39
U 1 1 601F18BD
P 9700 5000
F 0 "C39" H 9815 5046 50  0000 L CNN
F 1 "0.1uF" H 9815 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9738 4850 50  0001 C CNN
F 3 "~" H 9700 5000 50  0001 C CNN
	1    9700 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C37
U 1 1 601EFF4C
P 9250 5000
F 0 "C37" H 9365 5046 50  0000 L CNN
F 1 "0.1uF" H 9365 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 9288 4850 50  0001 C CNN
F 3 "~" H 9250 5000 50  0001 C CNN
	1    9250 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C35
U 1 1 601EF973
P 8850 5000
F 0 "C35" H 8965 5046 50  0000 L CNN
F 1 "0.1uF" H 8965 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8888 4850 50  0001 C CNN
F 3 "~" H 8850 5000 50  0001 C CNN
	1    8850 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C33
U 1 1 601EF3C8
P 8450 5000
F 0 "C33" H 8565 5046 50  0000 L CNN
F 1 "0.1uF" H 8565 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8488 4850 50  0001 C CNN
F 3 "~" H 8450 5000 50  0001 C CNN
	1    8450 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C31
U 1 1 601EED65
P 8000 5000
F 0 "C31" H 8115 5046 50  0000 L CNN
F 1 "0.1uF" H 8115 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 8038 4850 50  0001 C CNN
F 3 "~" H 8000 5000 50  0001 C CNN
	1    8000 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C29
U 1 1 601EE763
P 7600 5000
F 0 "C29" H 7715 5046 50  0000 L CNN
F 1 "0.1uF" H 7715 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7638 4850 50  0001 C CNN
F 3 "~" H 7600 5000 50  0001 C CNN
	1    7600 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C28
U 1 1 601E9CD0
P 7200 5000
F 0 "C28" H 7315 5046 50  0000 L CNN
F 1 "0.1uF" H 7315 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7238 4850 50  0001 C CNN
F 3 "~" H 7200 5000 50  0001 C CNN
	1    7200 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C25
U 1 1 601E8B1D
P 6750 5000
F 0 "C25" H 6865 5046 50  0000 L CNN
F 1 "0.1uF" H 6865 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6788 4850 50  0001 C CNN
F 3 "~" H 6750 5000 50  0001 C CNN
	1    6750 5000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0119
U 1 1 60241188
P 5600 4700
F 0 "#PWR0119" H 5600 4550 50  0001 C CNN
F 1 "+3V3" H 5615 4873 50  0000 C CNN
F 2 "" H 5600 4700 50  0001 C CNN
F 3 "" H 5600 4700 50  0001 C CNN
	1    5600 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 4700 5600 4750
Wire Wire Line
	9700 4750 9700 4850
Wire Wire Line
	6300 4850 6300 4750
Connection ~ 6300 4750
Wire Wire Line
	6300 4750 6750 4750
Wire Wire Line
	6750 4850 6750 4750
Connection ~ 6750 4750
Wire Wire Line
	6750 4750 7200 4750
Wire Wire Line
	7200 4850 7200 4750
Connection ~ 7200 4750
Wire Wire Line
	7200 4750 7600 4750
Wire Wire Line
	7600 4850 7600 4750
Connection ~ 7600 4750
Wire Wire Line
	7600 4750 8000 4750
Wire Wire Line
	8000 4850 8000 4750
Connection ~ 8000 4750
Wire Wire Line
	8000 4750 8450 4750
Wire Wire Line
	8450 4850 8450 4750
Connection ~ 8450 4750
Wire Wire Line
	8450 4750 8850 4750
Wire Wire Line
	8850 4850 8850 4750
Connection ~ 8850 4750
Wire Wire Line
	8850 4750 9250 4750
Wire Wire Line
	9250 4850 9250 4750
Connection ~ 9250 4750
Wire Wire Line
	9250 4750 9700 4750
$Comp
L power:GND #PWR0120
U 1 1 60262903
P 10050 5250
F 0 "#PWR0120" H 10050 5000 50  0001 C CNN
F 1 "GND" H 10055 5077 50  0000 C CNN
F 2 "" H 10050 5250 50  0001 C CNN
F 3 "" H 10050 5250 50  0001 C CNN
	1    10050 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	10050 5250 10050 5200
Wire Wire Line
	10050 5200 9700 5200
Wire Wire Line
	6300 5200 6300 5150
Wire Wire Line
	6750 5150 6750 5200
Connection ~ 6750 5200
Wire Wire Line
	6750 5200 6300 5200
Wire Wire Line
	7200 5150 7200 5200
Connection ~ 7200 5200
Wire Wire Line
	7200 5200 6750 5200
Wire Wire Line
	7600 5150 7600 5200
Connection ~ 7600 5200
Wire Wire Line
	7600 5200 7200 5200
Wire Wire Line
	9700 5150 9700 5200
Connection ~ 9700 5200
Wire Wire Line
	9700 5200 9250 5200
Wire Wire Line
	9250 5150 9250 5200
Connection ~ 9250 5200
Wire Wire Line
	9250 5200 8850 5200
Wire Wire Line
	8850 5150 8850 5200
Connection ~ 8850 5200
Wire Wire Line
	8850 5200 8450 5200
Wire Wire Line
	8450 5150 8450 5200
Connection ~ 8450 5200
Wire Wire Line
	8450 5200 8000 5200
Wire Wire Line
	8000 5150 8000 5200
Connection ~ 8000 5200
Wire Wire Line
	8000 5200 7600 5200
$Comp
L power:+2V5 #PWR0121
U 1 1 6029448C
P 6500 3900
F 0 "#PWR0121" H 6500 3750 50  0001 C CNN
F 1 "+2V5" H 6515 4073 50  0000 C CNN
F 2 "" H 6500 3900 50  0001 C CNN
F 3 "" H 6500 3900 50  0001 C CNN
	1    6500 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0122
U 1 1 60294C96
P 7600 4450
F 0 "#PWR0122" H 7600 4200 50  0001 C CNN
F 1 "GND" H 7605 4277 50  0000 C CNN
F 2 "" H 7600 4450 50  0001 C CNN
F 3 "" H 7600 4450 50  0001 C CNN
	1    7600 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 4450 7600 4400
Wire Wire Line
	7600 4400 7200 4400
Wire Wire Line
	6750 4400 6750 4350
Wire Wire Line
	7200 4350 7200 4400
Connection ~ 7200 4400
Wire Wire Line
	7200 4400 6750 4400
Wire Wire Line
	7200 4050 7200 3950
Wire Wire Line
	7200 3950 6750 3950
Wire Wire Line
	6500 3950 6500 3900
Wire Wire Line
	6750 3950 6750 4050
Connection ~ 6750 3950
Wire Wire Line
	6750 3950 6500 3950
$Comp
L Device:C C2
U 1 1 5FF5D595
P 1400 5000
F 0 "C2" H 1515 5046 50  0000 L CNN
F 1 "0.1uF" H 1515 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1438 4850 50  0001 C CNN
F 3 "~" H 1400 5000 50  0001 C CNN
	1    1400 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C18
U 1 1 5FF5D59F
P 4800 5000
F 0 "C18" H 4915 5046 50  0000 L CNN
F 1 "0.1uF" H 4915 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4838 4850 50  0001 C CNN
F 3 "~" H 4800 5000 50  0001 C CNN
	1    4800 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C16
U 1 1 5FF5D5A9
P 4350 5000
F 0 "C16" H 4465 5046 50  0000 L CNN
F 1 "0.1uF" H 4465 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4388 4850 50  0001 C CNN
F 3 "~" H 4350 5000 50  0001 C CNN
	1    4350 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 5FF5D5B3
P 3950 5000
F 0 "C12" H 4065 5046 50  0000 L CNN
F 1 "0.1uF" H 4065 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3988 4850 50  0001 C CNN
F 3 "~" H 3950 5000 50  0001 C CNN
	1    3950 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 5FF5D5BD
P 3550 5000
F 0 "C11" H 3665 5046 50  0000 L CNN
F 1 "0.1uF" H 3665 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3588 4850 50  0001 C CNN
F 3 "~" H 3550 5000 50  0001 C CNN
	1    3550 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 5FF5D5C7
P 3100 5000
F 0 "C9" H 3215 5046 50  0000 L CNN
F 1 "0.1uF" H 3215 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3138 4850 50  0001 C CNN
F 3 "~" H 3100 5000 50  0001 C CNN
	1    3100 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 5FF5D5D1
P 2700 5000
F 0 "C6" H 2815 5046 50  0000 L CNN
F 1 "0.1uF" H 2815 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2738 4850 50  0001 C CNN
F 3 "~" H 2700 5000 50  0001 C CNN
	1    2700 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5FF5D5DB
P 2300 5000
F 0 "C4" H 2415 5046 50  0000 L CNN
F 1 "0.1uF" H 2415 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2338 4850 50  0001 C CNN
F 3 "~" H 2300 5000 50  0001 C CNN
	1    2300 5000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 5FF5D5E5
P 1850 5000
F 0 "C3" H 1965 5046 50  0000 L CNN
F 1 "0.1uF" H 1965 4955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1888 4850 50  0001 C CNN
F 3 "~" H 1850 5000 50  0001 C CNN
	1    1850 5000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0123
U 1 1 5FF5D5EF
P 700 4700
F 0 "#PWR0123" H 700 4550 50  0001 C CNN
F 1 "+3V3" H 715 4873 50  0000 C CNN
F 2 "" H 700 4700 50  0001 C CNN
F 3 "" H 700 4700 50  0001 C CNN
	1    700  4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	700  4700 700  4750
Wire Wire Line
	4800 4750 4800 4850
Wire Wire Line
	1400 4850 1400 4750
Connection ~ 1400 4750
Wire Wire Line
	1400 4750 1850 4750
Wire Wire Line
	1850 4850 1850 4750
Connection ~ 1850 4750
Wire Wire Line
	1850 4750 2300 4750
Wire Wire Line
	2300 4850 2300 4750
Connection ~ 2300 4750
Wire Wire Line
	2300 4750 2700 4750
Wire Wire Line
	2700 4850 2700 4750
Connection ~ 2700 4750
Wire Wire Line
	2700 4750 3100 4750
Wire Wire Line
	3100 4850 3100 4750
Connection ~ 3100 4750
Wire Wire Line
	3100 4750 3550 4750
Wire Wire Line
	3550 4850 3550 4750
Connection ~ 3550 4750
Wire Wire Line
	3550 4750 3950 4750
Wire Wire Line
	3950 4850 3950 4750
Connection ~ 3950 4750
Wire Wire Line
	3950 4750 4350 4750
Wire Wire Line
	4350 4850 4350 4750
Connection ~ 4350 4750
Wire Wire Line
	4350 4750 4800 4750
$Comp
L power:GND #PWR0124
U 1 1 5FF5D617
P 5150 5250
F 0 "#PWR0124" H 5150 5000 50  0001 C CNN
F 1 "GND" H 5155 5077 50  0000 C CNN
F 2 "" H 5150 5250 50  0001 C CNN
F 3 "" H 5150 5250 50  0001 C CNN
	1    5150 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 5250 5150 5200
Wire Wire Line
	5150 5200 4800 5200
Wire Wire Line
	1400 5200 1400 5150
Wire Wire Line
	1850 5150 1850 5200
Connection ~ 1850 5200
Wire Wire Line
	1850 5200 1400 5200
Wire Wire Line
	2300 5150 2300 5200
Connection ~ 2300 5200
Wire Wire Line
	2300 5200 1850 5200
Wire Wire Line
	2700 5150 2700 5200
Connection ~ 2700 5200
Wire Wire Line
	2700 5200 2300 5200
Wire Wire Line
	4800 5150 4800 5200
Connection ~ 4800 5200
Wire Wire Line
	4800 5200 4350 5200
Wire Wire Line
	4350 5150 4350 5200
Connection ~ 4350 5200
Wire Wire Line
	4350 5200 3950 5200
Wire Wire Line
	3950 5150 3950 5200
Connection ~ 3950 5200
Wire Wire Line
	3950 5200 3550 5200
Wire Wire Line
	3550 5150 3550 5200
Connection ~ 3550 5200
Wire Wire Line
	3550 5200 3100 5200
Wire Wire Line
	3100 5150 3100 5200
Connection ~ 3100 5200
Wire Wire Line
	3100 5200 2700 5200
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 6184BF1F
P 1950 1700
F 0 "#FLG0101" H 1950 1775 50  0001 C CNN
F 1 "PWR_FLAG" V 1950 1828 50  0000 L CNN
F 2 "" H 1950 1700 50  0001 C CNN
F 3 "~" H 1950 1700 50  0001 C CNN
	1    1950 1700
	0    1    1    0   
$EndComp
Connection ~ 1950 1700
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 6186C68C
P 1950 1900
F 0 "#FLG0102" H 1950 1975 50  0001 C CNN
F 1 "PWR_FLAG" V 1950 2028 50  0000 L CNN
F 2 "" H 1950 1900 50  0001 C CNN
F 3 "~" H 1950 1900 50  0001 C CNN
	1    1950 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	700  4750 1400 4750
Wire Wire Line
	5600 4750 6300 4750
Wire Wire Line
	6200 6000 6850 6000
Wire Wire Line
	5600 5550 5750 5550
Wire Wire Line
	6200 5550 5750 5550
Connection ~ 5750 5550
Wire Wire Line
	5750 6000 6200 6000
Connection ~ 6200 6000
$EndSCHEMATC