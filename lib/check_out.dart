import 'package:computer_app/helper/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:computer_app/helper/dbhistory.dart';
import 'package:computer_app/models/Cart_model.dart';
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
        backgroundColor: const Color(0xff343434),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            for (var item in widget.cartItems)
              Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    item.nama,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jumlah: ${item.jumlah}',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Subtotal: ${int.parse(item.harga) * item.jumlah}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  trailing: Image.network(
                    item.gambar,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Total Pembelian: Rp. ${calculateTotal()}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff343434),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff343434),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff343434),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  for (var item in widget.cartItems) {
                    await saveHistory(
                      item.nama,
                      int.parse(item.harga) * item.jumlah,
                      item.gambar,
                      item.jumlah,
                      DateTime.now().toLocal().toString(),
                    );
                  }
                  await clearCart();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Pembelian Berhasil',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          'Terima kasih atas pembelian Anda!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xff343434),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Selesaikan Pembelian'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff343434),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle "Back to Cart" button press
                  Navigator.pop(context); // This pops the current screen
                },
                child: Text('Back to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
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
