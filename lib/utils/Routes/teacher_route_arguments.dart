import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/utils/config.dart';

class TeacherRouteArguments {
  /// Get title and desc my passing route name
  Arguments getTeacherArgument(String routeName) {
    switch (routeName) {
      case RoutesConst.teacherHome:
        return Arguments(
          title: "welcome_back".tr,
          description: "notification_news_books".tr,
        );
      case RoutesConst.libraryeBooks:
        return Arguments(title: "E books".tr, description: "E books".tr);
      case RoutesConst.libraryvideo:
        return Arguments(title: "Videos".tr, description: "Videos".tr);
      case RoutesConst.pastQuestions:
        return Arguments(
          title: "Past Questions".tr,
          description: "Past Questions".tr,
        );
      case RoutesConst.selfAssessment:
        return Arguments(
          title: "Self Assessment".tr,
          description: "Self Assessment".tr,
        );
      case RoutesConst.eLearning:
        return Arguments(
          title: "Teaching Materials".tr,
          description: "Please select subject".tr,
        );
      case RoutesConst.connect:
        return Arguments(
            title: "Connect".tr,
            description:
                "communicate and connect with friends and teachers".tr);
      case RoutesConst.training:
        return Arguments(
            title: "training".tr, description: "upskilling_teams".tr);
      case RoutesConst.trainingDetails:
        return Arguments(
            title: "training_details".tr, description: "upskilling_teams".tr);
      case RoutesConst.trainingOptions:
        return Arguments(
            title: "training_options".tr, description: "upskilling_teams".tr);
      case RoutesConst.trainingSignature:
        return Arguments(
            title: "training_signature".tr, description: "upskilling_teams".tr);
      case RoutesConst.trainingSignedform:
        return Arguments(
            title: "training_signed_form".tr,
            description: "upskilling_teams".tr);
      case RoutesConst.trainingResources:
        return Arguments(
            title: "training_resources".tr, description: "upskilling_teams".tr);
      case RoutesConst.onlineExam:
        return Arguments(
            title: "training_online_exam".tr,
            description: "upskilling_teams".tr);
      case RoutesConst.bookDetail:
        return Arguments(
          title: "book_details".tr,
          description: "reviews_similarBook".tr,
        );
      case RoutesConst.editProfile:
        return Arguments(
          title: "Profile".tr,
          description: "edit_student".tr,
        );
      case RoutesConst.liveClassDetails:
        return Arguments(
          title: "live_class_details".tr,
          description: "reviews_similarBook".tr,
        );
      case RoutesConst.changePassword:
        return Arguments(
          title: "Settings".tr,
          description: "Change password".tr,
        );
      case RoutesConst.aboutUs:
        return Arguments(
          title: "about_us".tr,
          description: "about_us".tr,
        );
      case RoutesConst.setting:
        return Arguments(
          title: "Setting".tr,
          description: "Setting".tr,
        );
      case RoutesConst.deleteAccount:
        return Arguments(
            title: "Settings".tr, description: "Delete Account".tr);
      case RoutesConst.examResult:
        return Arguments(
          title: "exam_result".tr,
          description: "subject_wise_marks".tr,
        );
      case RoutesConst.notification:
        return Arguments(
          title: "notification".tr,
          description: "latest_announcement".tr,
        );
      case RoutesConst.oldQuestionSet:
        return Arguments(
          title: "past_paper".tr,
          description: "past_paper".tr,
        );
      case RoutesConst.practice:
        return Arguments(
          title: "Practice".tr,
          description: "Please select practice".tr,
        );
      case RoutesConst.practiceSubject:
        return Arguments(
          title: "Practice Subject".tr,
          description: "Please select subject".tr,
        );
      case RoutesConst.assignmentDetails:
        return Arguments(
          title: "practice".tr,
          description: "practice".tr,
        );
      case RoutesConst.calender:
        return Arguments(
          title: "calender".tr,
          description: "events_holiday".tr,
        );
      case RoutesConst.myLibrary:
        return Arguments(
          title: "my_library".tr,
          description: "events_holiday".tr,
        );
      case RoutesConst.blogs:
        return Arguments(
          title: "blogs".tr,
          description: "blog_description".tr,
        );
      case RoutesConst.createblog:
        return Arguments(
          title: "create_blog".tr,
          description: "create_blog".tr,
        );
      case RoutesConst.liveClass:
        return Arguments(
          title: "live_class".tr,
          description: "coming_soon".tr,
        );
      case RoutesConst.orderHistory:
        return Arguments(
          title: "order_history".tr,
          description: "order_Date".tr,
        );
      case RoutesConst.helpAndsupport:
        return Arguments(
            title: "Settings".tr, description: "Help and Support".tr);
      case RoutesConst.FAQscreen:
        return Arguments(title: "Help and Support".tr, description: "FAQ".tr);
      case RoutesConst.termsandcondition:
        return Arguments(title: "Help and Support".tr, description: "T&C".tr);
      case RoutesConst.privacypolicy:
        return Arguments(
            title: "Help and Support".tr, description: "Privacy Policy".tr);
      case RoutesConst.practiceAssignment:
        return Arguments(title: "Assignment".tr, description: "Assignment".tr);
      case RoutesConst.assignmentReview:
        return Arguments(
            title: "Practice".tr, description: "Assignment Review".tr);
      default:
        return Arguments(
          title: 'title'.tr,
          description: "description".tr,
        );
    }
  }
}
