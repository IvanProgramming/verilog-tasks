module tb_floating_point_adder;
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    // Instantiate the floating_point_adder module
    floating_point_adder uut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        // Test 1: Adding 1.0 and 1.0
        // 1.0 in IEEE 754: 0 01111111 00000000000000000000000 (0x3F800000)
        a = 32'h3F800000;  // 1.0
        b = 32'h3F800000;  // 1.0
        #10;
        $display("Test 1: %h + %h = %h", a, b, result);

        // Test 2: Adding 2.0 and 1.0
        // 2.0 in IEEE 754: 0 10000000 00000000000000000000000 (0x40000000)
        a = 32'h40000000;  // 2.0
        b = 32'h3F800000;  // 1.0
        #10;
        $display("Test 2: %h + %h = %h", a, b, result);

        // Test 3: Adding 1.5 and 2.5
        // 1.5 in IEEE 754: 0 01111111 10000000000000000000000 (0x3FC00000)
        // 2.5 in IEEE 754: 0 10000000 01000000000000000000000 (0x40200000)
        a = 32'h3FC00000;  // 1.5
        b = 32'h40200000;  // 2.5
        #10;
        $display("Test 3: %h + %h = %h", a, b, result);

        // Test 4: Adding a negative number (-1.0) and 1.0
        // -1.0 in IEEE 754: 1 01111111 00000000000000000000000 (0xBF800000)
        a = 32'hBF800000;  // -1.0
        b = 32'h3F800000;  // 1.0
        #10;
        $display("Test 4: %h + %h = %h", a, b, result);

        // Test 5: Adding 0.5 and 0.75
        // 0.5 in IEEE 754: 0 01111110 00000000000000000000000 (0x3F000000)
        // 0.75 in IEEE 754: 0 01111110 10000000000000000000000 (0x3F400000)
        a = 32'h3F000000;  // 0.5
        b = 32'h3F400000;  // 0.75
        #10;
        $display("Test 5: %h + %h = %h", a, b, result);

        // End of simulation
        $finish;
    end
endmodule
