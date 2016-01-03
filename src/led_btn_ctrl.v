`ifndef _led_btn_ctrl_v_
`define _led_btn_ctrl_v_

module led_btn_ctrl(
	input          clk,
	input          rst_n,
	input   [3:0]  key_n,
	output  [7:0]  led_g,
	output  [9:0]  led_r
);
	reg     [3:0]  key_n_reg;
	reg     [7:0]  led_g_reg;
	reg     [9:0]  led_r_reg;

	parameter      LEG_R_STATE_UP = 1'b0, LEG_R_STATE_DOWN = 1'b1;
	reg            leg_r_state;

	assign led_g = led_g_reg;
	assign led_r = led_r_reg;

	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1)
		begin: key_handle
			always @ (negedge rst_n or negedge key_n[i])
			begin
				if (!rst_n)
					key_n_reg[i] <= 0;
				else
					key_n_reg[i] <= !key_n_reg[i];
			end
		end
	endgenerate

	integer j;
	always @ (posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			led_g_reg <= 0;
		else
		begin
			for (j = 0; j < 4; j = j + 1)
			begin
				if (key_n_reg[j] == 1)
				begin
					led_g_reg[j * 2] <= !led_g_reg[j * 2];
					led_g_reg[j * 2 + 1] <= led_g_reg[j * 2];
				end
				else
				begin
					led_g_reg[j * 2] <= 0;
					led_g_reg[j * 2 + 1] <= 0;
				end
			end
		end
	end

	always @ (posedge clk or negedge rst_n)
	begin
		if (!rst_n)
		begin
			led_r_reg <= 10'b00_0000_0001;
			leg_r_state <= LEG_R_STATE_UP;
		end
		else
			case (leg_r_state)
			LEG_R_STATE_UP:
				if (led_r_reg == 10'b10_0000_0000)
				begin
					led_r_reg <= 10'b01_0000_0000;
					leg_r_state <= LEG_R_STATE_DOWN;
				end
				else
					led_r_reg <= led_r_reg << 1;

			LEG_R_STATE_DOWN:
				if (led_r_reg == 10'b00_0000_0001)
				begin
					led_r_reg <= 10'b00_0000_0010;
					leg_r_state <= LEG_R_STATE_UP;
				end
				else
					led_r_reg <= led_r_reg >> 1;
			endcase
	end
endmodule

`endif /* _led_btn_ctrl_v_ */
