import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/model/RecentActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyCareTimelineScreen extends StatefulWidget {
  const MyCareTimelineScreen({Key? key}) : super(key: key);

  @override
  State<MyCareTimelineScreen> createState() => _MyCareTimelineScreenState();
}

class _MyCareTimelineScreenState extends State<MyCareTimelineScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PatientBloc>().add(LoadTimeline());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimelineHeader(),
        const SizedBox(height: 16),

        BlocBuilder<PatientBloc, PatientBlocState>(
          builder: (context, state) {
            if (state is TimelineLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                ),
              );
            } else if (state is TimelineError) {
              return Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Text(
                    'Unable to load timeline.\n${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (state is TimelineLoaded) {
              if (state.activities.isEmpty) {
                return Center(child: Text("There is no RecentActivity"));
              }

              // If data exists, build the timeline
              return _buildTimelineList(state.activities);
            }

            // Fallback for TimelineInitial
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // ==========================================
  // EMPTY STATE UI
  // ==========================================

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
        bottom: 60.0,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // Faint blue
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.history_toggle_off,
              size: 48,
              color: Color(0xFF93C5FD), // Soft blue
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "No Recent Activity",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Your medical timeline is currently empty.\nNew appointments, lab reports, and prescriptions will appear here automatically.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey.shade500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // HEADER & SEARCH
  // ==========================================

  Widget _buildCurvedHeader() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 180,
            width: double.infinity,
            color: const Color(0xFF3B82F6),
            child: SafeArea(
              child: Center(
                child: Text(
                  'My Care',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -25,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFF93C5FD), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 12.0),
                  child: Icon(Icons.search, color: Colors.black87),
                ),
                Expanded(
                  child: Text(
                    'Search',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.tune, color: Color(0xFF3B82F6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalTabs() {
    final tabs = ['Home', 'CareTag', 'Doctors', 'Care Services', 'Insurance'];
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            bool isSelected = index == 0;
            return Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Text(
                tabs[index],
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================
  // TIMELINE LIST
  // ==========================================

  Widget _buildTimelineHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Timeline',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'All Events',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList(List<RecentActivity> activities) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return _buildTimelineItem(
            activities[index],
            isLast: index == activities.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildTimelineItem(RecentActivity activity, {required bool isLast}) {
    Color iconBgColor = Colors.white;
    Color iconColor = Colors.grey;
    IconData iconData = Icons.event;
    bool isOutlined = true;

    // Theme mapping
    if (activity.activityType == ActivityType.appointment) {
      iconBgColor = const Color(0xFF3B82F6);
      iconColor = Colors.white;
      iconData = Icons.medical_services_outlined;
      isOutlined = false;
    } else if (activity.activityType == ActivityType.labReport) {
      iconColor = const Color(0xFF3B82F6);
      iconData = Icons.science_outlined;
    } else if (activity.activityType == ActivityType.prescription) {
      iconColor = const Color(0xFFF97316);
      iconData = Icons.medication_outlined;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Line and Icon
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  border: isOutlined
                      ? Border.all(color: iconColor, width: 2)
                      : null,
                ),
                child: Icon(iconData, color: iconColor, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: Colors.grey.shade200),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Activity Card
          Expanded(
            // 🚨 Expanded fixes the horizontal RenderFlex overflow!
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            activity.title,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (activity.metadata.containsKey('tag')) ...[
                          _buildTag(
                            activity.activityType,
                            activity.metadata['tag']!,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            _formatTimeAgo(activity.activityDate),
                            style: GoogleFonts.inter(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    if (activity.description.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        activity.description,
                        style: GoogleFonts.inter(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],

                    // Dynamic Sub-Content (PDFs)
                    if (activity.activityType == ActivityType.labReport &&
                        activity.metadata.containsKey('fileName')) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.redAccent,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              // Fixes PDF name overflow
                              child: Text(
                                activity.metadata['fileName']!,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Dynamic Sub-Content (Prescriptions)
                    if (activity.activityType == ActivityType.prescription &&
                        activity.metadata.containsKey('dosage')) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7ED),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              activity.metadata['dosage']!,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFEA580C),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            // Fixes medicine name overflow
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity.metadata['medicine'] ?? '',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  activity.metadata['instruction'] ?? '',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(ActivityType type, String text) {
    Color bgColor;
    Color textColor;
    switch (type) {
      case ActivityType.appointment:
        bgColor = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF1D4ED8);
        break;
      case ActivityType.labReport:
        bgColor = const Color(0xFFF3E8FF);
        textColor = const Color(0xFF7E22CE);
        break;
      case ActivityType.prescription:
        bgColor = const Color(0xFFFFEDD5);
        textColor = const Color(0xFFC2410C);
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.black54;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }
}

// Custom Clipper for Header
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 10,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
