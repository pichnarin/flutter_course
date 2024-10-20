//bank account attribute for user

class BankAccount {
  final String _accId;
  final String _accOwner;
  final String _accType;
  double _balance;

  //normal constructor
  BankAccount(
      {required String accID,
      required String accOwner,
      required String accType,
      required double balances})
      : _accId = accID,
        _accOwner = accOwner,
        _accType = accType,
        _balance = balances;

  //getter method
  double get balance => _balance;

  String get accType => _accType;

  String get accOwner => _accOwner;

  String get accId => _accId;

  //method to check account, withdraw money and credit
  void checkBalance() {
    print('Current balances: $_balance');
  }

  void withdraw(double amount) {
    //check balance
    if (amount > _balance) {
      throw Exception('Insufficient balance for withdraw!!');
    }
    _balance -= amount;
    print('$amount have been withdraw from $_accId');
    print('Current balances: $_balance');
  }

  void credit(double amount) {
    //check amount
    if (amount == 0) {
      throw Exception('Insufficient balance for credit!!');
    }

    _balance += amount;
    print('$amount have been add to $_accId');
    print('Current balances: $_balance');
  }
}

//bank attribute

class Bank {
  final String _bankName;
  final String _bankBranch;

  //normal constructor
  Bank({required String name, required String branch})
      : _bankName = name,
        _bankBranch = branch;

  //getter

  String get bankBranch => _bankBranch;

  String get bankName => _bankName;

  //use map to contain user bank account and check for duplicate id
  final Map<String, BankAccount> accStorage = {};

  //method to create bank account for a certain user
  BankAccount createAccount(
      String accId, String accOwner, String accType, double balances) {
    //check for duplicate acc id
    if (accStorage.containsKey(accId)) {
      throw Exception('Account with ID $accId already exists!');
    }

    BankAccount newAcc = BankAccount(accID: accId, accOwner: accOwner, accType: accType, balances: balances);
    accStorage[accId] = newAcc;
    return newAcc;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank", branch: 'Choam choa');
  BankAccount ronanAccount = myBank.createAccount('007111222', 'ronan', 'Saving account', 0);

  ronanAccount.checkBalance();
  //print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print("\n");
  //print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  //print(ronanAccount.balance); // Balance: $50

  print('\n');

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  print('\n');
  try {
    myBank.createAccount('007111222', 'ronan', 'Saving account', 0); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
