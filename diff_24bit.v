module diff_24bit (
    input [23:0] a,
    input [23:0] b,
    output [23:0] diff
);

    wire [23:0] b_complement;
    wire carry_out_complement;
    wire carry_out_diff;

    bitwise_adder_24bit complement_adder (
        .a(~b),
        .b(24'h000001),
        .carry_in(1'b0), 
        .sum(b_complement),
        .carry_out(carry_out_complement)
    );

    bitwise_adder_24bit diff_adder (
        .a(a),
        .b(b_complement),
        .carry_in(1'b0),
        .sum(diff),
        .carry_out(carry_out_diff) 
    );

endmodule
