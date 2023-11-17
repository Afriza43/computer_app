// ignore_for_file: unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:computer_app/detail_produk.dart';
import 'package:computer_app/models/ComputerParts.dart';
import 'package:computer_app/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;
  final List<String> imageUrls = [
    'https://img.freepik.com/free-psd/futuristic-cyber-monday-banner-template_23-2149117341.jpg?w=1380&t=st=1699317402~exp=1699318002~hmac=eb91a28dff900cf8353bceab187809fcad678f88e92324cc1d26222c4cf3b244',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/computer-banner-sale-design-template-02eea24e0cad8513bcd0683eacb5fb47_screen.jpg?ts=1659342516',
    'https://img.freepik.com/free-psd/black-friday-super-sale-facebook-cover-template_106176-1578.jpg?w=1380&t=st=1699317257~exp=1699317857~hmac=e79e16f3229eee0d1a868d16f6333906178fa0b0278d5a516933986043883cb0',
    // Tambahkan URL gambar lainnya sesuai kebutuhan
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Computer>? computers;
  List<Computer>? filteredComputers;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
    initial();
  }

  getData() async {
    computers = await RemoteService().getComputers();
    if (computers != null) {
      setState(() {
        isLoaded = true;
        filteredComputers = computers;
      });
    }
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  void onSearchTextChanged(String query) {
    setState(() {
      filteredComputers = computers
          ?.where((computer) =>
              computer.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Computer>? displayComputers =
        _searchController.text.isNotEmpty ? filteredComputers : computers;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff343434),
        title: Text(
          'Welcome $username',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Replace the image URL with the URL of your profile image
          buildProfileAvatar(
              'https://plus.unsplash.com/premium_photo-1661389705400-b46e268f1981?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        ],
      ),
      body: Container(
        color: const Color(0xff343434),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: onSearchTextChanged,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 17),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white, // Mengubah warna ikon pencarian
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1.2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        disableCenter: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
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
            if (_searchController.text.isEmpty)
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20.0), //<-- SEE HERE
                              ),
                              color: const Color(0xff343434),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                        bottom: Radius.circular(8)),
                                    child: Image.network(
                                      computers![index].gambar,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    computers![index].nama,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${computers![index].harga}",
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(
                                          255, 89, 244, 192),
                                      fontSize: 13,
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
                      return Container(); // Placeholder or loading indicator can be added here
                    }
                  },
                  childCount: computers != null ? computers!.length : 0,
                ),
              ),
            if (_searchController.text.isNotEmpty)
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Computer pc = filteredComputers![index];
                    if (filteredComputers != null &&
                        filteredComputers!.isNotEmpty &&
                        index < filteredComputers!.length) {
                      final Computer pc = filteredComputers![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailPC(komputer: pc);
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: const Color(0xff343434),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                        bottom: Radius.circular(8)),
                                    child: Image.network(
                                      filteredComputers![index].gambar,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    filteredComputers![index].nama,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp ${filteredComputers![index].harga}",
                                    style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(
                                          255, 89, 244, 192),
                                      fontSize: 13,
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
                      return Container(); // Placeholder or loading indicator can be added here
                    } // ... your existing code
                  },
                  childCount:
                      filteredComputers != null ? filteredComputers!.length : 0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileAvatar(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 30, // Adjust the radius as needed
      ),
    );
  }
}
