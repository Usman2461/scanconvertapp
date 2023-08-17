import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../show_files_screen/show_files_screen.dart';
class ConverterScreen extends StatelessWidget {

  final List<GridItem> items = [
    GridItem('All Files', 'assets/images/allfiles.png'),
    GridItem('PDF', 'assets/images/pdfs.png'),
    GridItem('Word', 'assets/images/word.png'),
    GridItem('Excel', 'assets/images/excel.png'),
    GridItem('Powerpoint', 'assets/images/powerpoint.png'),
    GridItem('Text', 'assets/images/text.png'),
    GridItem('Directories', 'assets/images/directories.png'),
    GridItem('Favourite', 'assets/images/favorites.png'),
    GridItem('Feedback', 'assets/images/feedback.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(appBarColor),
        title: Text("All Files", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0, // Adjust the spacing between columns
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles()));
              },
              child: GridTile(
                child: Column(
                  children: [
                    Image.asset(items[index].imagePath,height: 50.0,),
                    SizedBox(height: 8),
                    Text(items[index].label),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GridItem {
  final String label;
  final String imagePath;

  GridItem(this.label, this.imagePath);
}