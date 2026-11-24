String huruf(int n) => n >= 85
    ? 'A'
    : n >= 70
    ? 'B'
    : n >= 60
    ? 'C'
    : n >= 50
    ? 'D'
    : 'E';

void main() {
  print('=== Data Nilai Mahasiswa - Callysa Elistia (4241250018) ===');

  final List<({String nama, int nilai})> kelas = [
    (nama: 'Budi', nilai: 85),
    (nama: 'Nala', nilai: 72),
    (nama: 'Dina', nilai: 58),
    (nama: 'Bagus', nilai: 91),
    (nama: 'Elisa', nilai: 66),
    // Tantangan: tambahan dua mahasiswa
    (nama: 'Fajar', nilai: 79),
    (nama: 'Gita', nilai: 48),
  ];

  print('${'Nama'.padRight(10)}${'Nilai'.padLeft(6)} Huruf');
  print('-' * 24);
  for (final m in kelas) {
    final String baris = m.nama.padRight(10) + m.nilai.toString().padLeft(6);
    print('$baris ${huruf(m.nilai)}');
  }

  final int total = kelas.fold<int>(0, (sum, m) => sum + m.nilai);
  final double rataRata = total / kelas.length;
  final List<String> lulus = kelas
      .where((m) => m.nilai >= 60)
      .map((m) => m.nama)
      .toList();
  final terbaik = kelas.reduce((a, b) => a.nilai >= b.nilai ? a : b);
  final (:nama, :nilai) = terbaik; // destrukturisasi record

  // Tantangan: jumlah mahasiswa per nilai huruf dalam Map<String, int>
  final Map<String, int> jumlahPerHuruf = {
    'A': 0,
    'B': 0,
    'C': 0,
    'D': 0,
    'E': 0,
  };
  for (final m in kelas) {
    final String grade = huruf(m.nilai);
    jumlahPerHuruf[grade] = (jumlahPerHuruf[grade] ?? 0) + 1;
  }

  // Tantangan: urutkan daftar berdasarkan nilai tertinggi
  final urutTertinggi = kelas.toList()
    ..sort((a, b) => b.nilai.compareTo(a.nilai));

  print('-' * 24);
  print('Rata-rata kelas : ${rataRata.toStringAsFixed(1)}');
  print('Lulus (>=60)    : ${lulus.join(', ')}');
  print('Nilai tertinggi : $nama ($nilai)');
  print('Rekap huruf     : $jumlahPerHuruf');
  print(
    'Urut nilai      : ${urutTertinggi.map((m) => '${m.nama} (${m.nilai})').join(', ')}',
  );
}
