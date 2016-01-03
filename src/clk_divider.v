`ifndef _clk_divider_v_
`define _clk_divider_v_

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

`endif /* _clk_divider_v_ */
