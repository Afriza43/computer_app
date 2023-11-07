import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<String> imageUrls = [
    'https://img.freepik.com/free-psd/futuristic-cyber-monday-banner-template_23-2149117341.jpg?w=1380&t=st=1699317402~exp=1699318002~hmac=eb91a28dff900cf8353bceab187809fcad678f88e92324cc1d26222c4cf3b244',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/computer-banner-sale-design-template-02eea24e0cad8513bcd0683eacb5fb47_screen.jpg?ts=1659342516',
    'https://img.freepik.com/free-psd/black-friday-super-sale-facebook-cover-template_106176-1578.jpg?w=1380&t=st=1699317257~exp=1699317857~hmac=e79e16f3229eee0d1a868d16f6333906178fa0b0278d5a516933986043883cb0',
    // Tambahkan URL gambar lainnya sesuai kebutuhan
  ];

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
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
      ),
      body: Container(
        color: Colors.black87,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
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
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
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
                  // final TourismPlace place = tourismPlaceList[index];
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return HomePage(tempat: place);
                      // }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                            color: Colors.grey[800],
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    'https://cdn.idntimes.com/content-images/community/2020/08/geforce-super-2080s-3-1561506664-custom-1-2060x1374-1da65c8ce82012926802e740600c1e50_600x400.jpg',
                                  ),
                                ),
                                Text(
                                  'Laptop',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp 10.000.000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black87,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            activeColor: Colors.green,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
