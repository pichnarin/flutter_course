

enum Skills { flutter('Flutter'), dart('Dart'), other('Other');

  final String label;

  const Skills(this.label);

  @override
  String toString(){
    return label;
  }

}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final int _yearOfExperiences;
  final Address _address;


  //because you cant use underscore in public constructor

 Employee(String name, double salary, {
    List<Skill> skills = const [], //optional
    int yearOfExperiences = 0, //optional
    required Address address  //required object
  }):_name = name, _baseSalary = salary, _yearOfExperiences = yearOfExperiences, _skills = skills, _address = address;


 //access private field by using public getter

  Address get address => _address;
  int get yearOfExperiences => _yearOfExperiences;
  List<Skill> get skills => _skills;
  double get baseSalary => _baseSalary;
  String get name => _name;

  //salary specification method
  //increase baseSalary by employee set of skill, year of experiences
  static const double bonusPerYear = 500.00;

  double calculateBonusPerYear(){
    return _yearOfExperiences * baseSalary;
  }

  //calculate bonus by each skill using fold function
  double calculateBonusBySkill(){
    return _skills.fold(0, (total, skill) => total + skill._skillBonus);
  }

  double get totalSalary => _baseSalary + calculateBonusPerYear() + calculateBonusBySkill();

  //print of the detail

  void printDetails() {
    print("Employee name: $_name \n\n"
        "Base salary: $_baseSalary \n\n"
        "Skills: $_skills \n\n"
        "Year of experiences: $_yearOfExperiences \n\n"
        "Address: $_address \n");
  }

  void finalOutput(){

    double bonusTotal = calculateBonusBySkill() + calculateBonusPerYear();

    print('Bonus total: $bonusTotal \n');

    print('total salary: $totalSalary');
  }
}

void main() {

  //address object for lay satya
  Address address = Address('123 main street', 'Phnom Penh', 12021);

  //skills of lay satya
  Skill skill1 = Skill(Skills.dart.toString(), 1000.00);
  Skill skill2 = Skill(Skills.flutter.toString(), 10000.00);

  //add to list
  List<Skill> satyaSkill = [skill1, skill2];

  //lay satya detail
  Employee employee = Employee(""
      "Lay Satya", //name
      1000,  //salary
      address: address, //required
      yearOfExperiences: 2, //optional
      skills: satyaSkill
  );

  //calculate bonus by each year
  employee.calculateBonusBySkill();

  //calculate bonus by each skill;
  employee.calculateBonusBySkill();

  //print out the detail
  employee.printDetails();
  employee.finalOutput();
}


class Address{

  final String _street;
  final String _city;
  final int _zipCode;

  Address(this._city, this._street, this._zipCode);


  @override
  String toString() {
    return 'Street: $_street, City: $_city, ZipCode: $_zipCode';
  }

  int get zipCode => _zipCode;

  String get city => _city;

  String get street => _street;
}

class Skill{

  final String _skillName;
  final double _skillBonus;

  Skill(this._skillName, this._skillBonus);


  @override
  String toString() {
    return 'Skill: $_skillName, Bonus: $_skillBonus';
  }

  double get skillBonus => _skillBonus;

  String get skillName => _skillName;
}