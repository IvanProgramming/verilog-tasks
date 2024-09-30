module floating_point_adder (
    input [31:0] a,  
    input [31:0] b,
    output [31:0] result 
);

    // --- 1. Вытаскиваем знак, экспоненту и мантиссу из входных чисел ---
    wire sign_a;
    wire [7:0] exp_a;
    wire [23:0] mant_a;
    
    assign sign_a = a[31];
    assign exp_a = a[30:23];
    assign mant_a = {1'b1, a[22:0]};


    wire sign_b;
    wire [7:0] exp_b;
    wire [23:0] mant_b;
    
    assign sign_b = b[31];
    assign exp_b = b[30:23];
    assign mant_b = {1'b1, b[22:0]}; 

    // --- 2. Определяем, какой экспонент больше и выравниваем мантиссы ---
    wire [7:0] exp_diff;
    wire [23:0] mant_b_shifted;
    wire [23:0] mant_a_shifted;

    wire a_larger = (exp_a > exp_b);
    wire [7:0] effective_exp = a_larger ? exp_a : exp_b;

    diff_24bit exp_diff_calculator (
        .a(a_larger ? exp_a : exp_b),
        .b(a_larger ? exp_b : exp_a),
        .diff(exp_diff)
    );

    assign mant_a_shifted = a_larger ? mant_a : (mant_a >> exp_diff);
    assign mant_b_shifted = a_larger ? (mant_b >> exp_diff) : mant_b;

    // --- 3. Выполняем сложение/вычитание мантисс ---
    wire [24:0] mant_sum;
    wire [24:0] mant_diff;
    wire carry_out_add, carry_out_sub;
    wire signs_equal = (sign_a == sign_b);
    wire [24:0] mant_result_sum;

    bitwise_adder_24bit mantissa_adder (
        .a(mant_a_shifted),
        .b(mant_b_shifted),
        .carry_in(1'b0),
        .sum(mant_sum[23:0]),
        .carry_out(carry_out_add)
    );

    diff_24bit mantissa_subtractor (
        .a(mant_a_shifted),
        .b(mant_b_shifted),
        .diff(mant_diff[23:0])
    );

    // --- 4. Собираем результат сложения/вычитания мантисс ---
    assign mant_result_sum = signs_equal ? {carry_out_add, mant_sum[23:0]} : mant_diff[23:0];

    wire equal_magnitudes = (mant_a_shifted == mant_b_shifted) && !signs_equal;
    wire result_sign = signs_equal ? sign_a : (mant_a_shifted > mant_b_shifted ? sign_a : sign_b);

    reg [7:0] exp_result;
    reg [22:0] mant_result_normalized;

    // --- 5. Нормализуем результат ---
    wire [7:0] incremented_exp;
    wire carry_out_exp_add;

    bitwise_adder_24bit exp_increment_adder (
        .a(effective_exp),
        .b(8'b1),  // Add 1 to exponent
        .carry_in(1'b0),
        .sum(incremented_exp),
        .carry_out(carry_out_exp_add)
    );

    always @(*) begin
        if (equal_magnitudes) begin
            mant_result_normalized = 23'b0;
            exp_result = 8'b0;
        end else if (mant_result_sum[24]) begin
            // If overflow in mantissa, shift right and use incremented exponent
            mant_result_normalized = mant_result_sum[23:1];  // Right shift to normalize
            exp_result = incremented_exp;  // Use the incremented exponent from the adder
        end else begin
            mant_result_normalized = mant_result_sum[22:0];  // Keep mantissa as is
            exp_result = effective_exp;
        end
    end

    // --- 6. Обработка специальных случаев ---
    wire is_zero_a = (a[30:0] == 0);
    wire is_zero_b = (b[30:0] == 0);
    wire is_infinity_a = (exp_a == 8'hFF && a[22:0] == 0);
    wire is_infinity_b = (exp_b == 8'hFF && b[22:0] == 0);
    wire is_nan_a = (exp_a == 8'hFF && a[22:0] != 0);
    wire is_nan_b = (exp_b == 8'hFF && b[22:0] != 0);

    // --- 7. Собираем окончательный результат ---
    wire [31:0] final_result;
    assign final_result = (is_nan_a || is_nan_b) ? 32'h7FC00000 :  // NaN
                          (is_infinity_a || is_infinity_b) ? {sign_a, 8'hFF, 23'b0} :  // Infinity
                          (is_zero_a && is_zero_b || equal_magnitudes) ? 32'h00000000 :  // Нули или равные числа
                          {result_sign, exp_result, mant_result_normalized};  // Обычный результат

    // Assign final result to output
    assign result = final_result;

endmodule
