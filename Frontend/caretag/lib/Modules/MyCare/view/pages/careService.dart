import 'package:caretag/Modules/MyCare/view/pages/careService/care_service_category.dart';
import 'package:caretag/Modules/MyCare/view/pages/careService/dignosisDetailPage.dart';
import 'package:caretag/Modules/MyCare/view/pages/careService/hospital_detail_page.dart';
import 'package:caretag/Modules/MyCare/view/widgets/digonissi_nearby_tie.dart';
import 'package:caretag/Modules/MyCare/view/widgets/hospital_nearby_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class CsHospital {
  const CsHospital({
    required this.name,
    required this.specialties,
    required this.rating,
    required this.distance,
    required this.isOpen24,
    required this.address,
    required this.about,
    required this.imageGradient,
    required this.doctors,
  });

  final String name;
  final List<String> specialties;
  final double rating;
  final String distance;
  final bool isOpen24;
  final String address;
  final String about;
  final List<Color> imageGradient;
  final List<CsDoctor> doctors;
}

class CsDoctor {
  const CsDoctor({
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.avatarColor,
    required this.qualifications,
    required this.about,
    required this.slots,
  });

  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final Color avatarColor;
  final String qualifications;
  final String about;
  final List<String> slots;
}

class CsDiagnostics {
  const CsDiagnostics({
    required this.name,
    required this.tests,
    required this.rating,
    required this.distance,
    required this.nextSlot,
    required this.homeVisit,
    required this.isTopRated,
    required this.address,
    required this.about,
    required this.imageGradient,
    required this.testList,
  });

  final String name;
  final List<String> tests;
  final double rating;
  final String distance;
  final String nextSlot;
  final bool homeVisit;
  final bool isTopRated;
  final String address;
  final String about;
  final List<Color> imageGradient;
  final List<CsTestItem> testList;
}

class CsTestItem {
  const CsTestItem({
    required this.name,
    required this.price,
    required this.duration,
    required this.homeVisit,
  });

  final String name;
  final String price;
  final String duration;
  final bool homeVisit;
}

class CsCategory {
  const CsCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.bg,
  });

  final String name;
  final IconData icon;
  final Color color;
  final Color bg;
}

// ── Sample data ───────────────────────────────────────────────────────────────

final _sampleDoctors1 = [
  const CsDoctor(
    name: 'Dr. James Smith',
    specialty: 'Cardiologist',
    experience: '12 yrs',
    rating: 4.8,
    avatarColor: Color(0xFF3B82F6),
    qualifications: 'MBBS, MD (Cardiology), DM',
    about:
        'Dr. James Smith is a senior cardiologist with over 12 years of experience in interventional cardiology. He specializes in angioplasty, bypass surgery consultation, and heart failure management.',
    slots: ['9:00 AM', '10:30 AM', '2:00 PM', '4:30 PM'],
  ),
  const CsDoctor(
    name: 'Dr. Priya Nair',
    specialty: 'Neurologist',
    experience: '9 yrs',
    rating: 4.7,
    avatarColor: Color(0xFF7C3AED),
    qualifications: 'MBBS, MD (Neurology)',
    about:
        'Dr. Priya Nair has 9 years of expertise in treating neurological disorders including epilepsy, migraines, stroke rehabilitation, and Parkinson\'s disease.',
    slots: ['11:00 AM', '1:00 PM', '3:30 PM'],
  ),
  const CsDoctor(
    name: 'Dr. Arjun Mehta',
    specialty: 'Emergency Medicine',
    experience: '7 yrs',
    rating: 4.6,
    avatarColor: Color(0xFFEF4444),
    qualifications: 'MBBS, DNB (Emergency Medicine)',
    about:
        'Dr. Arjun Mehta leads the emergency department at City General, specializing in trauma care, critical care management, and emergency interventions.',
    slots: ['8:00 AM', '12:00 PM', '5:00 PM', '7:00 PM'],
  ),
];

final _sampleDoctors2 = [
  const CsDoctor(
    name: 'Dr. Sunita Rao',
    specialty: 'Pediatrician',
    experience: '14 yrs',
    rating: 4.9,
    avatarColor: Color(0xFF22C55E),
    qualifications: 'MBBS, MD (Pediatrics), Fellowship in Neonatology',
    about:
        'Dr. Sunita Rao is a highly regarded pediatrician specializing in neonatal care, child development, and pediatric infectious diseases with 14 years of clinical experience.',
    slots: ['9:30 AM', '11:30 AM', '3:00 PM'],
  ),
  const CsDoctor(
    name: 'Dr. Rakesh Kumar',
    specialty: 'Orthopedic Surgeon',
    experience: '16 yrs',
    rating: 4.8,
    avatarColor: Color(0xFFF97316),
    qualifications: 'MBBS, MS (Orthopaedics), Fellowship in Joint Replacement',
    about:
        'Dr. Rakesh Kumar is a senior orthopedic surgeon specializing in joint replacement, sports injuries, arthroscopy, and spinal procedures.',
    slots: ['10:00 AM', '2:30 PM', '4:00 PM'],
  ),
];

