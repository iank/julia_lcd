create_clock -name "PLD_CLOCKINPUT" -period 20.000ns [get_ports {PLD_CLOCKINPUT}]
derive_pll_clocks
derive_clock_uncertainty