module DE1_SoC_disp (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Define 7-segment display outputs
	output logic [9:0] LEDR; // Define LED outputs
	input logic [3:0] KEY; // Define 4-bit input for keys
	input logic [9:0] SW; // Define 10-bit input for switches
	
	logic [3:0] bcd ; // Create a 4-bit variable to hold BCD value
	assign bcd = SW[9:6]; // Extract the BCD value from the switch inputs
	
	// Instantiate a 7-segment display module FA and connect it to HEX0
	seg7 FA (.bcd(bcd), .leds(HEX0)); // Create an instance of the 7-segment display module and connect it to HEX0
	
endmodule

module DE1_SoC_disp_testbench();

	// Declare signals for testing
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // Declare 7-segment display outputs for testing
	logic [9:0] LEDR; // Declare LED outputs for testing
	logic [3:0] KEY; // Declare 4-bit input for keys for testing
	logic [9:0] SW; // Declare 10-bit input for switches for testing
	
	// Instantiate the DE1_SoC_disp module as the device under test (DUT)
	DE1_SoC_disp dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW); // Create an instance of DE1_SoC_disp and connect its inputs and outputs
	
	initial begin
		// Test various BCD values by setting SW[9:6]
		SW[9:6] = 4'b0000; #10;
		SW[9:6] = 4'b0001; #10;
		SW[9:6] = 4'b0010; #10;
		SW[9:6] = 4'b0011; #10;
		SW[9:6] = 4'b0100; #10;
		SW[9:6] = 4'b0101; #10;
		SW[9:6] = 4'b0110; #10;
		SW[9:6] = 4'b0111; #10;
		SW[9:6] = 4'b1000; #10;
		SW[9:6] = 4'b1001; #10;
	end

endmodule
