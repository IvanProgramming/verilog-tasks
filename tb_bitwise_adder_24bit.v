module tb_bitwise_adder_24bit;

    reg [23:0] a;
    reg [23:0] b;
    reg carry_in;
    wire [23:0] sum;
    wire carry_out;

    // Instantiate the bitwise_adder_24bit module
    bitwise_adder_24bit uut (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        // Test 1: Adding two small numbers
        a = 24'h000001;  // 1
        b = 24'h000001;  // 1
        carry_in = 0;
        #10;
        $display("Test 1: %h + %h = %h, Carry: %b", a, b, sum, carry_out); 
        // Right is 2

        // Test 2: Adding larger numbers
        a = 24'hFFFFFF;  // Large number
        b = 24'h000001;  // 1
        carry_in = 0;
        #10;
        $display("Test 2: %h + %h = %h, Carry: %b", a, b, sum, carry_out);

        // Test 3: Adding numbers with carry_in
        a = 24'h7FFFFF;
        b = 24'h000001;
        carry_in = 1;
        #10;
        $display("Test 3: %h + %h + carry_in = %h, Carry: %b", a, b, sum, carry_out);

        // End simulation
        $finish;
    end
endmodule