final _hospitals = [
  CsHospital(
    name: 'City General Hospital',
    specialties: ['Cardiology', 'Neurology', 'Emergency'],
    rating: 4.8,
    distance: '1.2 km',
    isOpen24: true,
    address: '14, Park Street, Sector 5, Near Central Park',
    about:
        'City General Hospital is a 500-bed multi-speciality hospital with state-of-the-art infrastructure. Established in 1985, it has been serving the community with world-class medical care across 25+ specialities.',
    imageGradient: [Color(0xFF1E3A5F), Color(0xFF2D6A9F)],
    doctors: _sampleDoctors1,
  ),
  CsHospital(
    name: 'St. Mary\'s Medical Centre',
    specialties: ['Pediatrics', 'Orthopedics', 'Gynecology'],
    rating: 4.6,
    distance: '2.8 km',
    isOpen24: true,
    address: '2, Church Road, Sec 9, Near Metro Station',
    about:
        'St. Mary\'s Medical Centre is a premier 300-bed hospital known for excellence in maternal-child health, orthopedic care, and minimally invasive surgical procedures.',
    imageGradient: [Color(0xFF1A5276), Color(0xFF21618C)],
    doctors: _sampleDoctors2,
  ),
  CsHospital(
    name: 'Apollo Health Centre',
    specialties: ['Oncology', 'Cardiology', 'Nephrology'],
    rating: 4.9,
    distance: '4.1 km',
    isOpen24: false,
    address: '7A, Ring Road, Phase 2, Greenfield Layout',
    about:
        'Apollo Health Centre is a flagship tertiary care hospital offering cutting-edge treatments in oncology, organ transplantation, and cardiology through its team of 200+ specialist doctors.',
    imageGradient: [Color(0xFF0F4C75), Color(0xFF1B6CA8)],
    doctors: _sampleDoctors1,
  ),
];

final _diagnostics = [
  CsDiagnostics(
    name: 'MediCare Diagnostics',
    tests: ['Blood Test', 'MRI', 'X-Ray'],
    rating: 4.7,
    distance: '0.8 km',
    nextSlot: '2:00 PM',
    homeVisit: false,
    isTopRated: true,
    address: '3, Main Market, Sector 4',
    about:
        'MediCare Diagnostics is a NABL-accredited laboratory offering 500+ tests with digital report delivery. Equipped with high-field 1.5T MRI and 128-slice CT scanners.',
    imageGradient: [Color(0xFF064E3B), Color(0xFF065F46)],
    testList: [
      CsTestItem(
        name: 'Complete Blood Count (CBC)',
        price: '₹350',
        duration: '6 hrs',
        homeVisit: true,
      ),
      CsTestItem(
        name: 'MRI Brain',
        price: '₹4,500',
        duration: '1 hr',
        homeVisit: false,
      ),
      CsTestItem(
        name: 'Chest X-Ray',
        price: '₹300',
        duration: '30 min',
        homeVisit: false,
      ),
      CsTestItem(
        name: 'Thyroid Profile (T3/T4/TSH)',
        price: '₹650',
        duration: '12 hrs',
        homeVisit: true,
      ),
      CsTestItem(
        name: 'Lipid Profile',
        price: '₹450',
        duration: '8 hrs',
        homeVisit: true,
      ),
    ],
  ),
  CsDiagnostics(
    name: 'PathLabs Centre',
    tests: ['Full Body Checkup', 'Urine Test'],
    rating: 4.4,
    distance: '1.5 km',
    nextSlot: '4:00 PM',
    homeVisit: true,
    isTopRated: false,
    address: '22, Green Avenue, Block B',
    about:
        'PathLabs Centre provides affordable, reliable diagnostic services with home sample collection available across the city. NABL and ISO 15189 certified.',
    imageGradient: [Color(0xFF1E3A5F), Color(0xFF1F618D)],
    testList: [
      CsTestItem(
        name: 'Full Body Checkup (65 tests)',
        price: '₹1,999',
        duration: '24 hrs',
        homeVisit: true,
      ),
      CsTestItem(
        name: 'Urine Routine',
        price: '₹120',
        duration: '4 hrs',
        homeVisit: true,
      ),
      CsTestItem(
        name: 'Blood Sugar (Fasting)',
        price: '₹80',
        duration: '4 hrs',
        homeVisit: true,
      ),
      CsTestItem(
        name: 'HbA1c',
        price: '₹550',
        duration: '8 hrs',
        homeVisit: true,
      ),
    ],
  ),
  CsDiagnostics(
    name: 'LifeMed Scan Centre',
    tests: ['CT Scan', 'Ultrasound', 'ECG'],
    rating: 4.6,
    distance: '2.2 km',
    nextSlot: '11:00 AM',
    homeVisit: false,
    isTopRated: false,
    address: '5, Hospital Road, Medical Block',
    about:
        'LifeMed Scan Centre specialises in advanced imaging diagnostics with 256-slice CT, 3T MRI, and real-time ultrasound units staffed by specialist radiologists.',
    imageGradient: [Color(0xFF312E81), Color(0xFF4338CA)],
    testList: [
      CsTestItem(
        name: 'CT Scan Abdomen',
        price: '₹3,800',
        duration: '1 hr',
        homeVisit: false,
      ),
      CsTestItem(
        name: 'Ultrasound Whole Abdomen',
        price: '₹800',
        duration: '45 min',
        homeVisit: false,
      ),
      CsTestItem(
        name: 'ECG (12-lead)',
        price: '₹200',
        duration: '15 min',
        homeVisit: false,
      ),
    ],
  ),
];

