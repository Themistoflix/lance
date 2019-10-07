class UserProfile{
  List<int> _likedRecipesIDs;
  List<int> _dislikedRecipeIDs;

  UserProfile(this._likedRecipesIDs, this._dislikedRecipeIDs);

  void likeRecipe(int id){
    _likedRecipesIDs.add(id);
  }

  void dislikeRecipe(int id){
    _dislikedRecipeIDs.add(id);
  }
}