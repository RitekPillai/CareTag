import 'dart:io';

import 'package:caretag/Modules/records_module/model/floderData.dart';
import 'package:caretag/Modules/records_module/view/widgets/file_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/floder_tile.dart';
import 'package:caretag/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectfilesScreen extends StatefulWidget {
  const SelectfilesScreen({super.key});

  @override
  State<SelectfilesScreen> createState() => _SelectfilesScreenState();
}

class _SelectfilesScreenState extends State<SelectfilesScreen> {
  String selectedValue = "All Items";
  Color textColor = Color(0xff94A3B8);
  List<File> files = [];
  List<FolderData> floderList = [
    FolderData(name: "Downloads", path: "/storage/emulated/0/Download"),
    FolderData(name: "Documents", path: "/storage/emulated/0/Documents"),
    FolderData(
      name: "WhatsApp Docs",
      path:
          "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Documents",
    ),
  ];
  List<String> selectedPaths = [];

  void _toggleFileSelection(String path) {
    setState(() {
      if (selectedPaths.contains(path)) {
        selectedPaths.remove(path);
      } else {
        selectedPaths.add(path);
      }
    });
  }

  Future<void> _initFolderData() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isGranted) {
      _loadStorageData();
    }
  }

  Map<String, List<File>> folderFileMap = {};
  List<File> displayedFiles = [];
  String? activeFolder;
  Future<void> _loadStorageData() async {
    Map<String, List<File>> tempMap = {};

    for (var folder in floderList) {
      final dir = Directory(folder.path);
      if (await dir.exists()) {
        try {
          final List<FileSystemEntity> entities = dir.listSync();
          print(
            "Folder ${folder.name} actually contains ${entities.length} total items.",
          );

          List<File> foundFiles = entities.whereType<File>().where((file) {
            String p = file.path.toLowerCase();
            return p.endsWith('.pdf') ||
                p.endsWith('.doc') ||
                p.endsWith('.docx');
          }).toList();

          tempMap[folder.name] = foundFiles;
          folder.count = foundFiles.length;
        } catch (e) {
          debugPrint("!! Error listing ${folder.name}: $e");
        }
      } else {
        print("!! Folder path does not exist: ${folder.path}");
      }
    }

    setState(() {
      folderFileMap = tempMap;
      _showRecentFromAll();
    });
  }

  void _showRecentFromAll() {
    List<File> all = folderFileMap.values.expand((x) => x).toList();

    // Sort by date
    all.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

    setState(() {
      displayedFiles = all.take(5).toList();
      activeFolder = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _initFolderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment(1, 2.2),
            children: [
              Stack(
                children: [
                  SvgPicture.asset("assets/images/records/Ellipse 94.svg"),
                  Positioned(
                    top: 95.h,
                    left: 10.w,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/images/records/arrow.svg",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.h,
                    left: 125.w,

                    child: Text(
                      "Select Files",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              customSearchBar(),
            ],
          ),
          SizedBox(height: 50.h),

          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 16.h),
            child: Text(
              "LOCATIONS",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: textColor,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
              child: Row(
                children: // Inside your Row where you map floderList:
                floderList.map((folder) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        activeFolder = folder.name;
                        // Show ALL files for this specific folder
                        displayedFiles = folderFileMap[folder.name] ?? [];
                      });
                    },
                    child: FloderTile(
                      floderName: folder.name,
                      itemsLen: folder.count,
                      // Pass a 'isSelected' property to your FloderTile to highlight it!
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "RECENT FILES",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontSize: 12.sp,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff0D7FF2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: displayedFiles.length,
              itemBuilder: (context, index) {
                try {
                  final file = displayedFiles[index];
                  final isSelected = selectedPaths.contains(file.path);

                  // Get stats once
                  final stats = file.statSync();
                  final fileSizeFormatted =
                      "${(stats.size / 1024).toStringAsFixed(0)} KB";
                  final fileDateFormatted = stats.modified.toString().split(
                    ' ',
                  )[0];

                  return GestureDetector(
                    onTap: () => _toggleFileSelection(file.path),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: FileTile(
                        fileName: file.path.split('/').last,
                        fileSize: fileSizeFormatted,
                        fileDate: fileDateFormatted,
                        fileType: file.path.toLowerCase().endsWith('.pdf')
                            ? "PDF"
                            : "DOC",
                        isSelected: isSelected,
                      ),
                    ),
                  );
                } catch (e) {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                width: 342.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 127, 242, 1),
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(13, 127, 242, 0.3),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -13,
                      color: Color.fromRGBO(13, 127, 242, 0.3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/records/Container.svg"),
                    SizedBox(width: 5.w),
                    Text(
                      "Upload Selected (${selectedPaths.length})",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterTile(String value) {
    final isSelected = value == selectedValue;

    Color isSelectedTileColor = Color(0xff0D7FF2);
    Color nonSelectedTileColor = Color(0xffF1F5F9);
    Color selectedTileShadowColor = Color.fromRGBO(13, 127, 242, 0.3);
    Color nonSelectedTextColor = Color(0xff475569);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValue = value;
        });
      },
      child: Container(
        width: 89.56.w,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999.r),
          color: isSelected ? isSelectedTileColor : nonSelectedTileColor,
          boxShadow: [
            isSelected
                ? BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: selectedTileShadowColor,
                  )
                : BoxShadow(),
          ],
        ),
        child: Center(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: isSelected ? Colors.white : nonSelectedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
