import 'package:katon/utils/prefs/app_preference.dart';

class ApiRoutes {
  //static String baseURL = 'https://frontapi.katon.app/api/v1/student/';
  //static String baseURL = 'https://frontapi.katondev.in/api/v1/student/';
  static String baseURL = 'https://user.api.tlmsghdev.in/api/v1/student/';
  static String teacherBaseURL = 'https://teacherapi.katon.app/api/v1/teacher/';
  static String parentBaseURL = 'https://teacherapi.katon.app/api/v1/parent/';
  //static String imageURL = 'https://dashapi.katondev.in/uploads/';
  static String imageURL =
      'https://katon-dev-uploads.s3.eu-central-1.amazonaws.com/';
  // static String imageURL = 'https://dashapi.katon.app/uploads/';
  static String dashBoardURL =
      'https://dashboard.api.tlmsghdev.in/api/v1/admin/';
  // static String dashBoardURL = 'https://dashapi.katon.app/api/v1/admin/';

  static String login = '${baseURL}auth/login';
  static String signupTeacher = '${baseURL}auth/tSignUp';
  static String signupStudent = '${baseURL}auth/stSignUp';
  static String teacherLogin = '${baseURL}auth/tlogin';
  static String parentsLogin = '${baseURL}auth/ptlogin';
  static String verifyTeacherOtp = '${baseURL}auth/verifyOtp';
  static String verifyStudentOtp = '${baseURL}auth/verifyStudentOtp';
  static String resendTeacherOtp = '${baseURL}auth/generateTeacherOtp';
  static String resendStudentOtp = '${baseURL}auth/generateStudentOtp';
  static String forgotPassword = '${baseURL}auth/forgotPassword';
  static String verifyforgotPassword = '${baseURL}auth/verifyForgotPasswordOTP';
  static String resetPassword = '${baseURL}auth/resetPassword';
  static String updateProfile = '${baseURL}manage-student';
  static String changePassword = '${baseURL}auth/changePassword';
  static String updateProfilePic = '${dashBoardURL}student/';
  static String updateProfilePicTeacher = '${dashBoardURL}teacher/';
  static String addBookLibrary = '${baseURL}book';
  static String deleteLibrary = '${baseURL}book';
  static String libraryBook = '${baseURL}book/library';
  static String bookWithSearch = '${baseURL}book';
  static String videobookWithSearch = '${baseURL}book/getAllVideosByLevel';
  static String liveClass = '${baseURL}liveSession/getAll';
  static String scheduledliveClass =
      '${baseURL}liveSession/getAllScheduledSession';
  static String historyliveClass =
      '${baseURL}liveSession/getAllRecordedSession';
  static String assignment = '${baseURL}assignment/getAllSubjects?';
   static String Subassignment = '${baseURL}assignment/getAll?';
  static String selfAssessmentSubject =
      '${baseURL}selfAssessment/getAllSubjects';
      static String pastAssessmentSubject =
      '${baseURL}pastPaper//getAllSubjects';
  static String assignmentResultbyId =
      '${baseURL}assignmentResult/getAllAssignmentResultByAssignment/';
  static String pastQuestions = '${baseURL}pastPaper/getAll';
  static String getSelfAssessment =
      '${baseURL}selfAssessment/getAllQueBySelfAssessment?';
  static String createSelfAssessment = '${baseURL}selfAssessment';
  static String getSelfAssessmentList = '${baseURL}selfAssessment/getAll';
  static String saveSelfAssessMent = '${baseURL}selfAssessment/';
  static String assignmentResultNew =
      '${baseURL}assignmentResult/getAssignmentResultByAssign';
  static String teacherProfile = '${baseURL}manage-teacher/details';
  static String updateTeacherProfile = '${baseURL}manage-teacher';
  static String getAllMessages = '${baseURL}sendMessage/getAllMessageByStudent';
  static String getAllPastPaper = '${baseURL}pastPaper/getAll';
  static String getPastPaperDetail =
      '${baseURL}assignmentQset/getAssignmentQsetByPastPaper';
  static String getQsetByAssign =
      '${baseURL}assignmentQset/getAssignmentQsetByAssign?asn_id=';
  static String assignmentResult = '${baseURL}assignmentResult';
  static String parentProfile =
      'https://frontapi.katondev.in/api/v1/web/parent';
  static String teacherLiveClass =
      'https://frontapi.katon.app/api/v1/web/liveSession/get';
  static String getAllTrainings = '${baseURL}training-program';
  static String getTrainingsdetails =
      '${baseURL}training-program/getTrainingProgramDetails';
  static String getBloglist = '${baseURL}blog/getAll';
  static String getBloglistwithpagination = '${baseURL}blog/pagination';
  static String likeBlog = '${baseURL}blog/likeBlog';
  static String deleteBlog = '${baseURL}blog/';
  static String getAllCommentsbyId =
      '${baseURL}blogComment/getCommentByBlogId/get';
  static String addComment = '${baseURL}blogComment';
  static String addBlog = '${dashBoardURL}blog';
  static String getGrouplist = '${baseURL}group/getGroupsByStudent';
  static String getClassmateData = '${baseURL}group/getStudentByClassAndDiv';
  static String getRelatedGroup = '${baseURL}group/getGroupBySchoolAndClass';
  static String getGroupdetailsbyId = '${baseURL}group/getSingleGroupDetails';
  static String addGroup = '${baseURL}group/';
  static String deleteGroup = '${baseURL}group/';
  static String joinGroup = '${baseURL}group/joinGroup';
  static String exitGroup = '${baseURL}group/exitGroup';
  static String generateSignedForm =
      '${dashBoardURL}training-participants/generateSignedForm';
  static String updateSignedForm = '${dashBoardURL}training-participants/';
  static String getExamQuestions =
      '${baseURL}trainingQset/getAllTrainingQsetByTE';
  static String getExamResult = '${baseURL}training-participants';
  static String getTrainingParticipants = '${baseURL}training-participants';
  static String mcqTest = 'https://katon.app/mcqTest/3/';
  static String getAllregion = '${baseURL}area/circuit';
  static String getStaticdata = '${baseURL}auth/static-data';
  static String getAllschooldata = '${baseURL}manage-student/filterSchool';
  static String deleteAccount = '${baseURL}auth/deleteAccount';
  static String subjectList = '${baseURL}book/all-book-subjects?subject=JHS';

  // String liveClassUrl(String? lsRoomURL) =>
  //     "https://katondev.in/live-class-room/${lsRoomURL}?uType=${AppPreference().uType}&uId=${AppPreference().uId}&uName=${AppPreference().uName}";
  String liveClassUrl(String? lsRoomURL) =>
      "https://katondev.in/live-class-room/${lsRoomURL}?uType=${AppPreference().uType}&uName=${AppPreference().uName}";
  String epub({String? bookName, String? bookItem}) =>
      "https://katon.app/epub/$bookName?ePub=${bookItem}";
}
