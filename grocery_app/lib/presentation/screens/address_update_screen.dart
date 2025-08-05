import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/address_widgets/custom_dropdown.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/address_widgets/custom_text_field.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';

class AddressUpdateScreen extends StatefulWidget {
  const AddressUpdateScreen({super.key});

  @override
  State<AddressUpdateScreen> createState() => _AddressUpdateScreenState();
}

class _AddressUpdateScreenState extends State<AddressUpdateScreen> {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final TextEditingController descriptionController = TextEditingController();

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
              text: "Update Address",
              style: ResponsiveTextStyles.labelNotification(context)
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                address,
                width: width * 0.06,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            CustomDropdown(
              items: [
                'Phnom Penh',
                'Siem Reap',
                'Battambang',
                'Kampot',
              ],
              initialValue: 'Phnom Penh',
              onChanged: (value) {},
            ),
            SizedBox(height: 20,),
            CustomDropdown(
              items: [
                'Phnom Penh',
                'Siem Reap',
                'Battambang',
                'Kampot',
              ],
              initialValue: 'Phnom Penh',
              onChanged: (value) {},
            ),
            SizedBox(height: 20,),
            CustomDropdown(
              items: [
                'Phnom Penh',
                'Siem Reap',
                'Battambang',
                'Kampot',
              ],
              initialValue: 'Phnom Penh',
              onChanged: (value) {},
            ),
            SizedBox(height: 20,),
            CustomTextField(
                controller: descriptionController,
                hintText: ""
            ),
            SizedBox(height: 20,),
            CustomTextField(
                controller: descriptionController,
                hintText: ""
            ),
            SizedBox(height: 20,),
            Container(
              width: width,
              height: height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias, // Ensures child respects border radius
              child: Image.asset(
                "assets/images/map.png",
                fit: BoxFit.cover,
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: CustomButton(
            text: "Update",
            onPressed: (){}
        ),
      ),
    );
  }
}
