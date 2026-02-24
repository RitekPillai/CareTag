import 'package:caretag/Modules/records_module/view/widgets/record_option_containe_tile.dart';
import 'package:flutter/material.dart';

class DoctorPrescriptionPage extends StatelessWidget {
  const DoctorPrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                RecordOptionContaineTile(
                  containerColor: Colors.lightBlueAccent,
                  imagePath: "assets/images/records/pdf.svg",
                  title: "General\nPhysician",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Text("2")),
      ],
    );
  }
}
