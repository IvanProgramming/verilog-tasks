module tb_diff_24bit;

    reg [23:0] a;
    reg [23:0] b;
    wire [23:0] diff;

    // Instantiate the diff_24bit module
    diff_24bit uut (
        .a(a),
        .b(b),
        .diff(diff)
    );

    initial begin
        // Test 1: Subtracting two small numbers
        a = 24'h000003;  // 3
        b = 24'h000001;  // 1
        #10;
        $display("Test 1: %h - %h = %h", a, b, diff);

        // Test 2: Subtracting a smaller number from a larger number
        a = 24'hFFFFFF;  // Large number
        b = 24'h000001;  // 1
        #10;
        $display("Test 2: %h - %h = %h", a, b, diff);

        // Test 3: Subtracting equal numbers
        a = 24'h123456;  // Arbitrary number
        b = 24'h123456;  // Same number
        #10;
        $display("Test 3: %h - %h = %h", a, b, diff);

        // End simulation
        $finish;
    end
endmodule
