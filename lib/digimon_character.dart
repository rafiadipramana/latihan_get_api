import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DigimonCharacter extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const DigimonCharacter({super.key});

  Future<List<dynamic>> _fecthDigimonCharacters() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Karakter Digimon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthDigimonCharacters(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Image.network(
                            snapshot.data[index]['img'],
                          ),
                        ),
                        title: Text(
                          snapshot.data[index]['name'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          snapshot.data[index]['level'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
