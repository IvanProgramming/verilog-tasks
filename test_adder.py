import pyverilator

# Компилируем Verilog файл через Pyverilator
sim = pyverilator.PyVerilator.build('bitwise_sum.v')

# Пример теста для сложения двух 24-битных чисел
def test_bitwise_adder():
    # Массив тестовых случаев: (мантисса A, мантисса B, входящий перенос, ожидаемая сумма)
    test_cases = [
        (0b000000000000000000000001, 0b000000000000000000000010, 0, 0b000000000000000000000011),
        (0b111111111111111111111111, 0b000000000000000000000001, 0, 0b000000000000000000000000),  # Тест переноса
        (0b100000000000000000000000, 0b100000000000000000000000, 0, 0b000000000000000000000000),  # Тест переноса
        (0b000000000000000000000001, 0b000000000000000000000001, 0, 0b000000000000000000000010),
    ]

    # Проходим по каждому тестовому случаю
    for a, b, carry_in, expected_sum in test_cases:
        # Устанавливаем входные значения
        sim.io.a = a
        sim.io.b = b
        sim.io.carry_in = carry_in

        # Выполняем симуляцию
        sim.eval()

        # Получаем результаты
        sum_result = sim.io.sum
        carry_out_result = sim.io.carry_out

        # Проверяем результат
        assert sum_result == expected_sum, f"Ошибка: ожидалось {expected_sum}, но получено {sum_result}"
        print(f"Тест успешен: {bin(a)} + {bin(b)} = {bin(sum_result)} с переносом {carry_out_result}")

# Запускаем тесты
test_bitwise_adder()
