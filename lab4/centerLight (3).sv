module centerLight (clk, reset, L, R, NL, NR, lightOn);
	input logic clk, reset, L, R, NL, NR;
	output logic lightOn;
	
	enum {S0, S1} ps, ns;
	always_comb begin
		case(ps)
			S0: 	if  ((NL & ~NR & ~L & R)|(~NL & NR & L & ~R)) ns = S1;
					else								 		ns = S0;
			S1:	if (~NL & ~NR & ~L & ~R) ns = S1;
					else										ns= S0;
		endcase
	end
	
	assign lightOn = ps;
	
	always_ff @ (posedge clk) begin
		if (reset) 
			ps <= S1; //resets to on
		else
			ps <= ns;
	end	
	
endmodule

module centerLight_testbench();
	logic clk, reset, L, R, NL, NR, lightOn;
	
	centerLight dut (.clk, .reset, .L, .R, .NL, .NR, .lightOn);
	
	parameter clock_period = 100;
	initial begin 
		clk <=0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
		NL <= 0; NR<=0; L<=0; R<=1;			@(posedge clk); //
														@(posedge clk);
		NL <= 0; NR<=0; L<=0; R<=1;			@(posedge clk); //
		NL <= 0; NR<=0; L<=1; R<=0;			@(posedge clk); //
		NL <= 0; NR<=1; L<=1; R<=0;			@(posedge clk); //
		NL <= 0; NR<=0; L<=1; R<=0;			@(posedge clk);
		NL <= 1; NR<=0; L<=0; R<=1;			@(posedge clk); //
		$stop;
		
	end
endmodule 