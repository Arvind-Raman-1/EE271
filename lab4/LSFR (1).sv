//Arvind Raman Ben Nyugen
// Lab 5 
// LSFR Module
// 11/27/23

module LFSR (clk, reset, out);

	input logic clk, reset;			
	output logic [9:0] out;			
	
	always_ff @ (posedge clk)
		begin
			if (reset)
				out <= 10'b0000000000;
			else
				begin
					out <= out >> 1;
					out[9] <= ~(out[0] ^ out[3]);
				end
		end
		
endmodule


module LFSR_testbench();
	logic clk, reset;
	logic [9:0] out;
	
	LFSR dut(clk, reset, out);
	

	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	

	integer i;
	initial begin
		reset <= 1;	@(posedge clk);
		reset <= 0;	@(posedge clk);
		for(i = 0; i < 50; i++) begin
			@(posedge clk);
		end				
		$stop; 							
	end
	
endmodule





