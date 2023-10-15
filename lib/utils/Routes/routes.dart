import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/Intro/intro_page.dart';
import 'package:katon/screens/auth/forgot_password/forgot_password.dart';
import 'package:katon/screens/auth/forgot_password/verify_forget_password/verify_forget_password.dart';
import 'package:katon/screens/auth/login/login_page.dart';
import 'package:katon/screens/auth/signup/signup_page.dart';
import 'package:katon/screens/connect/connect_page.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/library_page/book_detail/book_detail_page.dart';
import 'package:katon/screens/library_page/library_page.dart';
import 'package:katon/screens/library_page/videos/library_video_screen.dart';
import 'package:katon/screens/my_library/library_book_detail/library_book_detail_page.dart';
import 'package:katon/screens/my_library/my_library_page.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/setting_page/delete_account/delete_account_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/FAQ/FAQ_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/Privacy%20policy/privacy_policy_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/help_and_support_screen.dart';
import 'package:katon/screens/splash_screen.dart';
import 'package:katon/screens/training/training_details/training_details_page.dart';
import 'package:katon/screens/training/training_options/training_options_page.dart';
import 'package:katon/screens/training/training_page.dart';
import 'package:katon/teacher/teacher_home_page.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/Routes/teacher_route_arguments.dart';
import 'package:katon/utils/config.dart';

