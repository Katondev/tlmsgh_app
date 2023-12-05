import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/about_page/about_page.dart';
import 'package:katon/screens/blog_page/Screens/blog_page.dart';
import 'package:katon/screens/calender/calenderPage.dart';
import 'package:katon/screens/connect/connect_page.dart';
import 'package:katon/screens/group_page/screens/group_details/group_details_page.dart';
import 'package:katon/screens/library_page/book_detail/book_detail_page.dart';
import 'package:katon/screens/library_page/library_page.dart';
import 'package:katon/screens/library_page/videos/library_video_screen.dart';
import 'package:katon/screens/live_class/live_class_page.dart';
import 'package:katon/screens/my_library/library_book_detail/library_book_detail_page.dart';
import 'package:katon/screens/my_library/my_library_page.dart';
import 'package:katon/screens/notification/notification_page.dart';
import 'package:katon/screens/past_paper/past_paper_details/past_paper_details.dart';
import 'package:katon/screens/past_paper/past_paper_page.dart';
import 'package:katon/screens/practice/assignment/practice_assignment_screen.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/practice/practice_details/mcq_test.dart';
import 'package:katon/screens/practice/practice_subject/practice_subject_page.dart';
import 'package:katon/screens/practice/student/practice_page.dart';
import 'package:katon/screens/self_assessment/self_assesment_page.dart';
import 'package:katon/screens/setting_page/delete_account/delete_account_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/FAQ/FAQ_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/Privacy%20policy/privacy_policy_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/T&C/terms_and_conditions_screen.dart';
import 'package:katon/screens/setting_page/help_and_support/help_and_support_screen.dart';
import 'package:katon/screens/setting_page/setting_page.dart';
import 'package:katon/screens/training/training_page.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import '../../screens/blog_page/Screens/create_blog/create_blog_page.dart';
import '../../screens/edit_profile/student/edit_profile_page.dart';
import '../../screens/group_page/screens/create_group_blog/create_group_blog_mobile.dart';
import '../../screens/group_page/screens/group_page.dart';
import '../../screens/library_page/ebook/library_ebook_screen.dart';
import '../../screens/library_page/library_select/library_select_page.dart';
import '../../screens/live_class/live_class_details/live_class_details_page.dart';
import '../../screens/setting_page/change_password/change_password.dart';

class StudentPageRoute {
  PageRouteBuilder getPageRoute(RouteSettings settings, String? name) {
    switch (name) {
      // case RoutesConst.home:
      //   return PageRouteBuilder(
      //       settings: settings,
      //       pageBuilder: (_, __, ___) => DashBoard(
      //           arguments:
      //               StudentRouteArguments().getArgument(RoutesConst.home)),
      //       transitionsBuilder: (_, a, __, c) =>
      //           FadeTransition(opacity: a, child: c));
      case RoutesConst.eLearning:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => LibrarySelectPage(
              arguments:
                  StudentRouteArguments().getArgument(RoutesConst.eLearning)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.libraryeBooks:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => LibraryEbookScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.libraryeBooks)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.libraryvideo:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => LibraryVideoScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.libraryvideo)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );//book
        //   case RoutesConst.videobokQuestions:
        // return PageRouteBuilder(
        //   settings: settings,
        //   pageBuilder: (_, __, ___) => VideoAndBookRelatedQuestions(
        //       arguments: StudentRouteArguments()
        //           .getArgument(RoutesConst.videobokQuestions)),
        //   transitionsBuilder: (_, a, __, c) =>
        //       FadeTransition(opacity: a, child: c),
        // );
      case RoutesConst.pastQuestions:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PastQuestionsScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.pastQuestions)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      // case RoutesConst.selfAssessment:
      //   return PageRouteBuilder(
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => SelfAssessmentScreen(
      //         arguments: StudentRouteArguments()
      //             .getArgument(RoutesConst.selfAssessment)),
      //     transitionsBuilder: (_, a, __, c) =>
      //         FadeTransition(opacity: a, child: c),
      //   );
      case RoutesConst.bookDetail:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const BookDetailPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.connect:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => ConnectPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.connect)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.selfAssessment:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SelfAssessmentPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.selfAssessment)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));

      case RoutesConst.training:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => TrainingPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.training)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.changePassword:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => ChangePassword(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.changePassword)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.aboutUs:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => AboutPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.aboutUs)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.setting:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => SettingPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.setting)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      // case RoutesConst.examResult:
      //   return PageRouteBuilder(
      //           settings: settings,
      //           pageBuilder: (_, __, ___) => ExamResultPage(
      //               arguments: StudentRouteArguments().getArgument(RoutesConst.examResult)),
      //           transitionsBuilder: (_, a, __, c) =>
      //               FadeTransition(opacity: a, child: c));
      case RoutesConst.notification:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => NotificationPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.notification)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.calender:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CalenderPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.calender)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.blogs:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => BlogPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.blogs)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.createblog:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CreateBlogPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.createblog)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.creategroupblog:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CreateGroupBlogMobile(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.creategroupblog)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.group:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => GroupPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.group)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.groupdetails:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => GroupDetailsPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.groupdetails)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.myLibrary:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => MyLibraryPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.myLibrary)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.editProfile:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => EditProfilePage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.editProfile),
                title: "student_profile".tr),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      // case RoutesConst.orderHistory:
      // return PageRouteBuilder(
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => OrderHistoryPage(
      //         arguments: StudentRouteArguments().getArgument(RoutesConst.orderHistory)),
      //     transitionsBuilder: (_, a, __, c) =>
      //         FadeTransition(opacity: a, child: c));
      
       case RoutesConst.libraryBookDetail:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryBookDetailPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
                  case RoutesConst.libraryBookDetail:
                  
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryBookDetailPage(),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
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
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.oldQuestionSet)),
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
            pageBuilder: (_, __, ___) => PracticeStudentPage(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.practice)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
                
      case RoutesConst.practiceSubject:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => PracticeSubjectPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.practiceSubject)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
  case RoutesConst.eLearningcard:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LibraryPage(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.eLearningcard)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));

      case RoutesConst.deleteAccount:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => DeleteAccountScreen(
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.deleteAccount)),
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
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.liveClass)),
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
                arguments: StudentRouteArguments()
                    .getArgument(RoutesConst.helpAndsupport)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.FAQscreen:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => FAQScreen(
                arguments:
                    StudentRouteArguments().getArgument(RoutesConst.FAQscreen)),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      case RoutesConst.termsandcondition:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => TermsandConditionScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.termsandcondition)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.privacypolicy:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PrivacyPolicyScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.privacypolicy)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case RoutesConst.practiceAssignment:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PracticeAssignmentScreen(
              arguments: StudentRouteArguments()
                  .getArgument(RoutesConst.practiceAssignment)),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Scaffold(
            appBar: AppBar(
              title: Text(settings.name.toString()),
            ),
            body: SafeArea(
              child: Text(settings.name.toString()),
            ),
            // drawer: isMenuFixed(context) ? null : menu,
          ),
          transitionsBuilder: (_, a, __, c) => FadeTransition(
            opacity: a,
            child: c,
          ),
        );
    }
  }
}
