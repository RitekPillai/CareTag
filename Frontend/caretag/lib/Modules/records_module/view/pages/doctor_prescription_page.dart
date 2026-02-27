import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/records_module/view/widgets/prescription_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/record_option_containe_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorPrescriptionPage extends StatefulWidget {
  const DoctorPrescriptionPage({super.key});

  @override
  State<DoctorPrescriptionPage> createState() => _DoctorPrescriptionPageState();
}

class _DoctorPrescriptionPageState extends State<DoctorPrescriptionPage> {
  int _selectedIndex = 0;
  final double itemHeight = 120.h;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Sample prescription data
  final List<List<Map<String, dynamic>>> prescriptionsByCategory = [
    // General Physician
    [
      {
        "doctorName": "Dr. Mahendra Patel",
        "specialty": "General Physician",
        "condition": "Seasonal Flu & Fever",
        "date": "30 Feb '25",
        "clinic": "Pari Clinic",
        "status": "ACTIVE",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
      {
        "doctorName": "Dr. Rajesh Singh",
        "specialty": "General Physician",
        "condition": "Common Cold",
        "date": "28 Feb '25",
        "clinic": "City Clinic",
        "status": "COMPLETED",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // Cardiologist
    [
      {
        "doctorName": "Dr. Amit Sharma",
        "specialty": "Cardiologist",
        "condition": "Heart Checkup",
        "date": "25 Feb '25",
        "clinic": "Heart Care Center",
        "status": "ACTIVE",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // Physio Therapist
    [
      {
        "doctorName": "Dr. Priya Verma",
        "specialty": "Physio Therapist",
        "condition": "Back Pain Treatment",
        "date": "20 Feb '25",
        "clinic": "Physio Care Clinic",
        "status": "ACTIVE",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // Orthopedic
    [
      {
        "doctorName": "Dr. Vikram Singh",
        "specialty": "Orthopedic",
        "condition": "Knee Surgery Follow-up",
        "date": "18 Feb '25",
        "clinic": "Bone & Joint Center",
        "status": "COMPLETED",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // Dentist
    [
      {
        "doctorName": "Dr. Shreya Patel",
        "specialty": "Dentist",
        "condition": "Root Canal Treatment",
        "date": "15 Feb '25",
        "clinic": "Smile Dental Clinic",
        "status": "ACTIVE",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // Ophthalmologist
    [
      {
        "doctorName": "Dr. Neha Gupta",
        "specialty": "Ophthalmologist",
        "condition": "Eye Checkup",
        "date": "12 Feb '25",
        "clinic": "Vision Care Center",
        "status": "COMPLETED",
        "doctorImage":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
      },
    ],
    // ENT Specialist
    [],
    // Gastroenterologist
    [],
    // Neurologist
    [],
    // Gynecologist
    [],
    // Dermatologist
    [],
    // Pediatrician
    [],
    // Urologist
    [],
    // Oncologist
    [],
  ];

  @override
  Widget build(BuildContext context) {
    String imagePath = "assets/images/records/prescription/";
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> categories = [
      {
        "title": "General\nPhysician",
        "color": Color.fromRGBO(0, 99, 247, 0.2),
        "icon": "general.svg",
      },
      {
        "title": "Cardiologist",
        "color": Color.fromRGBO(229, 32, 48, 0.2),
        "icon": "cardio.svg",
      },
      {
        "title": "Physio\nTherapist",
        "color": Color.fromRGBO(108, 25, 255, 0.2),
        "icon": "physio.svg",
      },
      {
        "title": "Orthopedic",
        "color": Color.fromRGBO(253, 204, 78, 0.2),
        "icon": "ortho.svg",
      },
      {
        "title": "Dentist",
        "color": Color.fromRGBO(232, 70, 136, 0.2),
        "icon": "dentist.svg",
      },
      {
        "title": "Ophthalmo\nLogist",
        "color": Color.fromRGBO(165, 42, 42, 0.2),
        "icon": "eye.svg",
      },
      {
        "title": "ENT \nSpecialist",
        "color": Color.fromRGBO(0, 110, 0, 0.2),
        "icon": "ent.svg",
      },
      {
        "title": "Gastro\nEnterologist",
        "color": Color(0xffD9D9D9),
        "icon": "gasto.svg",
      },
      {
        "title": "Neurologist",
        "color": Color.fromRGBO(137, 100, 232, 0.2),
        "icon": "nero.svg",
      },
      {
        "title": "Gynecologist",
        "color": Color.fromRGBO(255, 0, 0, 0.2),
        "icon": "gynecolo.svg",
      },
      {
        "title": "Dermato\nLogist",
        "color": Color.fromRGBO(198, 134, 66, 0.2),
        "icon": "dermato.svg",
      },
      {
        "title": "Pediatrician",
        "color": Color.fromRGBO(94, 172, 255, 0.2),
        "icon": "pida.svg",
      },
      {
        "title": "Urologist",
        "color": Color.fromRGBO(255, 191, 0, 0.2),
        "icon": "uro.svg",
      },
      {
        "title": "Oncologist",
        "color": Color.fromRGBO(137, 100, 232, 0.2),
        "icon": "oncolor.svg",
      },
    ];

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDEBAR
          SizedBox(
            width: 95.w,
            height: size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(categories.length, (index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: SizedBox(
                          height: itemHeight,
                          width: 130.w,
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            scale: _selectedIndex == index ? 1.05 : 1.0,
                            child: RecordOptionContaineTile(
                              containerColor: categories[index]["color"],
                              imagePath: imagePath + categories[index]["icon"],
                              title: categories[index]["title"],
                              fontSize: 12,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              textColor: Colors.black,
                              scale: _selectedIndex == index ? 1.2 : 1.0,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  right: 0,
                  top:
                      (_selectedIndex * itemHeight) -
                      (_scrollController.hasClients
                          ? _scrollController.offset
                          : 0.0) +
                      (itemHeight * 0.125),
                  child: Container(
                    width: 6.w,
                    height: itemHeight * 0.75,
                    decoration: BoxDecoration(
                      color: const Color(0xff0063F7),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            child: SizedBox(
              height: size.height,
              child: prescriptionsByCategory[_selectedIndex].isEmpty
                  ? Center(
                      child: Text(
                        'No prescriptions found',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(12.w),
                      itemCount: prescriptionsByCategory[_selectedIndex].length,
                      itemBuilder: (context, index) {
                        final prescription =
                            prescriptionsByCategory[_selectedIndex][index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: BlocBuilder<PatientBloc, PatientBlocState>(
                            builder: (context, state) {
                              if (state is AllPrescriptionFetched) {
                                if (state.prescriptionList.isNotEmpty) {
                                  return PrescriptionTile(
                                    doctorName: state
                                        .prescriptionList[index]
                                        .doctorName,
                                    specialty: state
                                        .prescriptionList[index]
                                        .specialization,
                                    condition:
                                        state.prescriptionList[index].diagnosis,
                                    date: state
                                        .prescriptionList[index]
                                        .prescriptionDate,
                                    clinic: state
                                        .prescriptionList[index]
                                        .hospitalName,
                                    status:
                                        state.prescriptionList[index].status,
                                    doctorImage: '',
                                    onDownload: () => print('Download tapped'),
                                    onViewDetails: () =>
                                        print('View Details tapped'),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      'No prescriptions found',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }
                              }
                              if (state is Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Container();
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
