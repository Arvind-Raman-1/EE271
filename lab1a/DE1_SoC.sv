/*module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, KEY, LEDR, SW);

    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
    output logic [4:0] LEDR; // 5 LEDs for Sum3 to Sum0 and Cout
    input logic [3:0] KEY;
    input logic [8:0] SW; // 9 switches (SW0 for Cin, SW4-SW1 for A, and SW8-SW5 for B)
    
    fullAdder FA (
        .A(SW[8:5]),  // Bits 8 to 5 (SW8-SW5) for B
        .B(SW[4:1]),  // Bits 4 to 1 (SW4-SW1) for A
        .cin(SW[0]),  // Bit 0 (SW0) for Cin
        .sum(LEDR[4:0]),  // 5 LEDs for Sum3 to Sum0
        .cout(LEDR[5])  // LED for Cout
    );
    
    assign HEX0 = 7'b1111111;
    assign HEX1 = 7'b1111111;
    assign HEX2 = 7'b1111111;
    assign HEX3 = 7'b1111111;
    assign HEX4 = 7'b1111111;
    
endmodule


module DE1_SoC_testbench();

    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
    logic [4:0] LEDR;
    logic [3:0] KEY;
    logic [8:0] SW; // 9 switches (SW0 for Cin, SW4-SW1 for A, and SW8-SW5 for B)
    
    DE1_SoC dut (
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .KEY(KEY),
        .LEDR(LEDR),
        .SW(SW)
    );
    
    integer i;
    
    initial begin
        // Initialize inputs
        SW[8:5] = 4'b0000; // Initialize B to 0000
        SW[4:1] = 4'b0000; // Initialize A to 0000
        SW[0] = 1'b0;       // Initialize Cin to 0
        
        // Simulate different inputs
        for (i = 0; i < 2**9; i = i + 1) begin
            // Update A, B, and Cin with the current count value
            SW[8:5] = i[8:5];
            SW[4:1] = i[4:1];
            SW[0] = i[0];
            
            // Add a delay to observe the output
            #10;
            
            // Display the inputs and outputs
            $display("SW: %b, Cin: %b, A: %b, B: %b, Sum: %b, Cout: %b",
                SW, SW[0], SW[4:1], SW[8:5], LEDR, LEDR[5]);
        end
        
        // End simulation
        $finish;
    end

endmodule */












module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

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

endmodule