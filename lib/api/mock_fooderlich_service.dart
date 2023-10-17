import 'dart:convert';
import 'package:flutter/services.dart';
// Archio de barril con exportación de modelos necesarios para trabajar en este archivo
import 'package:fooderlich/models/models.dart';
/*
Es fácil comenzar a ensuciar nuestros archivos con infinidad de importaciones según la complejidad o dependencia
Esto se soluciona facilmente creando archivos de barril en cada uno de los directorios dónde se localizan nuestras dependencias
Los archivos de barril exportan el conjunto de clases, funciones o variables necesarias (dependencias) con la finalidad de acceder a estas con la simple importanción de un archivo (barril) 

import 'package:fooderlich/models/explore_data.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/post.dart';
import 'package:fooderlich/models/simple_recipe.dart';
*/

// Mock recipe service that grabs sample json data to mock recipe request/response
class MockFooderlichService {
  // Batch request that gets both today recipes and friend's feed
  Future<ExploreData> getExploreData() async {
    final todayRecipes = await _getTodayRecipes();
    final friendPosts = await _getFriendFeed();

    return ExploreData(todayRecipes, friendPosts);
  }

  // Get sample explore recipes json to display in ui
  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/sample_data/sample_explore_recipes.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to ExploreRecipe object.
    if (json['recipes'] != null) {
      final recipes = <ExploreRecipe>[];
      json['recipes'].forEach((v) {
        recipes.add(ExploreRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  // Get the sample friend json posts to display in ui
  Future<List<Post>> _getFriendFeed() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/sample_data/sample_friends_feed.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each post and convert json to Post object.
    if (json['feed'] != null) {
      final posts = <Post>[];
      json['feed'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  // Get the sample recipe json to display in ui
  Future<List<SimpleRecipe>> getRecipes() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/sample_data/sample_recipes.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each recipe and convert json to SimpleRecipe object.
    if (json['recipes'] != null) {
      final recipes = <SimpleRecipe>[];
      json['recipes'].forEach((v) {
        recipes.add(SimpleRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  // Loads sample json data from file system
  Future<String> _loadAsset(String path) async {
    // El método rootBundle.loadString(ruta) carga el contenido de un archivo ubicado el el sistema de archivos de la aplicación
    // Y lo devuelve como un Future<String>
    return rootBundle.loadString(path);
  }
}