import '../../screens/auth/forgot_password/reset_password/reset_password_screen.dart';
import '../../screens/auth/signup/verification_screen/email_verification/email_verification.dart';
import '../../screens/auth/signup/verification_screen/phone_verification/phone_verification.dart';
import '../../screens/auth/signup/verification_screen/signup_success_screen.dart';
import '../../screens/blog_page/Screens/blog_page.dart';
import '../../screens/blog_page/Screens/create_blog/create_blog_page.dart';
import '../../screens/edit_profile/student/edit_profile_page.dart';
import '../../screens/edit_profile/teacher/teacher_edit_profile_page.dart';
import '../../screens/group_page/screens/create_group_blog/create_group_blog_mobile.dart';
import '../../screens/group_page/screens/group_details/group_details_page.dart';
import '../../screens/group_page/screens/group_page.dart';
import '../../screens/library_page/ebook/library_ebook_screen.dart';
import '../../screens/library_page/library_select/library_select_page.dart';
import '../../screens/practice/assignment/practice_assignment_screen.dart';
import '../../screens/practice/self_assessment/self_assessment_screen.dart';
import '../../screens/setting_page/help_and_support/T&C/terms_and_conditions_screen.dart';
import '../../screens/training/online_exam/online_exam_page.dart';
import '../../screens/training/signature/signature_page.dart';
import '../../screens/training/signed_form/signed_form_page.dart';
import '../../screens/training/training_resources/training_resources_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesConst.introPage: (context) => IntroPage(),
    RoutesConst.loginPage: (context) => LoginPage(),
    RoutesConst.signupPage: (context) => SignupPage(),
    RoutesConst.emailVerificationPage: (context) => EmailVerification(),
    RoutesConst.phoneVerificationPage: (context) => PhoneVerification(),
    RoutesConst.signupSuccessPage: (context) => SignupSuccessPage(),
    RoutesConst.forgetPassword: (context) => ForgotPassword(),
    RoutesConst.resetPassword: (context) => ResetPasswordScreen(),
    RoutesConst.forgetPasswordVerification: (context) => VerifyForgetPassword(),
    RoutesConst.editProfile: (context) => (AppPreference().isTeacherLogin)
        ? TeacherEditProfilePage(
            arguments: TeacherRouteArguments()
                .getTeacherArgument(RoutesConst.editProfile),
            title: "teacher_profile".tr)
        : EditProfilePage(
            arguments:
                StudentRouteArguments().getArgument(RoutesConst.editProfile),
            title: "student_profile".tr,
          ),
    RoutesConst.splash: (context) => AnimatedSplashScreen(),
    RoutesConst.home: (context) => HomePage(),
    RoutesConst.bookDetail: (context) => BookDetailPage(),
    RoutesConst.libraryBookDetail: (context) => LibraryBookDetailPage(),
    RoutesConst.eLearning: (context) => LibrarySelectPage(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments().getTeacherArgument(RoutesConst.eLearning)
            : StudentRouteArguments().getArgument(RoutesConst.eLearning)),
    RoutesConst.libraryeBooks: (context) => LibraryEbookScreen(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.libraryeBooks)),
    RoutesConst.libraryvideo: (context) => LibraryVideoScreen(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.libraryvideo)),
    RoutesConst.pastQuestions: (context) => PastQuestionsScreen(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.pastQuestions)),
    RoutesConst.selfAssessment: (context) => SelfAssessmentScreen(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.selfAssessment)),
    RoutesConst.connect: (context) => ConnectPage(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments().getTeacherArgument(RoutesConst.connect)
            : StudentRouteArguments().getArgument(RoutesConst.connect)),
    RoutesConst.helpAndsupport: (context) => HelpAndSupportScreen(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments()
                .getTeacherArgument(RoutesConst.helpAndsupport)
            : StudentRouteArguments().getArgument(RoutesConst.helpAndsupport)),
    RoutesConst.FAQscreen: (context) => FAQScreen(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments().getTeacherArgument(RoutesConst.FAQscreen)
            : StudentRouteArguments().getArgument(RoutesConst.FAQscreen)),
    RoutesConst.termsandcondition: (context) => TermsandConditionScreen(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments()
                .getTeacherArgument(RoutesConst.termsandcondition)
            : StudentRouteArguments()
                .getArgument(RoutesConst.termsandcondition)),
    RoutesConst.privacypolicy: (context) => PrivacyPolicyScreen(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments()
                .getTeacherArgument(RoutesConst.privacypolicy)
            : StudentRouteArguments().getArgument(RoutesConst.privacypolicy)),
    RoutesConst.practiceAssignment: (context) => PracticeAssignmentScreen(
        arguments: (AppPreference().isTeacherLogin)
            ? TeacherRouteArguments()
                .getTeacherArgument(RoutesConst.privacypolicy)
            : StudentRouteArguments().getArgument(RoutesConst.privacypolicy)),
    RoutesConst.assignmentReview: (context) => PracticeAssignmentScreen(
        arguments: TeacherRouteArguments()
            .getTeacherArgument(RoutesConst.assignmentReview)),

    //!Teacher Routes
    RoutesConst.teacherHome: (context) => TeacherHomePage(),
    RoutesConst.myLibrary: (context) => MyLibraryPage(),
    RoutesConst.blogs: (context) => BlogPage(
        arguments:
            TeacherRouteArguments().getTeacherArgument(RoutesConst.blogs)),
    RoutesConst.createblog: (context) => CreateBlogPage(
        arguments:
            TeacherRouteArguments().getTeacherArgument(RoutesConst.createblog)),
    RoutesConst.creategroupblog: (context) => CreateGroupBlogMobile(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.creategroupblog)),
    RoutesConst.group: (context) => GroupPage(
        arguments: StudentRouteArguments().getArgument(RoutesConst.group)),
    RoutesConst.groupdetails: (context) => GroupDetailsPage(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.groupdetails)),
    RoutesConst.deleteAccount: (context) => DeleteAccountScreen(
        arguments:
            StudentRouteArguments().getArgument(RoutesConst.deleteAccount)),
    RoutesConst.training: (context) => TrainingPage(
        arguments:
            TeacherRouteArguments().getTeacherArgument(RoutesConst.training)),
    RoutesConst.trainingDetails: (context) => TrainingDetailsPage(
        arguments: TeacherRouteArguments()
            .getTeacherArgument(RoutesConst.trainingDetails)),
    RoutesConst.trainingOptions: (context) => TrainingOptionsScreen(
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.trainingOptions),
        ),
    RoutesConst.trainingSignature: (context) => SignaturePage(
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.trainingSignature),
        ),
    RoutesConst.trainingSignedform: (context) => SignedFormPage(
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.trainingSignedform),
        ),
    RoutesConst.onlineExam: (context) => OnlineExamPage(
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.onlineExam),
        ),
    RoutesConst.trainingResources: (context) => TrainingResourcesScreen(
          arguments: TeacherRouteArguments()
              .getTeacherArgument(RoutesConst.trainingResources),
        ),
  };
}
