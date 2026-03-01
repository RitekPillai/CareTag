import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/subscription/payment_selection_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/widgets/custom_controller.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingRegPage extends StatefulWidget {
  const ShippingRegPage({super.key});

  @override
  State<ShippingRegPage> createState() => _ShippingRegPageState();
}

class _ShippingRegPageState extends State<ShippingRegPage> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  String? cityValue;
  String? provinceValue;
  List<String> city = [
    "Mumbai",
    "Delhi",
    "Bengaluru",
    "Hyderabad",
    "Ahmedabad",
    "Chennai",
    "Kolkata",
    "Pune",
    "Surat",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Visakhapatnam",
    "Pimpri-Chinchwad",
    "Patna",
    "Vadodara",
    "Ghaziabad",
    "Ludhiana",
    "Agra",
    "Nashik",
    "Faridabad",
    "Meerut",
    "Rajkot",
    "Kalyan-Dombivli",
    "Vasai-Virar",
    "Varanasi",
    "Srinagar",
    "Aurangabad",
    "Dhanbad",
    "Amritsar",
    "Navi Mumbai",
    "Prayagraj",
    "Howrah",
    "Ranchi",
    "Jabalpur",
    "Gwalior",
    "Coimbatore",
    "Vijayawada",
    "Jodhpur",
    "Madurai",
    "Raipur",
    "Kota",
    "Guwahati",
    "Chandigarh",
    "Solapur",
    "Hubballi-Dharwad",
    "Tiruchirappalli",
    "Tiruppur",
    "Moradabad",
    "Mysuru",
    "Bareilly",
    "Gurugram",
    "Aligarh",
    "Jalandhar",
    "Bhubaneswar",
    "Salem",
    "Mira-Bhayandar",
    "Warangal",
    "Thiruvananthapuram",
    "Guntur",
    "Bhiwandi",
    "Saharanpur",
    "Gorakhpur",
    "Bikaner",
    "Amravati",
    "Noida",
    "Jamshedpur",
    "Bhilai",
    "Cuttack",
    "Firozabad",
    "Kochi",
    "Nellore",
    "Bhavnagar",
    "Dehradun",
    "Durgapur",
    "Asansol",
    "Rourkela",
    "Nanded",
    "Kolhapur",
    "Ajmer",
    "Akola",
    "Gulbarga",
    "Jamnagar",
    "Ujjain",
    "Loni",
    "Siliguri",
    "Jhansi",
    "Ulhasnagar",
    "Nellore",
    "Jammu",
    "Sangli-Miraj & Kupwad",
    "Belgaum",
    "Mangaluru",
    "Ambattur",
    "Tirunelveli",
    "Malegaon",
    "Gaya",
  ];
  List<String> province = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Delhi",
    "Jammu and Kashmir",
    "Ladakh",
    "Lakshadweep",
    "Puducherry",
  ];
  @override
  void dispose() {
    name.dispose();
    address.dispose();
    phoneNumber.dispose();
    postalCode.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> buildMenuItem(List<String> items) => items
      .map(
        (e) => DropdownMenuItem<String>(
          value: e,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(e, style: GoogleFonts.poppins()),
          ),
        ),
      )
      .toList();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, actions: []),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Complete Your Purchase",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  "Secure delivery & payment for your CareTag card",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.lightBlueTextColor2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Enter Shipping Details",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),
              customTextFiled(
                "Full Name",
                "Enter Full Name",
                name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name can not be Empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              customTextFiled(
                textInputType: TextInputType.phone,
                "Phone Number",
                "Enter Phone Number",
                phoneNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone Number can not be Empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              customDropDown("Select Province*", provinceValue, (value) {
                setState(() {
                  provinceValue = value!;
                });
              }, buildMenuItem(province)),
              const SizedBox(height: 20),
              customDropDown("Select City*", cityValue, (value) {
                setState(() {
                  cityValue = value;
                });
              }, buildMenuItem(city)),
              const SizedBox(height: 20),
              customTextFiled(
                "Street Address*",
                "Enter street address",
                address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Street address can not be Empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              customTextFiled(
                "Postal Code*",
                "Enter postal code",
                postalCode,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Postal code can not be Empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Hero(
                tag: "hero",
                child: customElevatedButton(
                  47,
                  182,
                  "Next",
                  20,
                  FontWeight.w500,
                  () {
                    if (_formKey.currentState!.validate() &&
                        cityValue != null &&
                        provinceValue != null) {
                      Navigator.push(
                        context,
                        customRoute(
                          PaymentSelectionPage(
                            shippingregistration: Shippingregistration(
                              paymentType: "",
                              subscriptionType: "YEARLY",
                              city: cityValue!,
                              fullName: name.text,
                              phoneNumber: phoneNumber.text,
                              postalcode: postalCode.text,
                              province: provinceValue!,
                              steetAddress: address.text,
                            ),
                          ),
                          context.read<PatientBloc>(),
                        ),
                      );
                    }
                    if (cityValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("City is Not Selected")),
                      );
                    }
                    if (provinceValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Province is Not Selected")),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customDropDown(
  String title,
  String? value,
  ValueChanged<String?>? onchanged,
  List<DropdownMenuItem<String>>? items,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    width: 316,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade400, width: 1),
      borderRadius: BorderRadius.circular(11),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        items: items,
        onChanged: onchanged,
      ),
    ),
  );
}
