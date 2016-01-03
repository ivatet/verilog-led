`ifndef _led_btn_ctrl_v_
`define _led_btn_ctrl_v_

module led_btn_ctrl(
	input          clk,
	input          rst_n,
	input   [3:0]  key_n,
	output  [7:0]  led_g
);
	reg     [3:0]  key_n_reg;
	reg     [7:0]  led_g_reg;

	assign led_g = led_g_reg;

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

endmodule

`endif /* _led_btn_ctrl_v_ */
