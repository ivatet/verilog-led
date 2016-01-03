`ifndef _led_btn_ctrl_v_
`define _led_btn_ctrl_v_

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

`endif /* _led_btn_ctrl_v_ */
