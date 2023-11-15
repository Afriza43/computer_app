import 'package:carousel_slider/carousel_slider.dart';
import 'package:computer_app/detail_produk.dart';
import 'package:computer_app/models/ComputerParts.dart';
import 'package:computer_app/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://img.freepik.com/free-psd/futuristic-cyber-monday-banner-template_23-2149117341.jpg?w=1380&t=st=1699317402~exp=1699318002~hmac=eb91a28dff900cf8353bceab187809fcad678f88e92324cc1d26222c4cf3b244',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/computer-banner-sale-design-template-02eea24e0cad8513bcd0683eacb5fb47_screen.jpg?ts=1659342516',
    'https://img.freepik.com/free-psd/black-friday-super-sale-facebook-cover-template_106176-1578.jpg?w=1380&t=st=1699317257~exp=1699317857~hmac=e79e16f3229eee0d1a868d16f6333906178fa0b0278d5a516933986043883cb0',
    // Tambahkan URL gambar lainnya sesuai kebutuhan
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Computer>? computers;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }

  getData() async {
    computers = await RemoteService().getComputers();
    if (computers != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'PC Shop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(
              Icons.access_time, // Icon jam
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => KonversiWaktu()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1.2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        disableCenter: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                      ),
                      items: imageUrls.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                url,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white, // Mengubah warna ikon pencarian
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Computer pc = computers![index];
                  if (computers != null &&
                      computers!.isNotEmpty &&
                      index < computers!.length) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailPC(komputer: pc);
                        }));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            color: Colors.grey[800],
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    computers![index].gambar,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  computers![index].nama,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Rp ${computers![index].harga}",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                childCount: computers != null ? computers!.length : 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
