gui_open_window Wave
gui_sg_create SYS_PLL_group
gui_list_add_group -id Wave.1 {SYS_PLL_group}
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.test_phase}
gui_set_radix -radix {ascii} -signals {SYS_PLL_tb.test_phase}
gui_sg_addsignal -group SYS_PLL_group {{Input_clocks}} -divider
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.CLK_IN1}
gui_sg_addsignal -group SYS_PLL_group {{Output_clocks}} -divider
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.dut.clk}
gui_list_expand -id Wave.1 SYS_PLL_tb.dut.clk
gui_sg_addsignal -group SYS_PLL_group {{Status_control}} -divider
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.RESET}
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.LOCKED}
gui_sg_addsignal -group SYS_PLL_group {{Counters}} -divider
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.COUNT}
gui_sg_addsignal -group SYS_PLL_group {SYS_PLL_tb.dut.counter}
gui_list_expand -id Wave.1 SYS_PLL_tb.dut.counter
gui_zoom -window Wave.1 -full
