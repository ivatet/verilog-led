module clk_divider(
	input           clk,
	input           rst_n,
	input   [23:0]  clk_div,
	output          clk_o
);
	reg     [23:0]  cnt;
	reg             clk_o_reg;

	assign clk_o = clk_o_reg;

	always @ (posedge clk or negedge rst_n)
	begin
		if (!rst_n)
		begin
			cnt <= 0;
			clk_o_reg <= 0;
		end
		else
		begin
			cnt <= cnt + 1;
			if (cnt == clk_div)
			begin
				cnt <= 0;
				clk_o_reg <= 1;
			end
			else
				clk_o_reg <= 0;
		end
	end

endmodule

module led_btn_ctrl(
	input          clk,
	input          rst_n,
	output  [7:0]  led_g
);
	reg     [7:0]  cnt;

	assign led_g[0] = cnt[0];
	assign led_g[1] = cnt[1];
	assign led_g[2] = cnt[2];
	assign led_g[3] = cnt[3];
	assign led_g[4] = cnt[4];
	assign led_g[5] = cnt[5];
	assign led_g[6] = cnt[6];
	assign led_g[7] = cnt[7];

	always @ (posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end

endmodule

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
		.clk_div (24'd10_000_000), /* input */
		.clk_o   (clk_5_hz)        /* output */
	);

	led_btn_ctrl led_btn_ctrl_0(
		.clk     (clk_5_hz),       /* input */
		.rst_n   (CPU_RESET_n),    /* input */
		.led_g   (LEDG)            /* output */
	);

endmodule
