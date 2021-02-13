create_clock -name "PLD_CLOCKINPUT" -period 20.000ns [get_ports {PLD_CLOCKINPUT}]

create_generated_clock -name S_CLK -source [get_pins mem_pll|altpll_component|auto_generated|pll1|clk[1]] [get_ports {S_CLK}]

derive_pll_clocks
derive_clock_uncertainty

set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_ADDR*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_DQ*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_RAS_N*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_CAS_N*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_CKE*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_CS_N*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_WE_N*]
set_output_delay -max 1.5 -clock [get_clocks S_CLK]  [get_ports S_BA*]

set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_ADDR*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_DQ*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_RAS_N*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_CAS_N*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_CKE*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_CS_N*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_WE_N*]
set_output_delay -min -0.8 -clock [get_clocks S_CLK]  [get_ports S_BA*]

