import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({
    super.key,
    required this.courseTitle,
    required this.courseDescription,
    required this.courseRequirementTitle,
    required this.courseRequirement,
    required this.pressed,
    required this.courseId,
  });

  final String courseTitle;
  final String courseDescription;
  final String courseRequirementTitle;
  final String courseRequirement;
  final Function() pressed;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          44,
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            'Course',
            style: kCourseTextStyle,
          ),
          leading: GestureDetector(
            onTap: () {
              AppNavigator.doPop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 24,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseTitle,
              style: kOnboardingLightTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              courseDescription,
              style: GoogleFonts.raleway(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              courseRequirementTitle,
              style: kOnboardingLightTextStyle,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              courseRequirement,
              style: GoogleFonts.raleway(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF504D51),
                height: 1.75,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SubmitToDoPage(courseId: courseId);
                      }),
                    );
                  },
                  child: Container(
                    width: 145,
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFCBADCD),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Submit To-do\'s',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF504D51),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  height: 42,
                  pressed: pressed,
                  color: AppTheme.kPurpleColor,
                  width: 145,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Text(
                        'Take Course',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        'assets/take_course_arrow.svg',
                        height: 10.2,
                        width: 10.2,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
