import 'package:computer_app/helper/dbhelper.dart';
import 'package:computer_app/helper/dbhistory.dart';
import 'package:computer_app/models/Cart_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CheckoutPage extends StatefulWidget {
  final List<Cart> cartItems;

  const CheckoutPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  HistoryDBHelper dbHelper = HistoryDBHelper();

  saveHistory(String nama, int subtotal, String gambar, int quantity,
      String purchaseTime) async {
    Database db = await dbHelper.historyDatabase;
    var batch = db.batch();
    db.execute(
      'INSERT INTO riwayat_bayar (nama, subtotal, gambar, quantity, purchaseTime) VALUES (?, ?, ?, ?, ?)',
      [
        nama,
        subtotal,
        gambar,
        quantity,
        purchaseTime,
      ],
    );
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            for (var item in widget.cartItems)
              ListTile(
                title: Text(item.nama),
                subtitle: Text('Jumlah: ${item.jumlah}'),
                trailing: Text(
                  'Subtotal: ${int.parse(item.harga) * item.jumlah}',
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Total Pembelian: Rp. ${calculateTotal()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                for (var item in widget.cartItems) {
                  // History history = History(
                  //   id: '',
                  //   nama: item.nama,
                  //   subtotal: int.parse(item.harga) * item.jumlah,
                  //   gambar: item.gambar,
                  //   quantity: item.jumlah,
                  //   purchaseTime: DateTime.now().toLocal().toString(),
                  // );
                  await saveHistory(
                      item.nama,
                      int.parse(item.harga) * item.jumlah,
                      item.gambar,
                      item.jumlah,
                      DateTime.now().toLocal().toString());
                }
                await clearCart();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pembelian Berhasil'),
                      content: Text('Terima kasih atas pembelian Anda!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Selesaikan Pembelian'),
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotal() {
    int total = 0;
    for (var item in widget.cartItems) {
      total += int.parse(item.harga) * item.jumlah;
    }
    return total;
  }

  Future<void> clearCart() async {
    DBHelper dbHelper = DBHelper();
    Database db = await dbHelper.database;
    var batch = db.batch();
    for (var item in widget.cartItems) {
      batch.delete('computer', where: 'id = ?', whereArgs: [item.id]);
    }
    await batch.commit();
  }
}
