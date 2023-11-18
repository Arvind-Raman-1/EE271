module userInput (clk, in, out, reset);
	input logic clk, in, reset;
	output logic out;
	
	enum {S0, S1} ps, ns;
	always_comb begin
		case(ps)
			S0: if (in) begin
					out = 1;
					ns = S1;
				 end
				 else begin
					out = 0;
					ns = S0;
				  end
			S1: if (in) begin
					out = 0;
					ns = S1;
				 end
				 else begin
					out = 0;
					ns = S0;
				 end
		endcase
	end
	
	always_ff @ (posedge clk) begin
		if (reset)
			ps <= S0;
		else
			ps <= ns;
	end
endmodule
		
module userInput_testbench();
	logic clk, in, out, reset;
	
	userInput dut (.clk, .in, .out, .reset);
	
	parameter clock_period = 100;
	initial begin 
		clk <=0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
		in <= 1;			@(posedge clk);
		in <= 1;			@(posedge clk);
		in <= 1;			@(posedge clk);
		in <= 0;			@(posedge clk);
		in <= 1;			@(posedge clk);
		in <= 0;			@(posedge clk);
		in <= 0;			@(posedge clk);
	end
endmodule
	
	
	