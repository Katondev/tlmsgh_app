import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/about_page/about_page.dart';
import 'package:katon/screens/calender/calenderPage.dart';
import 'package:katon/screens/connect/connect_page.dart';
import 'package:katon/screens/library_page/book_detail/book_detail_page.dart';
import 'package:katon/screens/library_page/ebook/library_ebook_tablet.dart';
import 'package:katon/screens/library_page/library_page.dart';
import 'package:katon/screens/library_page/videos/library_video_tablet.dart';
import 'package:katon/screens/live_class/live_class_details/live_class_details_page.dart';
import 'package:katon/screens/live_class/live_class_page.dart';
import 'package:katon/screens/my_library/library_book_detail/library_book_detail_page.dart';
import 'package:katon/screens/my_library/my_library_page.dart';
import 'package:katon/screens/notification/notification_page.dart';
import 'package:katon/screens/past_paper/past_paper_details/past_paper_details.dart';
import 'package:katon/screens/past_paper/past_paper_page.dart';
import 'package:katon/screens/practice/assignment/practice_assignment_screen.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/practice/practice_details/mcq_test.dart';
import 'package:katon/screens/practice/teacher/assignment_review/assignment_review_screen.dart';
import 'package:katon/screens/practice/teacher/practice_page.dart';
import 'package:katon/screens/self_assessment/self_assesment_page.dart';
import 'package:katon/screens/setting_page/delete_account/delete_account_screen.dart';
import 'package:katon/screens/setting_page/setting_page.dart';
import 'package:katon/screens/training/signature/signature_page.dart';
import 'package:katon/screens/training/training_details/training_details_page.dart';
import 'package:katon/screens/training/training_options/training_options_page.dart';
import 'package:katon/screens/training/training_page.dart';
import 'package:katon/utils/Routes/teacher_route_arguments.dart';
import 'package:katon/utils/config.dart';

import '../../screens/blog_page/Screens/blog_page.dart';
import '../../screens/blog_page/Screens/create_blog/create_blog_page.dart';
import '../../screens/edit_profile/teacher/teacher_edit_profile_page.dart';
import '../../screens/library_page/ebook/library_ebook_screen.dart';
import '../../screens/library_page/library_select/library_select_page.dart';
import '../../screens/library_page/videos/library_video_screen.dart';
import '../../screens/practice/practice_subject/practice_subject_page.dart';
import '../../screens/practice/self_assessment/self_assessment_screen.dart';
import '../../screens/setting_page/change_password/change_password.dart';
import '../../screens/setting_page/help_and_support/FAQ/FAQ_screen.dart';
import '../../screens/setting_page/help_and_support/Privacy policy/privacy_policy_screen.dart';
import '../../screens/setting_page/help_and_support/T&C/terms_and_conditions_screen.dart';
import '../../screens/setting_page/help_and_support/help_and_support_screen.dart';
import '../../screens/training/online_exam/online_exam_page.dart';
import '../../screens/training/signed_form/signed_form_page.dart';
import '../../screens/training/training_resources/training_resources_screen.dart';

