`include "src/clk_divider.v"
`include "src/led_btn_ctrl.v"

module LED(

	//////////// CLOCK //////////
	input 		          		CLOCK_125_p,
	input 		          		CLOCK_50_B5B,
	input 		          		CLOCK_50_B6A,
	input 		          		CLOCK_50_B7A,
	input 		          		CLOCK_50_B8A,

	//////////// LED //////////
	output		     [7:0]		LEDG,
	output		     [9:0]		LEDR,

	//////////// KEY //////////
	input 		          		CPU_RESET_n,
	input 		     [3:0]		KEY
);

	wire clk_5_hz;

	clk_divider clk_divider_0(
		.clk     (CLOCK_50_B5B),   /* input */
		.rst_n   (CPU_RESET_n),    /* input */
		.clk_div (24'd5_000_000), /* input */
		.clk_o   (clk_5_hz)        /* output */
	);

	led_btn_ctrl led_btn_ctrl_0(
		.clk     (clk_5_hz),       /* input */
		.rst_n   (CPU_RESET_n),    /* input */
		.key_n   (KEY),            /* input */
		.led_g   (LEDG),           /* output */
		.led_r   (LEDR)            /* output */
	);

endmodule
