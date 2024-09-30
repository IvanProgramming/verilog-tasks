module diff_24bit (
    input [23:0] a,  // First input
    input [23:0] b,  // Second input (to be subtracted from a)
    output [23:0] diff  // Output result (a - b)
);

    wire [23:0] b_complement;  // Two's complement of b
    wire carry_out_complement;  // Carry out from the two's complement calculation
    wire carry_out_diff;  // Carry out from the final subtraction (addition of a and two's complement of b)

    // Step 1: Compute two's complement of b by inverting it and adding 1
    bitwise_adder_24bit complement_adder (
        .a(~b),               // Invert b
        .b(24'h000001),       // Add 1 to calculate two's complement
        .carry_in(1'b0),      // No carry-in for two's complement calculation
        .sum(b_complement),   // Resulting two's complement of b
        .carry_out(carry_out_complement)  // Ignore this carry out
    );

    // Step 2: Add a to the two's complement of b
    bitwise_adder_24bit diff_adder (
        .a(a),
        .b(b_complement),     // Add the two's complement of b
        .carry_in(1'b0),      // No carry-in for this addition
        .sum(diff),           // Result is the subtraction a - b
        .carry_out(carry_out_diff)  // Ignore this carry out
    );

endmodule
