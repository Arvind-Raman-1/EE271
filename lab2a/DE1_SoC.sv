module DE1_SoC (
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
    output logic [9:0] LEDR,
    input logic [3:0] KEY,
    input logic [9:0] SW
);

    DiscountedStolenDetector DSD (
        .U(SW[9]),
        .P(SW[8]),
        .C(SW[7]),
        .M(SW[0]),
        .discount(),
        .stolen()
    );

    // Assign HEX values as before
    assign HEX0 = 7'b0010000;
    assign HEX1 = 7'b1101010;
    assign HEX2 = 7'b1001111;
    assign HEX3 = 7'b1000010;
    assign HEX4 = 7'b1000010;
    assign HEX5 = 7'b0001000;
    
    // Assign LEDR based on the Discounted and Stolen signals
    assign LEDR = {DSD.discount, DSD.stolen, 8'b0};
endmodule

module DE1_SoC_testbench();
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LEDR;
    logic [3:0] KEY;
    logic [9:0] SW;
    
    DE1_SoC dut (
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5),
        .KEY(KEY),
        .LEDR(LEDR),
        .SW(SW)
    );
    
    integer i;
    initial begin
        SW[9] = 1'b0;
        SW[8] = 1'b0;
        SW[7] = 1'b0;
        SW[0] = 1'b0;
        for (i = 0; i < 2**8; i = i + 1) begin
            SW[7:0] = i;
            #10;
        end
        $finish;
    end
endmodule













/*module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW; 
	
	fullAdder FA (.A(SW[2]), .B(SW[1]), .cin(SW[0]), .sum(LEDR[0]), .cout(LEDR[1]));
	
	assign HEX0 = 7'b0010000;
	assign HEX1 = 7'b1101010;
	assign HEX2 = 7'b1001111;
	assign HEX3 = 7'b1000010;
	assign HEX4 = 7'b1000010;
	assign HEX5 = 7'b0001000;
	
endmodule


module DE1_SoC_testbench();

	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	integer i;
	initial begin
	SW[9] = 1'b0;
	SW[8] = 1'b0;
	for(i = 0; i < 2**8; i++) begin
		SW[7:0] = i; #10;
	end
end

endmodule*/