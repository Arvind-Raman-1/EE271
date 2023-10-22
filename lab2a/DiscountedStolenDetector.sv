module DiscountedStolenDetector ( U, P, C, M, D, S);
	input logic U; // Input signal U
	input logic P; // Input signal P
	input logic C; // Input signal C
	input logic M; // Input signal M
	output logic D; // Output signal D
	output logic S; // Output signal S
	
	// Calculate the Discounted signal D
	assign D = P | (U & C);  
	
	// Calculate the Stolen signal S
	assign S = ~M & ((U & C) | ~C & (~U | ~P)); 
	
endmodule

module DiscountedStolenDetector_testbench ();
	logic U, P, C, M, D, S;
	DiscountedStolenDetector dut (.U(U), .P(P), .C(C), .M(M), .D(D), .S(S)); // Instantiate the DiscountedStolenDetector module
	
	integer i;
	initial begin
		for (i = 0; i < 2**4; i = i + 1) begin // Iterate through different combinations of input values
			{U, P, C, M} = i; // Set the input signals based on the current value of 'i'
			#10; // Wait for a delay of 10 time units
		end
		$stop; 
	end

endmodule

		