
module niosHello (
	butsw_export,
	clk_clk,
	leds_export,
	reset_reset_n);	

	input	[4:0]	butsw_export;
	input		clk_clk;
	output	[5:0]	leds_export;
	input		reset_reset_n;
endmodule
