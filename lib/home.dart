import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'pc_model.dart';
import 'api_resource.dart';

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
          title: const Text("List Users"),
        ),
        body: _buildListUsersBody());
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadPC(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            ComputerHardware computerHardware =
                ComputerHardware.fromJson(snapshot.data);
            return _buildSuccessSection(computerHardware);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(ComputerHardware data) {
    return ListView.builder(
        itemCount: data.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItemUsers(data.data![index]);
        });
  }

  Widget _buildItemUsers(Data computerHardware) {
    return InkWell(
      onTap: () => null,
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: context) => PageDetailUser(idUser:UserData.id!),)
      //   ,
      child: Card(
        child: Row(
          children: [
            Container(
              width: 100,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(computerHardware.harga!),
                Text(computerHardware.deskripsi!),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.greenAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
