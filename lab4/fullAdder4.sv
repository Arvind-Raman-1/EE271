module fullAdder4 (A, B, cin, sum, cout);
    input logic A[3:0];
	 input logic B [3:0];
	 input logic cin;
	 
	 output logic [3:0]sum;
	 output logic cout;
	 
	 logic c[2:0];

    fullAdder FA0 (.A(A[0]), .B(B[0]), .cin(cin), .sum(sum[0]), .cout(c[0]));
    fullAdder FA1 (.A(A[1]), .B(B[1]), .cin(c[0]), .sum(sum[1]), .cout(c[1]));
    fullAdder FA2 (.A(A[2]), .B(B[2]), .cin(c[1]), .sum(sum[2]), .cout(c[2]));
    fullAdder FA3 (.A(A[3]), .B(B[3]), .cin(c[2]), .sum(sum[3]), .cout(cout));

	 
endmodule


module fullAdder4_testbench();
		
		logic [3:0] sum;
		logic [3:0] A;
		logic [3:0] B;
		logic cin, cout;
		
		fullAdder dut (A,B,cin,sum,cout);
		
		integer i;
		
		initial begin
		
			for(i = 0; i < 2 **9; i++) begin 
			 {A,B,cin} = i; #10;
			end
			

		end
		
endmodule




