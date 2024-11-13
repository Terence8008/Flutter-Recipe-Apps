import 'package:flutter/material.dart';

// DataAnalyzeScreen (Fifth UI)
class DataAnalyzeScreen extends StatefulWidget {
  @override
  _DataAnalyzeScreenState createState() => _DataAnalyzeScreenState();
}

class _DataAnalyzeScreenState extends State<DataAnalyzeScreen> {
  String selectedYear = '2022';
  Map<String, String> images = {
    '2022': 'assets/2022_data_analysis.png',
    '2023': 'assets/2023_data_analysis.png',
    '2024': 'assets/2024_data_analysis.png',
  };
  Map<String, Map<String, String>> description = {
    '2022': {
      'Total profit': 'RM 100,000',
      'Total customer view': '2000',
      'Total Ratings': '4.5',
    },
    '2023': {
      'Total profit': 'RM 150,000',
      'Total customer view': '3000',
      'Total Ratings': '4.7',
    },
    '2024': {
      'Total profit': 'RM 200,000',
      'Total customer view': '5000',
      'Total Ratings': '4.9',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Data Analyze',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Dropdown
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  label: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      dropdownColor: Colors.purple[200],
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue!;
                        });
                      },
                      items: <String>['2022', '2023', '2024']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Image for selected year
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  images[selectedYear]!, // Display image based on selected year
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Description based on selected year
            Text(
              'Total profit: ${description[selectedYear]!['Total profit']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Total customer view: ${description[selectedYear]!['Total customer view']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Total Ratings: ${description[selectedYear]!['Total Ratings']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}