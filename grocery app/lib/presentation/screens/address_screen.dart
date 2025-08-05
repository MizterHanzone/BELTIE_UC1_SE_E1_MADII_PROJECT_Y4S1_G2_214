import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:online_grocery_delivery_app/core/constant/responsive_font.dart';
import 'package:online_grocery_delivery_app/core/theme/color.dart';
import 'package:online_grocery_delivery_app/core/theme/icon.dart';
import 'package:online_grocery_delivery_app/data/controller/address_controller/address_controller.dart';
import 'package:online_grocery_delivery_app/data/models/address_model.dart';
import 'package:online_grocery_delivery_app/presentation/widgets/auth_widgets/button.dart';
import 'package:online_grocery_delivery_app/route/app_route.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GAddress addressController = Get.put(GAddress());

  @override
  void initState() {
    super.initState();
    Future.microtask(() => addressController.fetchAddresses());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: GColor.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
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
            text: "Address",
            style: ResponsiveTextStyles.labelNotification(context),
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
      body: Stack(
        children: [
          // Image.asset(
          //   "assets/images/map.png",
          //   width: width,
          //   fit: BoxFit.cover,
          // ),
          Obx(() {
            if (addressController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (addressController.addresses.isEmpty) {
              return const Center(child: Text("No address available"));
            }

            final address = addressController.addresses.first;

            final lat = double.tryParse(address.latitude ?? '11.5564') ?? 11.5564;
            final lng = double.tryParse(address.longitude ?? '104.9282') ?? 104.9282;

            return SizedBox(
              width: width,
              height: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("address_marker"),
                    position: LatLng(lat, lng),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  // Optional
                },
              ),
            );
          }),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              if (addressController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (addressController.addresses.isEmpty) {
                return Center(
                  child: Container(
                    width: width * 0.95,
                    height: height * 0.20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text("No address found"),
                    ),
                  ),
                );
              }

              UserAddress address = addressController.addresses.first;

              return Center(
                child: Container(
                  width: width * 0.95,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    color: GColor.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(building, width: 30),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "${address.village ?? ''},  ${address.commune ?? ''}, ${address.district ?? ''}, ${address.province ?? ''}",
                                style: ResponsiveTextStyles.labelAddress(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(signpost, width: 30),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "${address.street ?? ''}, ${address.houseNumber ?? ''}",
                                style: ResponsiveTextStyles.labelAddress(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(phone, width: 30),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                address.phone,
                                style: ResponsiveTextStyles.labelAddress(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: "Update",
                          onPressed: () {
                            Get.toNamed(AppRoutes.addressUpdate, arguments: address);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
