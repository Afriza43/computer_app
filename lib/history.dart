import 'package:flutter/material.dart';
import 'package:computer_app/helper/dbhistory.dart';
import 'package:computer_app/models/HistoryModel.dart';
import 'package:sqflite/sqflite.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryDBHelper dbHelper = HistoryDBHelper();
  List<History> historyList = [];

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  Future<List<History>> getHistory() async {
    final Future<Database> dbHistoryFuture = dbHelper.initHistoryDb();
    dbHistoryFuture.then((historyDatabase) {
      final Future<List<History>> historyListFuture = dbHelper.getHistory();
      historyListFuture.then((_historyList) {
        if (mounted) {
          setState(() {
            historyList = _historyList;
          });
        }
      });
    });
    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: historyList.isEmpty ? _emptyHistory() : _historyItem(),
    );
  }

  Widget _historyItem() {
    return SafeArea(
      child: Container(
        color: const Color(0xff343434),
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<History>>(
                future: getHistory(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      History history = historyList[index];
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.all(20.0),
                            title: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Image.network(
                                        history.gambar,
                                        height: 80.0,
                                        width: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 20.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.nama,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Subtotal: ${history.subtotal}, Quantity: ${history.quantity}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Purchase Time: ${_formatDateTime(history.purchaseTime)}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteHistory(history.id);
                              },
                            ),
                            onTap: () {},
                          ),
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

  Widget _emptyHistory() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Purchase History is Empty',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String dateTime) {
    DateTime parsedDateTime = DateTime.parse(dateTime);
    return "${parsedDateTime.day}-${parsedDateTime.month}-${parsedDateTime.year}";
  }

  _deleteHistory(int id) async {
    Database db = await dbHelper.historyDatabase;
    var batch = db.batch();
    db.execute('DELETE FROM riwayat_bayar WHERE id=?', [id]);
    await batch.commit();
  }
}
