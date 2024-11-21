import 'package:flutter/material.dart';
import 'package:flutter_leasson/w6/s1_practice/exercise2/profile_tile_stateless.dart';
import 'data/profile_data.dart';
import 'model/profile_tile_model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileApp(profileData: pichProfile),
  ));
}

const Color mainColor = Color(0xff5E9FCD);

class ProfileApp extends StatelessWidget {
  final ProfileData profileData;

  const ProfileApp({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor.withAlpha(100),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'CADT Student Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileData.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              profileData.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
            Text(
              profileData.position,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder( // ListView.builder is used to create a scrollable list of items
                itemCount: profileData.tiles.length,  // itemCount is the number of items in the list
                itemBuilder: (context, index) { // itemBuilder is a function that returns a widget for each item in the list
                  final tile = profileData.tiles[index]; // get the tile at the current index
                  return ProfileTile( // return a ProfileTile widget with the tile data
                    icon: tile.icon,
                    title: tile.title,
                    data: tile.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


