// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/report_api.dart';

import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/components/widgets.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  final String reportId;
  const FeedbackPage({
    super.key,
    required this.reportId,
  });

  @override
  ConsumerState<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  TextEditingController textController = TextEditingController();
  final textKey = GlobalKey<FormState>();

  bool _isButtonClicked = false;

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
            'Give Feedback',
            style: kCourseTextStyle,
          ),
          leading: InkWell(
            onTap: () {
              context.canPop()
                  ? context.pop()
                  : context.pushReplacement(HomeScreen.route);
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: textKey,
              child: TextFormField(
                controller: textController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'value cannot be null';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB7B6B8),
                    ),
                  ),
                  hintText: 'Write your Feedback here',
                  hintStyle: GoogleFonts.raleway(
                    color: const Color(
                      0xFF9A989A,
                    ),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 56,
            ),
            CustomButton(
              height: 54,
              pressed: _isButtonClicked
                  ? null
                  : () async {
                      if (textKey.currentState!.validate()) {
                        setState(() {
                          _isButtonClicked = true;
                        });

                        DecodedTokenResponse? response =
                            await SharedPreferencesUtil.getModel<
                                    DecodedTokenResponse>(
                                SharedPrefKeys.tokenResponse,
                                (json) => DecodedTokenResponse.fromJson(json));
                        await ref
                            .read(apiReportProvider)
                            .giveReportFeedback(widget.reportId, {
                          "mentor_id": "${response?.userId}",
                          "mentor_feedback": textController.text,
                        });
                        setState(() {
                          _isButtonClicked = false;
                        });
                        popUpCard(
                          context,
                          'Hello!',
                          error.isEmpty ? message[0] : error[0],
                          () => error.isEmpty
                              ? context.go(MentorPageSkeleton.route)
                              : context.pop(),
                        );
                      }
                    },
              color: AppTheme.kPurpleColor,
              width: double.infinity,
              elevation: 0,
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: _isButtonClicked
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Submit Feedback',
                        style: GoogleFonts.raleway(
                          color: AppTheme.kAppWhiteScheme,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
