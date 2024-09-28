module floating_point_adder (
    input [31:0] a, // Первое число
    input [31:0] b, // Второе число
    output [31:0] result
);
    wire sign_a, sign_b;
    wire [7:0] exp_a, exp_b;
    wire [23:0] mant_a, mant_b;
    
    // Извлечение знака, экспоненты и мантиссы из числа a
    assign sign_a = a[31];
    assign exp_a = a[30:23];
    assign mant_a = {1'b1, a[22:0]}; // Добавляем скрытую единицу

    // Извлечение знака, экспоненты и мантиссы из числа b
    assign sign_b = b[31];
    assign exp_b = b[30:23];
    assign mant_b = {1'b1, b[22:0]}; // Добавляем скрытую единицу

    // Сравнение экспонент и выравнивание мантисс
    wire [7:0] exp_diff = exp_a - exp_b;
    wire [23:0] mant_b_shifted = mant_b >> exp_diff;
    
    // Складываем мантиссы
    wire [24:0] mant_sum = mant_a + mant_b_shifted;
    
    // Нормализация результата
    wire [7:0] exp_result = exp_a + 1; // Возможно увеличение порядка на 1
    wire [22:0] mant_result = mant_sum[23:1]; // Отбрасываем старший бит

    // Формируем результат
    assign result = {sign_a, exp_result, mant_result};

endmodule
