module bitwise_adder_24bit (
    input [23:0] a, 
    input [23:0] b,          
    input carry_in,          
    output [23:0] sum,       
    output carry_out        
);
    wire [23:0] carry;       

    full_adder fa0 (.a(a[0]), .b(b[0]), .carry_in(carry_in), .sum(sum[0]), .carry_out(carry[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .carry_in(carry[0]), .sum(sum[1]), .carry_out(carry[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .carry_in(carry[1]), .sum(sum[2]), .carry_out(carry[2]));
    full_adder fa3 (.a(a[3]), .b(b[3]), .carry_in(carry[2]), .sum(sum[3]), .carry_out(carry[3]));
    full_adder fa4 (.a(a[4]), .b(b[4]), .carry_in(carry[3]), .sum(sum[4]), .carry_out(carry[4]));
    full_adder fa5 (.a(a[5]), .b(b[5]), .carry_in(carry[4]), .sum(sum[5]), .carry_out(carry[5]));
    full_adder fa6 (.a(a[6]), .b(b[6]), .carry_in(carry[5]), .sum(sum[6]), .carry_out(carry[6]));
    full_adder fa7 (.a(a[7]), .b(b[7]), .carry_in(carry[6]), .sum(sum[7]), .carry_out(carry[7]));
    full_adder fa8 (.a(a[8]), .b(b[8]), .carry_in(carry[7]), .sum(sum[8]), .carry_out(carry[8]));
    full_adder fa9 (.a(a[9]), .b(b[9]), .carry_in(carry[8]), .sum(sum[9]), .carry_out(carry[9]));
    full_adder fa10 (.a(a[10]), .b(b[10]), .carry_in(carry[9]), .sum(sum[10]), .carry_out(carry[10]));
    full_adder fa11 (.a(a[11]), .b(b[11]), .carry_in(carry[10]), .sum(sum[11]), .carry_out(carry[11]));
    full_adder fa12 (.a(a[12]), .b(b[12]), .carry_in(carry[11]), .sum(sum[12]), .carry_out(carry[12]));
    full_adder fa13 (.a(a[13]), .b(b[13]), .carry_in(carry[12]), .sum(sum[13]), .carry_out(carry[13]));
    full_adder fa14 (.a(a[14]), .b(b[14]), .carry_in(carry[13]), .sum(sum[14]), .carry_out(carry[14]));
    full_adder fa15 (.a(a[15]), .b(b[15]), .carry_in(carry[14]), .sum(sum[15]), .carry_out(carry[15]));
    full_adder fa16 (.a(a[16]), .b(b[16]), .carry_in(carry[15]), .sum(sum[16]), .carry_out(carry[16]));
    full_adder fa17 (.a(a[17]), .b(b[17]), .carry_in(carry[16]), .sum(sum[17]), .carry_out(carry[17]));
    full_adder fa18 (.a(a[18]), .b(b[18]), .carry_in(carry[17]), .sum(sum[18]), .carry_out(carry[18]));
    full_adder fa19 (.a(a[19]), .b(b[19]), .carry_in(carry[18]), .sum(sum[19]), .carry_out(carry[19]));
    full_adder fa20 (.a(a[20]), .b(b[20]), .carry_in(carry[19]), .sum(sum[20]), .carry_out(carry[20]));
    full_adder fa21 (.a(a[21]), .b(b[21]), .carry_in(carry[20]), .sum(sum[21]), .carry_out(carry[21]));
    full_adder fa22 (.a(a[22]), .b(b[22]), .carry_in(carry[21]), .sum(sum[22]), .carry_out(carry[22]));
    full_adder fa23 (.a(a[23]), .b(b[23]), .carry_in(carry[22]), .sum(sum[23]), .carry_out(carry_out));
endmodule
