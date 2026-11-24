import 'dart:io';

void main() {
  print('=== Analisis Teks - Callysa Elistia (4241250018) ===');
  stdout.write('Masukkan kalimat: ');
  final String teks = (stdin.readLineSync() ?? '').trim();

  if (teks.isEmpty) {
    print('Kalimat kosong.');
    return;
  }

  final String kecil = teks.toLowerCase();
  final List<String> kata = kecil
      .split(RegExp(r'[^a-z0-9]+'))
      .where((k) => k.isNotEmpty)
      .toList();
  final int vokal = kecil.split('').where((c) => 'aiueo'.contains(c)).length;
  final String terbalik = teks.split('').reversed.join();
  final String huruf = kata.join();
  final bool palindrom =
      huruf.isNotEmpty && huruf == huruf.split('').reversed.join();

  final Map<String, int> frekuensi = {};
  for (final k in kata) {
    frekuensi[k] = (frekuensi[k] ?? 0) + 1;
  }

  final Set<String> kataUnik = kata.toSet();

  String kataTerpanjang = '';
  for (final u in kataUnik) {
    if (u.length > kataTerpanjang.length) {
      kataTerpanjang = u;
    }
  }

  print('Jumlah karakter : ${teks.length}');
  print('Jumlah kata     : ${kata.length}');
  print('Jumlah vokal    : $vokal');
  print('Huruf besar     : ${teks.toUpperCase()}');
  print('Terbalik        : $terbalik');
  print('Palindrom?      : $palindrom');
  print('Kata unik       : $kataUnik');
  print('Frekuensi kata  : $frekuensi');
  print(
    'Kata terpanjang : ${kataTerpanjang.isEmpty ? '-' : '$kataTerpanjang (${kataTerpanjang.length} huruf)'}',
  );
}
