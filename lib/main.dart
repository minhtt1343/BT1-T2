import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller quản lý dữ liệu nhập từ 2 ô TextField
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Biến lưu kết quả hiển thị
  String _result = '';

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  // Hàm xử lý tính toán khi bấm các nút phép toán
  void _calculate(String operator) {
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = 'Vui lòng nhập đủ 2 số!';
      });
      return;
    }

    double calcResult = 0;

    switch (operator) {
      case '+':
        calcResult = num1 + num2;
        break;
      case '-':
        calcResult = num1 - num2;
        break;
      case '*':
        calcResult = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          setState(() {
            _result = 'Không thể chia cho 0';
          });
          return;
        }
        calcResult = num1 / num2;
        break;
    }

    setState(() {
      // Định dạng: Nếu là số nguyên thì bỏ phần thập phân (.0)
      _result = (calcResult % 1 == 0)
          ? calcResult.toInt().toString()
          : calcResult.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400), // Giới hạn chiều rộng chuẩn giao diện điện thoại
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thanh trạng thái Status Bar (Giờ, Sóng, Wifi, Pin)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_alt, size: 16),
                        SizedBox(width: 4),
                        Icon(Icons.wifi, size: 16),
                        SizedBox(width: 4),
                        Icon(Icons.battery_full, size: 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // 2. Tiêu đề bài thực hành
                const Center(
                  child: Text(
                    'Thực hành 03',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 3. Ô nhập số thứ nhất
                TextField(
                  controller: _num1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 4. Hàng nút phép toán (+ - * /)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOpButton('+', Colors.redAccent, () => _calculate('+')),
                    _buildOpButton('-', Colors.orangeAccent, () => _calculate('-')),
                    _buildOpButton('*', Colors.deepPurple, () => _calculate('*')),
                    _buildOpButton('/', Colors.black87, () => _calculate('/')),
                  ],
                ),
                const SizedBox(height: 20),

                // 5. Ô nhập số thứ hai
                TextField(
                  controller: _num2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 6. Hiển thị kết quả
                Text(
                  'Kết quả: $_result',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget tạo nút bấm vuông bo góc
  Widget _buildOpButton(String symbol, Color color, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Text(
          symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}