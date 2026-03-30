import 'dart:developer';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/records_module/model/prescription_model.dart';
import 'package:caretag/Modules/records_module/view/pages/detail_prescription_page.dart';
import 'package:caretag/Modules/records_module/view/widgets/empty_screen_records.dart';
import 'package:caretag/Modules/records_module/view/widgets/prescription_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/record_option_containe_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagonosticDetail extends StatefulWidget {
  const DiagonosticDetail({super.key});

  @override
  State<DiagonosticDetail> createState() => _DiagonosticDetailState();
}

class _DiagonosticDetailState extends State<DiagonosticDetail> {
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

  double get _currentOffset =>
      _scrollController.hasClients ? _scrollController.offset : 0.0;

  @override
  Widget build(BuildContext context) {
    String imagePath = "assets/images/records/";
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> categories = [
      {
        "title": "Labs",
        "color": Color.fromRGBO(108, 25, 255, 0.2),
        "icon": "Vector.svg",
        'spec': 'labs',
      },
      {
        "title": "Scans",
        "color": Color.fromRGBO(0, 0, 0, 0.2),
        "icon": "Vector(1).svg",
        'spec': 'scans',
      },
      {
        "title": "Heart",
        "color": Color.fromRGBO(229, 32, 48, 0.2),
        "icon": "Vector(2).svg",
        "spec": "heart",
      },
      {
        "title": "Infections",
        "color": Color.fromRGBO(220, 237, 200, 1),
        "icon": "Group 481768.svg",
        "spec": "infections",
      },
      {
        "title": "Dentist",
        "color": Color.fromRGBO(232, 70, 136, 0.2),
        "icon": "Vector(5).svg",
        "spec": "infections",
      },
      {
        "title": "Certifications",
        "color": Color.fromRGBO(158, 73, 168, 0.2),
        "icon": "Vector(6).svg",
        "spec": "certification",
      },
    ];
    List<dynamic> getFilteredPrescription(
      List<PrescriptionModel> allPrescriptions,
    ) {
      String selectedTile = categories[_selectedIndex]["spec"];
      return allPrescriptions.where((prescription) {
        String spec = prescription.specialization;
        log(
          "Checking specialization: $spec against selected tile: $selectedTile",
        );
        return spec == selectedTile;
      }).toList();
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            height: size.height,
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
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
                  },
                ),
                //
                AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    return Positioned(
                      right: 0,
                      top:
                          (_selectedIndex * itemHeight) -
                          _currentOffset +
                          (itemHeight * 0.125),
                      child: Container(
                        width: 8.w,
                        height: itemHeight * 0.75,
                        decoration: BoxDecoration(
                          color: const Color(0xff0063F7),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20.r),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<PatientBloc, PatientBlocState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AllPrescriptionFetched) {
                  final filerList = getFilteredPrescription(
                    state.prescriptionList,
                  );
                  if (filerList.isEmpty) {
                    return EmptyRecordsWidget(
                      categoryName: categories[_selectedIndex]["title"],
                      onAddRecord: () {},
                    );
                  } else {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),

                      itemCount: filerList.length,
                      itemBuilder: (context, index) {
                        final prescription = filerList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: PrescriptionTile(
                            doctorName: prescription.doctorName,
                            specialty: prescription.specialization,
                            condition: prescription.diagnosis,
                            date: prescription.prescriptionDate,
                            clinic: prescription.hospitalName,
                            status: prescription.status,
                            doctorImage:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
                            onDownload: () => debugPrint('Download tapped'),
                            onViewDetails: () {
                              context.read<PatientBloc>().add(
                                GetPrescriptionDetail(
                                  prescriptionId: prescription.prescriptionId,
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPrescriptionPage(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: Text("Select a category to view records"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
