import 'dart:io';

void main() {
  const String namaKasir = 'Callysa Elistia';
  const String nimKasir = '4241250018';

  final Map<String, ({String nama, String kategori, int harga})> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  print('=== KASIR TOKO OLEH-OLEH MEDAN ===');
  print('Kasir: $namaKasir ($nimKasir)\n');

  // TODO 1: tampilkan katalog sebagai tabel rapi (kode, nama, harga) dengan padRight/padLeft.
  print('KATALOG TOKO');
  print(
    '${'Kode'.padRight(6)} ${'Nama Produk'.padRight(24)} ${'Kategori'.padRight(10)} ${'Harga'.padLeft(10)}',
  );
  print('-' * 54);
  for (final entry in katalog.entries) {
    final String kode = entry.key;
    final produk = entry.value;
    print(
      '${kode.padRight(6)} ${produk.nama.padRight(24)} ${produk.kategori.padRight(10)} ${'Rp ${produk.harga}'.padLeft(10)}',
    );
  }
  print('');

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final String input = (stdin.readLineSync() ?? '').trim();

  if (input.isEmpty) {
    print('\nTidak ada pesanan yang dimasukkan.');
    return;
  }

  // TODO 2 & TODO 3: pecah input, cari produk (nullable), validasi jumlah, dan catat item ditolak.
  final List<String> potonganPesanan = input.split(',');
  final List<
    ({String kode, String nama, String kategori, int harga, int jumlah})
  >
  pesananValid = [];
  final List<String> itemDitolak = [];

  for (final rawItem in potonganPesanan) {
    final String item = rawItem.trim();
    if (item.isEmpty) {
      continue;
    }

    // Mendukung pemisah 'x' maupun 'X', contoh P01x2 atau P01X2
    final List<String> bagian = item.split(RegExp(r'[xX]'));
    if (bagian.length != 2) {
      itemDitolak.add('$item (format tidak valid)');
      continue;
    }

    final String kode = bagian[0].trim().toUpperCase();
    final int? jumlah = int.tryParse(bagian[1].trim());
    final produk = katalog[kode]; // Hasilnya nullable: ({...})?

    if (produk == null) {
      itemDitolak.add('$item (kode tidak ditemukan)');
      continue;
    }

    if (jumlah == null || jumlah <= 0) {
      itemDitolak.add('$item (jumlah tidak valid)');
      continue;
    }

    pesananValid.add((
      kode: kode,
      nama: produk.nama,
      kategori: produk.kategori,
      harga: produk.harga,
      jumlah: jumlah,
    ));
  }

  // TODO 4: hitung subtotal tiap item (map) dan total (fold); beri diskon 10% jika total >= 100000.
  final List<
    ({
      String kode,
      String nama,
      String kategori,
      int jumlah,
      int harga,
      int subtotal,
    })
  >
  rincian = pesananValid
      .map(
        (p) => (
          kode: p.kode,
          nama: p.nama,
          kategori: p.kategori,
          jumlah: p.jumlah,
          harga: p.harga,
          subtotal: p.harga * p.jumlah,
        ),
      )
      .toList();

  final int total = rincian.fold<int>(
    0,
    (akumulasi, item) => akumulasi + item.subtotal,
  );
  final int diskon = total >= 100000 ? (total * 0.1).round() : 0;
  final int jumlahBayar = total - diskon;

  // Aman karena `produk != null` sudah diperiksa di atas; memakai `!` untuk mengakses field record non-nullable.
  final Set<String> kategoriDibeli = {
    for (final item in rincian) katalog[item.kode]!.kategori,
  };

  // TODO 5: cetak struk, Set kategori yang dibeli, dan daftar item yang ditolak.
  print('\n================ STRUK BELANJA ================');
  print('Kasir : $namaKasir ($nimKasir)');
  print('-' * 47);

  if (rincian.isEmpty) {
    print('Tidak ada item pesanan yang valid.');
  } else {
    for (final item in rincian) {
      print(
        '${item.kode} ${item.nama.padRight(22)} ${'${item.jumlah}x'.padLeft(4)} ${'Rp ${item.subtotal}'.padLeft(10)}',
      );
    }
  }

  print('-' * 47);
  print('${'Total'.padRight(35)} ${'Rp $total'.padLeft(11)}');
  print('${'Diskon (10%)'.padRight(35)} ${'Rp $diskon'.padLeft(11)}');
  print('${'Jumlah Bayar'.padRight(35)} ${'Rp $jumlahBayar'.padLeft(11)}');
  print('-' * 47);
  print(
    'Kategori dibeli : ${kategoriDibeli.isEmpty ? '-' : kategoriDibeli.join(', ')}',
  );
  print(
    'Item ditolak    : ${itemDitolak.isEmpty ? '-' : itemDitolak.join(', ')}',
  );
  print('===============================================');
}