class TeacherPageRoute {
  PageRouteBuilder getTeacherPageRoute(RouteSettings settings, String? name) {
    switch (name) {
      // case RoutesConst.teacherHome:
      //   return PageRouteBuilder(
      //       settings: settings,
      //       pageBuilder: (_, __, ___) => DashBoard(
      //           arguments: TeacherRouteArguments()
      //               .getTeacherArgument(RoutesConst.teacherHome)),
      //       transitionsBuilder: (_, a, __, c) =>
      //           FadeTransition(opacity: a, child: c));
      case RoutesConst.eLearning:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibrarySelectPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.eLearning)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.pastQuestions:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PastQuestionsScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.pastQuestions)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.selfAssessment:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SelfAssessmentScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.selfAssessment)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.libraryeBooks:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryEbookScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.libraryeBooks)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.connect:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => ConnectPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.connect)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.libraryvideo:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryVideoScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.libraryvideo)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.bookDetail:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const BookDetailPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      // case RoutesConst.connect:
      //   return PageRouteBuilder(
      //            settings: settings,
      //            pageBuilder: (_, __, ___) => ConnectPage(
      //                arguments: TeacherRouteArguments().getTeacherArgument(RoutesConst.connect)),
      //            transitionsBuilder: (_, a, __, c) =>
      //                FadeTransition(opacity: a, child: c));
      // case RoutesConst.selfAssessment:
      //   return PageRouteBuilder(
      //         settings: settings,
      //         pageBuilder: (_, __, ___) => SelfAssessmentPage(
      //             arguments: TeacherRouteArguments().getTeacherArgument(RoutesConst.selfAssessment)),
      //         transitionsBuilder: (_, a, __, c) =>
      //             FadeTransition(opacity: a, child: c));
      //     }
      case RoutesConst.training:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TrainingPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.training)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.trainingDetails:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TrainingDetailsPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.trainingDetails)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.trainingOptions:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TrainingOptionsScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.trainingOptions)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.trainingSignature:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SignaturePage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.trainingSignature)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.trainingSignedform:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SignedFormPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.trainingSignedform)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.onlineExam:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => OnlineExamPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.onlineExam)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.trainingResources:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TrainingResourcesScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.trainingResources)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.changePassword:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => ChangePassword(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.changePassword)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.aboutUs:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => AboutPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.aboutUs)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.setting:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SettingPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.setting)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.deleteAccount:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => DeleteAccountScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.deleteAccount)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      // case RoutesConst.examResult:
      //   return PageRouteBuilder(
      //           settings: settings,
      //           pageBuilder: (_, __, ___) => ExamResultPage(
      //               arguments: TeacherRouteArguments().getTeacherArgument(RoutesConst.examResult)),
      //           transitionsBuilder: (_, a, __, c) =>
      //               FadeTransition(opacity: a, child: c));
      case RoutesConst.notification:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => NotificationPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.notification)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.calender:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CalenderPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.calender)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.myLibrary:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => MyLibraryPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.myLibrary)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.blogs:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => BlogPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.blogs)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.createblog:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CreateBlogPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.createblog)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.editProfile:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TeacherEditProfilePage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.editProfile),
                title: 'teacher_profile'.tr),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      // case RoutesConst.orderHistory:
      // return PageRouteBuilder(
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => OrderHistoryPage(
      //         arguments: TeacherRouteArguments().getTeacherArgument(RoutesConst.orderHistory)),
      //     transitionsBuilder: (_, a, __, c) =>
      //         FadeTransition(opacity: a, child: c));
      case RoutesConst.libraryBookDetail:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryBookDetailPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.oldQuestionSet:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PastPaperPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.oldQuestionSet)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.pastPaperDetails:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PastPaperDetails(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.practice:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PracticeTeacherPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.practice)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));


      case RoutesConst.practiceSubject:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PracticeSubjectPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.practiceSubject)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
                 case RoutesConst.eLearningcard:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.eLearningcard)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.assignmentDetails:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => McqTest(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.liveClass:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LiveClassPage(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.liveClass)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.liveClassDetails:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LiveClassDetailsPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.helpAndsupport:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => HelpAndSupportScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.helpAndsupport)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.FAQscreen:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => FAQScreen(
                arguments: TeacherRouteArguments()
                    .getTeacherArgument(RoutesConst.FAQscreen)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.termsandcondition:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => TermsandConditionScreen(
              arguments: TeacherRouteArguments()
                  .getTeacherArgument(RoutesConst.termsandcondition)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.privacypolicy:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PrivacyPolicyScreen(
              arguments: TeacherRouteArguments()
                  .getTeacherArgument(RoutesConst.privacypolicy)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.practiceAssignment:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PracticeAssignmentScreen(
              arguments: TeacherRouteArguments()
                  .getTeacherArgument(RoutesConst.practiceAssignment)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.assignmentReview:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => AssignmentReviewScreen(
              arguments: TeacherRouteArguments()
                  .getTeacherArgument(RoutesConst.assignmentReview)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Scaffold(
            appBar: AppBar(title: Text(settings.name.toString())),
            body: SafeArea(child: Text(settings.name.toString())),
          ),
          transitionsBuilder: (_, a, __, c) => FadeTransition(
            opacity: a,
            child: c,
          ),
        );
    }
  }
}
