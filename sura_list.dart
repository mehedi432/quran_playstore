import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'dart:developer';

class SuraList extends StatefulWidget {
  const SuraList({super.key});

  @override
  State<SuraList> createState() => _SuraListState();
}

class _SuraListState extends State<SuraList> {
  List<Map<String, dynamic>> suraDataList = [];

  @override
  void initState() {
    super.initState();
    _loadSuraData();
  }

  Future<void> _loadSuraData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/sura.json');
      List<dynamic> jsonDataList = json.decode(jsonString);

      if (jsonDataList.isNotEmpty && jsonDataList[0] is Map<String, dynamic>) {
        setState(() {
          suraDataList = List<Map<String, dynamic>>.from(jsonDataList);
        });
      } else {
        log('Invalid JSON structure. Expected a list with maps.');
      }
    } catch (e) {
      log('Error loading Sura data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Suras",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return suraDataList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: suraDataList.length,
            itemBuilder: (context, index) {
              return _buildSuraCard(suraDataList[index]);
            },
          );
  }

  Widget _buildSuraCard(Map<String, dynamic> suraData) {
    return Card(
      
      child: ListTile(
        leading: Text('${suraData['sura_no']}'),
        title: Text('${suraData['sura_name']}'),
        // Add more ListTile content as needed
      ),
    );
  }
}
