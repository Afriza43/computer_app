import 'package:computer_app/check_out.dart';
import 'package:computer_app/helper/dbhelper.dart';
import 'package:computer_app/models/Cart_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBHelper dbHelper = DBHelper();
  List<Cart> cartList = [];
  // ignore: unused_field
  int _subtotal = 0;

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Future<List<Cart>> getCart() async {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Cart>> cartListFuture = dbHelper.getCart();
      cartListFuture.then((_cartList) {
        if (mounted) {
          setState(() {
            cartList = _cartList;
          });
        }
      });
    });
    int subtotal = 0;
    for (int i = 0; i < cartList.length; i++) {
      subtotal += cartList[i].jumlah * int.parse(cartList[i].harga);
    }
    setState(() {
      _subtotal = subtotal;
    });
    return cartList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartList.isEmpty ? _emptyCart() : _cartItem(),
      bottomNavigationBar: Visibility(
        visible: cartList.isEmpty ? false : true,
        child: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: TextStyle(fontSize: 14.0)),
                        Text(
                            'Rp. ' +
                                NumberFormat.currency(
                                        locale: 'ID',
                                        symbol: "",
                                        decimalDigits: 0)
                                    .format(_subtotal)
                                    .toString(),
                            style:
                                TextStyle(color: Colors.red, fontSize: 18.0)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckoutPage(cartItems: cartList),
                        ),
                      );
                    },
                    child: Container(
                      height: 40.0,
                      child: Center(
                        child: Text('Cek Out',
                            style: TextStyle(color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(color: Colors.blue, spreadRadius: 1)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 70.0,
            padding:
                EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _cartItem() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Cart>>(
                future: getCart(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 130.0,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.white, spreadRadius: 1),
                          ],
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                          title: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  cartList[i].gambar,
                                  height: 110.0,
                                  width: 110.0,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(cartList[i].nama,
                                            style: TextStyle(fontSize: 16.0)),
                                        Text(
                                            'Rp. ' +
                                                NumberFormat.currency(
                                                        locale: 'ID',
                                                        symbol: "",
                                                        decimalDigits: 0)
                                                    .format(int.parse(
                                                            cartList[i].harga) *
                                                        cartList[i].jumlah)
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18.0)),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              width: 100,
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      if (cartList[i].jumlah >
                                                          1) {
                                                        _kurangJmlKeranjang(
                                                            cartList[i].id);
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.green,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Text(
                                                    cartList[i]
                                                        .jumlah
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _tambahJmlKeranjang(
                                                          cartList[i].id);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.green,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.only(
                                                    right: 10.0,
                                                    top: 7.0,
                                                    bottom: 5.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      _deleteKeranjang(
                                                          cartList[i].id);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        border: Border.all(
                                                            color: Colors.red),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.red,
                                                              spreadRadius: 1),
                                                        ],
                                                      ),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyCart() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? cartList.isEmpty
                    ? SafeArea(
                        child: new Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Keranjang Kosong',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ],
    );
  }

  _tambahJmlKeranjang(String id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('UPDATE computer SET jumlah=jumlah+1 WHERE id=?', [id]);
    await batch.commit();
  }

  _kurangJmlKeranjang(String id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('UPDATE computer SET jumlah=jumlah-1 WHERE id=?', [id]);
    await batch.commit();
  }

  _deleteKeranjang(String id) async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('DELETE FROM computer WHERE id=?', [id]);
    await batch.commit();
  }

  _kosongkanKeranjang() async {
    Database db = await dbHelper.database;
    var batch = db.batch();
    db.execute('DELETE FROM computer');
    await batch.commit();
  }
}
