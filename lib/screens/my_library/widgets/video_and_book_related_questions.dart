import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/elearning_model/ebook_and_videos_model.dart';
import '../../../network/api_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../utils/prefs/preferences_key.dart';
import '../../../widgets/loader.dart';
import '../../library_page/controller/cnt_prv.dart';



// Assuming QutionsAnswerModel, Datum classes are in the same file.

class QuizScreen extends StatefulWidget {
  final subject;
  final type;
    const QuizScreen({Key? key, this.subject, this.type,})
      : super(key: key);
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Datum> questions = []; // List to store questions from API
  List<String> selectedAnswers = [];
  List<String>? correctAnswerList;
  List<dynamic> resultColors = [];
   bool viewResult = false;
    bool  isCorrect = false;

  int score = 0;

  bool showResult = false;

  @override
  void initState() {
    super.initState();
    // Fetch questions from API
    fetchDataFromApi();
  }
   void viewCrrectanswer(){ 

   }
  Future<void> fetchDataFromApi() async {
    final String lavel =
        AppPreference().getString(PreferencesKey.student_class);
        print("jdjfjfjfl$lavel");
    final response = await http.get(Uri.parse(
        '${ApiRoutes.libraryQuestions}?studentClass=SHS 1&subject=Social Studies&type=book&limit=5&topic'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> questionList = data['data'];
      questions = questionList.map((json) => Datum.fromJson(json)).toList();

        resultColors = [
        {
          'option1':Colors.white,
          'option2':Colors.white,
          'option3':Colors.white,
          'option4':Colors.white,
          'option5':Colors.white,
        },
        {
          'option1':AppColors.white,
          'option2':AppColors.white,
          'option3':AppColors.white,
          'option4':AppColors.white,
          'option5':AppColors.white,
        },
        {
          'option1':AppColors.white,
          'option2':AppColors.white,
          'option3':AppColors.white,
          'option4':AppColors.white,
          'option5':AppColors.white,
        },
        {
          'option1':AppColors.white,
          'option2':AppColors.white,
          'option3':AppColors.white,
          'option4':AppColors.white,
          'option5':AppColors.white,
        },
        {
          'option1':AppColors.white,
          'option2':AppColors.white,
          'option3':AppColors.white,
          'option4':AppColors.white,
          'option5':AppColors.white,
        }
        ];

      setState(() {
        questions = questionList.map((json) => Datum.fromJson(json)).toList();
        // Initialize selectedAnswers with empty strings
        selectedAnswers = List.filled(questions.length, '');
        print('--------response body-----${selectedAnswers}');
      });

    } else {
      throw Exception('Failed to load questions');
    }
  }

  void handleRadioValueChanged(int questionIndex, String selectedOption) {
    setState(() {
      // Update the selectedAnswers list when a radio button is selected
      selectedAnswers[questionIndex] = selectedOption;
    });
  }

  void submitAnswers() {

     if (selectedAnswers.contains('')) {
      Fluttertoast.showToast(
        msg: "Please attempt all questions",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:AppColors.black,
        textColor: AppColors.white,
        fontSize: 16.0
    );
     }else{ 
        int correctAnswersCount = 0;
    List<Widget> answerWidgets = [];

    for (int i = 0; i < questions.length; i++) {
       isCorrect = false;

      // Extract the correct answers and clean them
      String correctAnswers = questions[i]
          .aqCorrentAns
          .join(', '); // Join correct answers into a comma-separated string
      correctAnswers = correctAnswers
          .replaceAll('[', '')
          .replaceAll(']', '') 

          .replaceAll(RegExp(r'\s+'), ' ');

      String userAnswer = selectedAnswers[i];
      userAnswer = userAnswer.replaceAll('aq', '').replaceAll('O', 'o');

      correctAnswerList =
          correctAnswers.split(',').map((e) => e.trim()).toList();
// int correctOptionNumber = -1;
      if (correctAnswerList!.contains(userAnswer)) {
          isCorrect = true;
          resultColors[i][userAnswer] = AppColors.green;
      } else {
        resultColors[i][correctAnswerList?[0]] = AppColors.green;
        resultColors[i][userAnswer] =AppColors.red1;
      }
      // print(resultColors.toString());

      final question = questions[i];

      // Determine whether the answer is correct or not
      final answerStatus = isCorrect? "Correct" : "Incorrect";
      print("");
      

      
     

      if (isCorrect!) {
        correctAnswersCount++;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView
          (
            child: Column(
              children: [
              
                Center(
                    child: Text(
                  'Your Score:',
                  style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                )),
                // Column(children: answerWidgets,),
                Text(
                  "$correctAnswersCount",
                  style: TextStyle(
                      color:correctAnswersCount == 5?AppColors.green: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              
                Text(
                correctAnswersCount == 5?"You have pass":  "You Failed",
                  style: TextStyle(
                      color:correctAnswersCount == 5?AppColors.green: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),

             h10,
                InkWell(
                  onTap: (){
                    setState(() {
                      resultColors = resultColors;
                         viewResult =true;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100, 
                    decoration: BoxDecoration(
                      color:Colors.black,
                       borderRadius: BorderRadius.circular(5)
                       ),
                       child: Text("View Result",style:TextStyle(
                        color:AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),),
                       ),
                )
                
              ],
            ),
          ),
        );
      },
    );
     } 


  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color:  AppColors.white,
      child: SafeArea(
        child: Scaffold(
         backgroundColor: AppColors.boxgreyColor,
          appBar: AppBar(
            titleSpacing: 0.20,
            elevation: 0,
            title: Text("Practice Questions",  ),
            leading: InkWell(
              onTap: (){  Navigator.pop(context);},
              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18,
                              ),
            ),),
          body:Consumer<ELearningProvider>(builder: (context, ePrv, child) {
          
            return questions.isEmpty
              ? Center(child:Loader(message: "loading_wait".tr))
              : SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      
                      for (int i = 0; i < questions.length; i++)
                        ListView(
                          scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                          
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      questions[i].aqTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      for (int j = 1; j <= 4; j++)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: resultColors[i]['option$j'],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: RadioListTile(
                                              selectedTileColor: resultColors[i]['option$j'],
                                              value: 'aqOption$j',
                                              groupValue: selectedAnswers[i],
                                              onChanged: (String? value) {
                                                handleRadioValueChanged(
                                                    i, value!);
                                                    
                                                setState(() {});
                                                print(isCorrect);
                                              },
                                              title: Text(
                                                questions[i].getOption(j)!,
                                                style: TextStyle(
                                                  color:  Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      viewResult? Text(""):  ElevatedButton(
                        onPressed: () {
                          submitAnswers();
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
              );
          }
        ),
      ),
    ));
  }
}

