module DiscountedStolenDetector (U,P,C,M,discount,stolen);
	 input logic U; 
    input logic P;  
    input logic C;  
	 input logic M;
    output logic discount;
    output logic stolen;
	
	
	 assign discount = P | (U & C);
	 assign stolen = ~M & ((U & C) | ~C & (~U | ~P));
	
endmodule 

module DiscountedStolenDetector_testbench();

    logic U, P, C, M;
    logic discount, stolen;

    DiscountedStolenDetector dut (
        .U(U),
        .P(P),
        .C(C),
        .M(M),
        .discount(discount),
        .stolen(stolen)
    );

    integer i;

    initial begin
        $display("U P C M | Discount Stolen");
        $display("------------------------");

        for (i = 0; i < 2**4; i = i + 1) begin
            {U, P, C, M} = i;
            #10;
            $display("%b %b %b %b  |   %b       %b", U, P, C, M, discount, stolen);
        end

        $finish;
    end

endmodule


