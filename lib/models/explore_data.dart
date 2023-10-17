import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/models/post.dart';

class ExploreData {
  // Lista de recetas del día
  final List<ExploreRecipe> todayRecipes;
  // Lista de publicaciones de chefs registrados en la red social
  final List<Post> friendPosts;

  ExploreData(this.todayRecipes, this.friendPosts);
}
