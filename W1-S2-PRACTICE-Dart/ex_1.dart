// TODO: Manipulate type

void main(){

  const studentGrades = {
    'Sokan': [90, 85, 88],
    'Sokea': [70, 80, 75],
    'Hay': [95, 92, 89],
  }; // Answer: Map<String, list<int>>

  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  }; //Answer:  Map<String, double>

  const books = [
    {'title': '1984', 'author': 'George Orwell'},
    {'title': 'Brave New World', 'author': 'Aldous Huxley'},
    {'title': 'Fahrenheit 451', 'author': 'Ray Bradbury'},
  ]; //Answer: List<Map<String,String>>


  const company = {
    'HR': {'employees': 5, 'budget': 20000},
    'IT': {'employees': 10, 'budget': 50000},
    'Marketing': {'employees': 7, 'budget': 30000},
  }; //Answer: Map<String, Map<String, int>>

  const coordinates = [
    [1, 2],
    [3, 4],
    [5, 6],
  ]; //Answer: List<List<int>>


  const productDetails = {
    'id': 101,
    'name': 'Laptop',
    'price': 999.99,
    'inStock': true,
  }; //Answer: Map<String, Object>


  var operations = [
        (int a, int b) => a + b,
        (int a, int b) => a - b,
        (int a, int b) => a * b,
  ]; //Answer: List<int function(int, int)>


  const distances = {3.1, 5.5, 10.2, 7.8}; //Answer: Set<double>


  const university = {
    'departments': [
      {
        'name': 'Computer Science',
        'students': [
          {'name': 'Alice', 'age': 22},
          {'name': 'Bob', 'age': 24},
        ]
      },
      {
        'name': 'Mathematics',
        'students': [
          {'name': 'Charlie', 'age': 21},
          {'name': 'Dave', 'age': 23},
        ]
      }
    ]
  }; //Answer: Map<String, List<Map<String, Object>>>
  
}
