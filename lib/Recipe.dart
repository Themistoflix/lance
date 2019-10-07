class Recipe{
  int _id;
  String _name;

  String _imagePath;

  List<String> _necessaryIngredients;
  List<String> _optionalIngredients;

  int _minTotalDuration;
  int _maxTotalDuration;

  int _minPrice;
  int _maxPrice;

  List<String> _tags;

  Recipe.margherita(){
    _id = 0;
    _name = 'Pizza Margherita';
    _imagePath = 'assets/margherita.png';

    _necessaryIngredients = ['Pizza dough', 'Tomatoes', 'Mozarella'];
    _optionalIngredients = ['Basil leaves', 'Olives'];

    _minTotalDuration = 15;
    _maxTotalDuration = 20;

    _minPrice = 3;
    _maxPrice = 5;

    _tags = ['Italian', 'Vegetarian', 'Easy'];
  }

}