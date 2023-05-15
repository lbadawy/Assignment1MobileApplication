// The class is responsible to load the GoT characters from the GoTAPI (on https://anapioficeandfire.com/)
import 'dart:async';
import 'dart:convert';

import 'package:ue1_basisprojekt/db/character.dart';
import 'package:http/http.dart' as http;

class API {
  // Note: the documentation for the API can be found here: https://anapioficeandfire.com/Documentation
  final String _charactersRoute =
      "https://anapioficeandfire.com/api/characters";

  // Loads the list of GoT characters
  Future<List<Character>> fetchRemoteGoTCharacters() async {
    return Future(() async {
      // TODO: Load GoT characters from the _charactersRoute and return them.
      // For the API calls we recommend to use the 'http' package

      //*** Must be replaced

      List<Character> characterList = [];
      int characterIndex = 0;

      while (characterList.length < 100) {
        print("Loading Characters...");
        characterIndex = characterIndex + 1;

        var url = _charactersRoute + "/" + characterIndex.toString();
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          Character c = //Character(
              //name: jsonUser.name,
              //gender: jsonUser.gender,
              //aliases: jsonUser.aliases);

              Character.fromJson(jsonDecode(response.body));
          if (c.aliases.length > 0 &&
              c.aliases[0].toString().isNotEmpty &&
              c.gender.isNotEmpty &&
              c.name.isNotEmpty) {
            bool isDublicate = false;
            characterList.forEach((element) {
              if (element.name == c.name) {
                isDublicate = true;
              }
            });
            if (!isDublicate) {
              characterList.add(c);
            }
          } else {}
        }
      }

      print("loading charachters finished!");

      await Future.wait;

      return characterList;
    });
  }
}
