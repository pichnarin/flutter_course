enum CurrencyType { RIEL, EURO, YEN}

extension CurrencyExtension on CurrencyType {
  String get displayName {
    switch (this) {
      case CurrencyType.RIEL:
        return "Riel";
      case CurrencyType.EURO:
        return "Euro";
      case CurrencyType.YEN:
        return "Yen";
    }
  }
}

class Converter {
  final double usdAmount;
  final CurrencyType currency;

  Converter({required this.usdAmount, required this.currency});


  //covert usd to other currency based on the currency type
  double convert() {
    switch (currency) {
      case CurrencyType.RIEL:
        return usdAmount * 4100;
      case CurrencyType.EURO:
        return usdAmount * 0.85;
      case CurrencyType.YEN:
        return usdAmount * 110.0;
    }
  }
}

// void main() {
//   var testConverter = Converter(usdAmount: 1.12, currency: Currency.EURO);
//   var result = testConverter.convert().toStringAsFixed(3);
//   print(result);
// }