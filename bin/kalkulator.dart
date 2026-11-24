import 'dart:io';
import 'dart:math';

String formatAngka(num nilai) {
  final double d = nilai.toDouble();
  if (d.isFinite && d == d.roundToDouble()) {
    return d.toInt().toString();
  }
  return d.toString();
}

void main() {
  print('=== Kalkulator Sederhana - Callysa Elistia (4241250018) ===');
  stdout.write('Bilangan pertama          : ');
  final double? a = double.tryParse((stdin.readLineSync() ?? '').trim());

  stdout.write('Operator (+,-,*,/,~/,%,^) : ');
  final String op = (stdin.readLineSync() ?? '').trim();

  stdout.write('Bilangan kedua            : ');
  final double? b = double.tryParse((stdin.readLineSync() ?? '').trim());

  // Setelah pengecekan ini, a dan b otomatis dipromosikan ke tipe double (non-nullable).
  if (a == null || b == null) {
    print('Input bukan angka yang valid.');
    return;
  }

  final num? hasil = switch (op) {
    '+' => a + b,
    '-' => a - b,
    '*' => a * b,
    '/' => b == 0 ? null : a / b,
    '~/' => b == 0 ? null : a ~/ b,
    '%' => b == 0 ? null : a % b,
    '^' => pow(a, b),
    _ => null,
  };

  if (hasil == null) {
    print('Operator tidak dikenal atau pembagian dengan nol.');
  } else {
    print('${formatAngka(a)} $op ${formatAngka(b)} = ${formatAngka(hasil)}');
  }
}
