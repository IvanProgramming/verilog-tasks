module floating_point_adder(
    input [31:0] a, 
    input [31:0] b, 
    output [31:0] result
);

// Разделяем на значимые части
assign asign = a[31];
assign bsign = b[31];

assign expa = a[30:23];
assign expb = b[30:23];

assign mantissaa = a[22:0];
assign mantissab = b[22:0];

// Складываем мантиссы


// Нормализовать результат (переносим разряды)
// Корректируем порядок

endmodule