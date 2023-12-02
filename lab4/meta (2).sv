module meta (clk, d1, q2, reset);
	input logic clk, d1, reset;
	output logic q2;
	logic q1;
	
	always_ff @ (posedge clk) begin
		if (reset) begin
			q1 <=0;
			q2 <=0;
		end else begin
			q1 <=d1;
			q2 <=q1;
		end
	end
endmodule

module meta_testbench();
	logic clk, d1, q2, reset;
	
	meta dut (.clk, .d1, .q2, .reset);
	
	parameter clock_period = 100;
	initial begin 
		clk <=0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
		d1<=1	;	@(posedge clk); //
		d1<=0	;	@(posedge clk); //
		d1<=1	;	@(posedge clk); //
		d1<=1	;	@(posedge clk);
					@(posedge clk);
		$stop;
		
	end
endmodule
		