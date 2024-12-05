import 'package:flutter/material.dart';
import 'package:flutter_leasson/w8/s2/e4/model/conveter.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  TextEditingController usdInput = TextEditingController();
  TextEditingController convertedAmountController = TextEditingController();
  CurrencyType? currencyType;

  //dispose the controller
  @override
  void dispose() {
    super.dispose();
    usdInput.dispose();
    convertedAmountController.dispose();
  }

  //handle the conversion
  void handleConversion() {
    if (usdInput.text.isNotEmpty && currencyType != null) {
      double usdAmount = double.tryParse(usdInput.text) ?? 0.0;
      Converter converter = Converter(usdAmount: usdAmount, currency: currencyType!);
      double convertedAmount = converter.convert();
      convertedAmountController.text = convertedAmount.toStringAsFixed(3);
    }else if(usdInput.text.isEmpty){
      convertedAmountController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        height: 500,

        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.attach_money, size: 80, color: Colors.green),
                const SizedBox(height: 16),

                const Text(
                  "Convert USD to Other Currencies",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                //usd input field
                TextField(
                  controller: usdInput,
                  decoration: InputDecoration(
                    labelText: 'Amount in USD',
                    hintText: 'Enter amount in USD',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => handleConversion(),
                ),
                const SizedBox(height: 20),

                //currency dropdown
                DropdownButtonFormField<CurrencyType>(
                  value: currencyType,
                  onChanged: (CurrencyType? value) {
                    setState(() {
                      currencyType = value;
                      handleConversion();
                    });
                  },
                  items: CurrencyType.values.map((CurrencyType type) {
                    return DropdownMenuItem<CurrencyType>(
                      value: type,
                      child: Text(type.displayName),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Currency',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    //
                  ),
                ),
                const SizedBox(height: 24),

                //converted amount
                const Text(
                  'Converted Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  readOnly: true,
                  controller: convertedAmountController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
