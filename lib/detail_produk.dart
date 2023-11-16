import 'package:computer_app/cart.dart';
import 'package:computer_app/helper/dbhelper.dart';
import 'package:computer_app/models/Cart_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:computer_app/models/ComputerParts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DetailPC extends StatefulWidget {
  final Computer komputer;
  const DetailPC({Key? key, required this.komputer}) : super(key: key);

  @override
  State<DetailPC> createState() => _DetailPCState();
}

class _DetailPCState extends State<DetailPC> {
  int quantity = 1;
  String selectedCurrency = 'IDR';
  double exchangeRate = 1.0;
  late double _harga;

  DBHelper dbHelper = DBHelper();

  // updateQuantity(Cart cartItem) async {
  //   Database db = await dbHelper.database;
  //   var batch = db.batch();
  //   db.execute(
  //     'UPDATE computer SET jumlah = ? WHERE id = ?',
  //     [
  //       cartItem.jumlah,
  //       cartItem.id,
  //     ],
  //   );
  //   await batch.commit();
  // }

  saveCart(Cart cartItem) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute(
      'INSERT INTO computer (id, nama, harga, gambar, tipe, deskripsi, jumlah) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        cartItem.id,
        cartItem.nama,
        cartItem.harga,
        cartItem.gambar,
        cartItem.tipe,
        cartItem.deskripsi,
        cartItem.jumlah,
      ],
    );
    await batch.commit();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _harga = double.parse(widget.komputer.harga);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.komputer.nama,
          style: GoogleFonts.poppins(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Image.network(
                      widget.komputer.gambar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Product Name
              Text(
                widget.komputer.nama,
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              // Product Type
              Text(
                'Tipe: ${widget.komputer.tipe.toString().split('.').last}',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 8),

              Text(
                widget.komputer.deskripsi,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Price:',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        selectedCurrency == 'IDR'
                            ? NumberFormat.currency(
                                    locale: 'ID',
                                    symbol: "Rp",
                                    decimalDigits: 0)
                                .format(_harga)
                                .toString()
                            : selectedCurrency == 'USD'
                                ? NumberFormat.currency(
                                        locale: 'en_US',
                                        symbol: "\u0024",
                                        decimalDigits: 0)
                                    .format(_harga * 0.000064)
                                    .toString()
                                : selectedCurrency == 'GBP'
                                    ? NumberFormat.currency(
                                            locale: 'en_US',
                                            symbol: "€",
                                            decimalDigits: 0)
                                        .format(_harga * 0.000052)
                                        .toString()
                                    : "",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCurrency,
                      focusColor: Colors.white,
                      dropdownColor: Colors.white,
                      items: ['IDR', 'USD', 'GBP']
                          .map((currency) => DropdownMenuItem<String>(
                                value: currency,
                                child: Text(
                                  currency,
                                  style: GoogleFonts.poppins(),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value!;
                          if (selectedCurrency == 'USD') {
                            exchangeRate = 15.658;
                          } else if (selectedCurrency == 'GBP') {
                            exchangeRate = 19.255;
                          } else {
                            exchangeRate = 1.0;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      quantity.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Cart cartItem = Cart(
                    id: widget.komputer.id,
                    nama: widget.komputer.nama,
                    harga: widget.komputer.harga,
                    gambar: widget.komputer.gambar,
                    tipe: widget.komputer.tipe.toString().split('.').last,
                    deskripsi: widget.komputer.deskripsi,
                    jumlah: quantity,
                  );
                  saveCart(cartItem);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add to Cart',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
