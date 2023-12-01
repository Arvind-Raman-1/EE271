// File: DE1_SoC.v
// Description: This file contains a Verilog module 'DE1_SoC' representing a game with LED lights and HEX displays.
// The game involves two players pressing keys (KEY[0] and KEY[3]) to control the left (L) and right (R) inputs.
// The LED lights (LEDR) display the game state, and HEX displays (HEX0 to HEX5) 
// The game logic involves multiple instances of normalLight and centerLight modules.

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // HEX display outputs
    output logic [9:0] LEDR;                              // LED lights
    input logic [3:0] KEY;                                // Key inputs
    input logic [9:0] SW;                                 // Switch inputs
    input logic CLOCK_50;                                 // 50 MHz clock
    logic clk;                                             // Internal clock signal
    logic reset, Ltemp, Rtemp;                             // Internal signals for reset and input synchronization
    logic L, R;                                            // Left and right inputs from players
    logic l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10;    // LED lights

    // Assign the internal clock signal
    assign clk = CLOCK_50;

    // Assign reset signal based on switch SW[9]
    assign reset = SW[9];

    // Assign LED signals based on the internal LED light signals
    assign LEDR[9] = l1; assign LEDR[8] = l2; assign LEDR[7] = l3; assign LEDR[6] = l4;
    assign LEDR[5] = l5; assign LEDR[4] = l6; assign LEDR[3] = l7; assign LEDR[2] = l8;
    assign LEDR[1] = l9; assign LEDR[0] = l10;

    // Instantiate input synchronization flip-flops
    meta m1 (.clk(clk), .d1(KEY[0]), .q2(Rtemp), .reset(reset)); // Right input synchronization
    meta m2 (.clk(clk), .d1(KEY[3]), .q2(Ltemp), .reset(reset)); // Left input synchronization

    // Instantiate userInput modules for left and right inputs
    userInput right (.clk(clk), .in(Rtemp), .out(R), .reset(reset));
    userInput left (.clk(clk), .in(Ltemp), .out(L), .reset(reset));

    // Instantiate normalLight and centerLight modules for game logic
    normalLight light0 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l1), .NL(1'b0), .lightOn(l0));
    normalLight light1 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l2), .NL(l0), .lightOn(l1));
    normalLight light2 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l3), .NL(l1), .lightOn(l2));
    normalLight light3 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l4), .NL(l2), .lightOn(l3));
    normalLight light4 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l5), .NL(l3), .lightOn(l4));
    centerLight light5 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l6), .NL(l4), .lightOn(l5));
    normalLight light6 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l7), .NL(l5), .lightOn(l6));
    normalLight light7 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l8), .NL(l6), .lightOn(l7));
    normalLight light8 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l9), .NL(l7), .lightOn(l8));
    normalLight light9 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(l10), .NL(l8), .lightOn(l9));
    normalLight light10 (.clk(clk), .reset(reset), .L(L), .R(R), .NR(1'b0), .NL(l9), .lightOn(l10));

    // Logic to display "Adding" on HEX0
    always_comb begin
        if (l0) HEX0 = 7'b1111001;   // 1
        else if (l10) HEX0 = 7'b0100100;  // 2
        else HEX0 = 7'b0000000;           // 0
    end
endmodule

// Module: DE1_SoC_testbench
// Description: Testbench module for the 'DE1_SoC' module
module DE1_SoC_testbench();
    logic CLOCK_50;        // Clock signal
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;  // HEX display outputs
    logic [9:0] LEDR;       // LED lights
    logic [3:0] KEY;        // Key inputs
    logic [9:0] SW;         // Switch inputs

    // Instantiate the 'DE1_SoC' module
    DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

    parameter clock_period = 100;  // Clock period for simulation

    // Clock generation with a half-period toggle
    initial begin 
        CLOCK_50 <= 0;
        forever #(clock_period / 2) CLOCK_50 <= ~CLOCK_50;
    end

    // Test scenario
    initial begin
        SW[9] <= 1;                 // Assert reset
        @(posedge CLOCK_50);
        SW[9] <= 0; KEY[3] <= 0; KEY[0] <= 0;  // Deassert reset and set initial key values
        @(posedge CLOCK_50);
        // Simulate key presses and switches
        // You may add more key and switch values to simulate different scenarios
        KEY[0] <= 1; @(posedge CLOCK_50);
        KEY[0] <= 0; @(posedge CLOCK_50);
        KEY[0] <= 1; @(posedge CLOCK_50);
        KEY
