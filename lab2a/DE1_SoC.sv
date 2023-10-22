module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Declare internal signals
	logic U, P, C, M, D, S;
	
	// Assign values to control signals U, P, C, M
	assign U = SW[8];
	assign P = SW[7];
	assign C = SW[6];
	assign M = SW[0];
	
	// Instantiate a 7-segment display module FA and connect it to HEX0
	seg7 FA (.bcd(SW[9:6]), .leds(HEX0));
	
	// Instantiate a DiscountedStolenDetector module FB and connect it to control signals and LEDR
	DiscountedStolenDetector FB (.U(U), .P(P), .C(C), .M(M), .D(LEDR[1]), .S(LEDR[0]));
	
	// Assign constant values to HEX1, HEX2, HEX3, HEX4, and HEX5
	assign HEX1 = 7'B1111111;
	assign HEX2 = 7'B1111111;
	assign HEX3 = 7'B1111111;
	assign HEX4 = 7'B1111111;
	assign HEX5 = 7'B1111111;

endmodule

module DE1_SoC_testbench();

	// Declare signals for testing
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	// Instantiate the DE1_SoC module as the device under test (DUT)
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	// Initialize a loop to test different SW values
	integer i;
	initial begin
		for (i = 0; i < 2**4; i++) begin
			SW[9] = 0;
			{SW[8:6], SW[0]} = i; #10;
		end
	end

endmodule
  