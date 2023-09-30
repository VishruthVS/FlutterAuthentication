import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signinauth/models/brew.dart';
import 'package:signinauth/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // print(brews.docs);
    // if (brews != null) {
    //   for (var doc in brews.docs) {
    //     print(doc.data);
    //   }
    // }
    if (brews != null) {
      brews.forEach((brew) {
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
      });
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
      itemCount: brews.length,
    );
  }
}
