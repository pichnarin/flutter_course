import 'package:flutter/material.dart';

List<String> images = [
  'assets/w4-s2/bird.jpg',
  'assets/w4-s2/bird2.jpg',
  'assets/w4-s2/girl.jpg',
  'assets/w4-s2/insect.jpg',
  'assets/w4-s2/man.jpg',
];

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  //attribute to catch the current image index
  int currentImageIndex = 0;

  //method to go to the next image when the next button is click
  void goToNextImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % images.length;
    });
  }

  //method to go to the previous image when the previous button is click
  void goToPreImage() {
    setState(() {
      currentImageIndex = (currentImageIndex - 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('The Image Gallery'),
          backgroundColor: Colors.green[400],

          //the actions property is used to add the action buttons to the app bar
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              tooltip: 'Go to the previous image',
              onPressed: goToPreImage,
            ),

            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the previous image',
              onPressed: goToNextImage,
            )
          ]),

      //call the ImageGallery widget
      body: Center(
        child: Image.asset(images[currentImageIndex]),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      //this property is used to remove the debug banner on the top right corner of the screen
      //when the app is running in debug mode
      debugShowMaterialGrid: false,
      //this property is used to remove the debug grid on the screen

      home: ImageGallery(),
    ));
