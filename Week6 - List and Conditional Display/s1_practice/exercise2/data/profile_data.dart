import 'package:flutter/material.dart';
import '../model/profile_tile_model.dart';

ProfileData pichProfile = ProfileData(
    name: "Pich",
    position: "Flutter Developer",
    avatarUrl: 'assets/profile/pichnarin.jpg',
    tiles: [
      TileData( icon: Icons.phone, title: "Phone Number", value: "+855 16983438"),
      TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "pich.narin@student.cadt.edu.kh"),
      TileData(icon: Icons.school, title: "School", value: "CADT"),
      TileData(icon: Icons.work, title: "Work", value: "Flutter Developer"),
      TileData(icon: Icons.sports, title: "Football", value: "Striker")
    ]);
