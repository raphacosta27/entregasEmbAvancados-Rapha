
module niosHello (
	butsw_export,
	clk_clk,
	echo_out,
	echo_input,
	leds_output,
	reset_reset_n);	

	input	[4:0]	butsw_export;
	input		clk_clk;
	input		echo_out;
	output		echo_input;
	output	[3:0]	leds_output;
	input		reset_reset_n;
endmodule
