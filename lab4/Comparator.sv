module Comparator (A, B, out)

	input logic [9:0] A,B;
	output logic out;
	
	
	always_comb begin

		if(A >B)
			out <= 1
		else
			out <= 0
			
		end
		
endmodule




