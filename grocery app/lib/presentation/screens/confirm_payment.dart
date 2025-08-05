import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/core/theme/image.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/confirm_payment_widgets/custom_dialog.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/confirm_payment_widgets/custom_key_number.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {

  int selectedValue = 0;

  // Controllers for each field
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  TextEditingController getActiveController() {
    switch (activeField) {
      case 'expiry':
        return _expiryController;
      case 'cvv':
        return _cvvController;
      default:
        return _cardNumberController;
    }
  }


// Raw inputs to manage digits
  String cardRaw = '';
  String expiryRaw = '';
  String cvvRaw = '';

// Track active field
  String activeField = 'card';

  void onDigitPress(String digit) {
    setState(() {
      if (activeField == 'card' && cardRaw.length < 16) {
        cardRaw += digit;
        _cardNumberController.text = formatCardNumber(cardRaw);
      } else if (activeField == 'expiry' && expiryRaw.length < 4) {
        expiryRaw += digit;
        _expiryController.text = formatExpiry(expiryRaw);
      } else if (activeField == 'cvv' && cvvRaw.length < 3) {
        cvvRaw += digit;
        _cvvController.text = cvvRaw;
      }
    });
  }

  void onBackspace() {
    setState(() {
      if (activeField == 'card' && cardRaw.isNotEmpty) {
        cardRaw = cardRaw.substring(0, cardRaw.length - 1);
        _cardNumberController.text = formatCardNumber(cardRaw);
      } else if (activeField == 'expiry' && expiryRaw.isNotEmpty) {
        expiryRaw = expiryRaw.substring(0, expiryRaw.length - 1);
        _expiryController.text = formatExpiry(expiryRaw);
      } else if (activeField == 'cvv' && cvvRaw.isNotEmpty) {
        cvvRaw = cvvRaw.substring(0, cvvRaw.length - 1);
        _cvvController.text = cvvRaw;
      }
    });
  }

  String formatCardNumber(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digits.length) buffer.write(' ');
    }
    return buffer.toString();
  }

  String formatExpiry(String input) {
    if (input.length <= 2) return input;
    return '${input.substring(0, 2)}/${input.substring(2)}';
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: SizedBox(
            width: 60,
            height: 56,
            child: Center(
              child: Image.asset(
                arrowLeft,
                width: width * 0.05,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
              text: "Payment",
              style: ResponsiveTextStyles.labelNotification(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: GColor.grey200,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          creditCard,
                          width: 40,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Pay with card",
                          style: ResponsiveTextStyles.labelPaymentCard(context),
                        )
                      ],
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          selectedValue = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedValue == 1 ? GColor.green : GColor.grey400,
                            width: 4,
                          ),
                        ),
                        child: selectedValue == 1
                            ? const Icon(Icons.circle, size: 12, color: GColor.green)
                            : const SizedBox(width: 12, height: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Card number",
              style: ResponsiveTextStyles.labelDetailCheckout(context),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: GColor.grey200,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTap: () => setState(() => activeField = 'card'),
                      controller: _cardNumberController,
                      readOnly: true, // User uses keypad instead
                      decoration: const InputDecoration(
                        hintText: "Enter card number",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontFamily: "BalooDa",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Image.asset(
                    masterCard,
                    width: 40,
                    height: 40,
                  ),
                  Image.asset(
                    visaCard,
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expiry",
                      style: ResponsiveTextStyles.labelDetailCheckout(context),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: width * 0.44,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: GColor.grey200,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        onTap: () => setState(() => activeField = 'expiry'),
                        controller: _expiryController,
                        readOnly: true, // User uses keypad instead
                        decoration: const InputDecoration(
                          hintText: "",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontFamily: "BalooDa",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CVV",
                      style: ResponsiveTextStyles.labelDetailCheckout(context),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: width * 0.44,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: GColor.grey200,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        onTap: () => setState(() => activeField = 'cvv'),
                        obscureText: true,
                        controller: _cvvController,
                        readOnly: true, // User uses keypad instead
                        decoration: const InputDecoration(
                          hintText: "",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontFamily: "BalooDa",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: showOrderSuccessDialog,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GColor.green
                ),
                child: Center(
                  child: Text(
                    "Confirm and Pay (\$49.00)",
                    style: ResponsiveTextStyles.labelButtonPay(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 320,
        child: CustomKeyNumber(
          controller: getActiveController(),
          onDigitPressed: onDigitPress,
          onBackspace: onBackspace,
        ),
      ),
    );
  }
}
