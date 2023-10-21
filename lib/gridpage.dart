import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

class GridPage extends StatefulWidget {
  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Loading image URLs when the page is initialized
    loadImages();
  }

  Future<void> loadImages() async {
    final response = await http
        .get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=50'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<String> urls = data.map((item) {
        return 'https://picsum.photos/id/${item['id']}/200/200';
      }).toList();

      setState(() {
        imageUrls = urls;
      });
    } else {
      throw Exception('Failed to load image data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Grid',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ));
        },
      ),
    );
  }
}

class GridPageRoute extends MaterialPageRoute {
  GridPageRoute() : super(builder: (BuildContext context) => GridPage());
}
