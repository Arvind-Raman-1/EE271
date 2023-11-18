
module victory(clk, reset, L, R, NL, NR, winner);
	
	
	input logic clk, reset;
	input logic L, R, NL, NR;
	
	output logic [6:0] winner;
	
	enum {S0, S1, S2} ps, ns;
	
	
	always_comb begin

		case(ps) 
		
		
			S0:  if (NL & L & ~R) ns = S1;
				   else if (NR & R & ~L) ns = S2;
					else ns = S0;
			
			
			S1: ns = S1;
			
			
			S2: ns = S2;
		
		endcase 
	end
	
	always_comb begin
	
		if (ps == S2)
			winner = 7'b1000111;
		else if (ps == S1)
			winner = 7'b0001000;
		else
			winner = 7'b1110111;
	end
	
	always_ff @(posedge clk) begin
	
		if (reset)
			ps <= S0;
		else
			ps <= ns;
	end 

	
endmodule
	
	

module victory_testbench ();

logic clk, reset; 
logic L, R, NL, NR; 
logic [6:0] winner; 

victory dut (.clk(clk), .reset(reset), .L(L), .R(R), .NL(NL), .NR(NR), .winner(winner));


parameter clock_period = 100;

initial begin
clk <= 0;

forever #(clock_period /2) clk <= ~clk;
end 

initial begin

	reset <= 1; L<=0; R<=0; NL<=0; NR<=0; @(posedge clk);
	reset <= 0; @(posedge clk); 
	NL<=1; @(posedge clk); 
	L<=1; @(posedge clk); 

	reset <= 1; L<=0; R<=0; NL<=0; NR<=0; @(posedge clk); // reset
	reset <= 0; @(posedge clk); 
	NR<=1; @(posedge clk); 
	R<=1; @(posedge clk); 
	@(posedge clk);
	@(posedge clk);

$stop; //end simulation

end 

endmodule 

	

	

			
			
	