const _categories = [
  CsCategory(
    name: 'Dentist',
    icon: Icons.medical_information_outlined,
    color: Color(0xFF3B82F6),
    bg: Color(0xFFEFF6FF),
  ),
  CsCategory(
    name: 'Heart',
    icon: Icons.favorite_border_rounded,
    color: Color(0xFFEC4899),
    bg: Color(0xFFFDF2F8),
  ),
  CsCategory(
    name: 'Eye',
    icon: Icons.remove_red_eye_outlined,
    color: Color(0xFFF97316),
    bg: Color(0xFFFFF7ED),
  ),
  CsCategory(
    name: 'Ortho',
    icon: Icons.accessibility_new_rounded,
    color: Color(0xFF22C55E),
    bg: Color(0xFFF0FDF4),
  ),
  CsCategory(
    name: 'Neuro',
    icon: Icons.psychology_outlined,
    color: Color(0xFF7C3AED),
    bg: Color(0xFFF5F3FF),
  ),
  CsCategory(
    name: 'Pediatric',
    icon: Icons.child_care_outlined,
    color: Color(0xFF0EA5E9),
    bg: Color(0xFFF0F9FF),
  ),
  CsCategory(
    name: 'Skin',
    icon: Icons.face_retouching_natural,
    color: Color(0xFFF59E0B),
    bg: Color(0xFFFFFBEB),
  ),
  CsCategory(
    name: 'More',
    icon: Icons.grid_view_rounded,
    color: Color(0xFF6B7280),
    bg: Color(0xFFF3F4F6),
  ),
];

class MyCareCareServicesContent extends StatelessWidget {
  const MyCareCareServicesContent({super.key});

  @override
  Widget build(BuildContext context) {
    const Color redColor = Color(0xffEF4444);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99999.r),
                    color: redColor,
                  ),
                ),
                SizedBox(width: 7.w),
                Text(
                  "Emergency Help",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: Color(0xff111817),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              width: 358.w,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              decoration: BoxDecoration(
                color: Color(0xffFEF2F2),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFFFECACA)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColor.getShadowColor(0.05),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 210.w,
                        child: Opacity(
                          opacity: 0.2,
                          child: SvgPicture.asset(
                            "assets/images/mycare/alram.svg",
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  color: AppColor.getShadowColor(0.05),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/images/home/dialog/hospital.svg",
                                // ignore: deprecated_member_use
                                color: redColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Emergency SOS',
                                  style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                Text(
                                  'Instant ambulance & paramedic\ndispatch',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Container(
                    width: 316.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: redColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: -4,
                          color: redColor.withValues(alpha: 0.3),
                        ),
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 15,
                          spreadRadius: -3,
                          color: redColor.withValues(alpha: 0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Call Ambulance Now",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hospitals Nearby',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CareServicesCategoryResultsPage(
                        categoryName: 'Hospitals Nearby',
                        hospitals: _hospitals,
                        diagnostics: const [],
                      ),
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0063F7),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            HospitalNearbyTile(),
            SizedBox(height: 40.h),
            DigonissiNearbyTie(),
          ],
        ),
      ),
    );
  }
}
