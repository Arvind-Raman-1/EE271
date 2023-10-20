module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY;
input logic [9:0] SW;

logic U, P, C, M, discount, stolen;

assign U = SW[9];
assign P = SW[8];
assign C = SW[7];
assign M = SW[0];
//assign D = LEDR[1];
//assign S = LEDR[0];

DiscountedStolenDetector FA (.U(U), .P(P), .C(C), .M(M), .discount(LEDR[1]), .stolen(LEDR[0]));

//assign HEX0 = 7'B0010000;
//assign HEX1 = 7'B0101011;
//assign HEX2 = 7'B1111001;
//assign HEX3 = 7'B0100001;
//assign HEX4 = 7'B0100001;
//assign HEX5 = 7'B0001000;

endmodule

// tests all values of switch combinations which correspond to the input
// of the 2 4-bit numbers input
module DE1_SoC_testbench();

logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
logic [9:0] LEDR;
logic [3:0] KEY;
logic [9:0] SW;

DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

integer i;
initial begin
for (i=0; i<2**4; i++) begin
{SW[9:7], SW[0]} = i; #10;
end
end

endmodule