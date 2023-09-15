import 'dart:convert';
/// status : true
/// message : "Assignment Result added Successfully"
/// data : {"assignmentResult":{"ar_createdAt":"2023-02-21T04:50:30.949Z","ar_id":27,"st_id":21,"asn_id":3,"ar_answerKeys":"[{\"question\":\"title\",\"answer\":\"option1\",\"option\":[\"option1\",\"option2\",\"option3\",\"option4\",\"option5\"],\"selectedOption\":\"option1\"}]","ar_score":20,"ar_unanswered":0,"ar_submitTime":"10 min","ar_dateTime":"2023-01-06T15:58:10.000Z","ar_totalQuestion":1}}

AssignmentResultDetails assignmentResultDetailsFromJson(String str) => AssignmentResultDetails.fromJson(json.decode(str));
String assignmentResultDetailsToJson(AssignmentResult data) => json.encode(data.toJson());
class AssignmentResultDetails {
  AssignmentResultDetails({
    bool? status,
    String? message,
    Data? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  AssignmentResultDetails.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  AssignmentResultDetails copyWith({  bool? status,
    String? message,
    Data? data,
  }) => AssignmentResultDetails(  status: status ?? _status,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// assignmentResult : {"ar_createdAt":"2023-02-21T04:50:30.949Z","ar_id":27,"st_id":21,"asn_id":3,"ar_answerKeys":"[{\"question\":\"title\",\"answer\":\"option1\",\"option\":[\"option1\",\"option2\",\"option3\",\"option4\",\"option5\"],\"selectedOption\":\"option1\"}]","ar_score":20,"ar_unanswered":0,"ar_submitTime":"10 min","ar_dateTime":"2023-01-06T15:58:10.000Z","ar_totalQuestion":1}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    AssignmentResult? assignmentResult,}){
    _assignmentResult = assignmentResult;
  }

  Data.fromJson(dynamic json) {
    _assignmentResult = json['assignmentResult'] != null ? AssignmentResult.fromJson(json['assignmentResult']) : null;
  }
  AssignmentResult? _assignmentResult;
  Data copyWith({  AssignmentResult? assignmentResult,
  }) => Data(  assignmentResult: assignmentResult ?? _assignmentResult,
  );
  AssignmentResult? get assignmentResult => _assignmentResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_assignmentResult != null) {
      map['assignmentResult'] = _assignmentResult?.toJson();
    }
    return map;
  }

}

/// ar_createdAt : "2023-02-21T04:50:30.949Z"
/// ar_id : 27
/// st_id : 21
/// asn_id : 3
/// ar_answerKeys : "[{\"question\":\"title\",\"answer\":\"option1\",\"option\":[\"option1\",\"option2\",\"option3\",\"option4\",\"option5\"],\"selectedOption\":\"option1\"}]"
/// ar_score : 20
/// ar_unanswered : 0
/// ar_submitTime : "10 min"
/// ar_dateTime : "2023-01-06T15:58:10.000Z"
/// ar_totalQuestion : 1

AssignmentResult assignmentResultFromJson(String str) => AssignmentResult.fromJson(json.decode(str));
String assignmentResultToJson(AssignmentResult data) => json.encode(data.toJson());
class AssignmentResult {
  AssignmentResult({
    String? arCreatedAt,
    int? arId,
    int? stId,
    int? asnId,
    String? arAnswerKeys,
    int? arScore,
    int? arUnanswered,
    String? arSubmitTime,
    String? arDateTime,
    int? arTotalQuestion,}){
    _arCreatedAt = arCreatedAt;
    _arId = arId;
    _stId = stId;
    _asnId = asnId;
    _arAnswerKeys = arAnswerKeys;
    _arScore = arScore;
    _arUnanswered = arUnanswered;
    _arSubmitTime = arSubmitTime;
    _arDateTime = arDateTime;
    _arTotalQuestion = arTotalQuestion;
  }

  AssignmentResult.fromJson(dynamic json) {
    _arCreatedAt = json['ar_createdAt'];
    _arId = json['ar_id'];
    _stId = json['st_id'];
    _asnId = json['asn_id'];
    _arAnswerKeys = json['ar_answerKeys'];
    _arScore = json['ar_score'];
    _arUnanswered = json['ar_unanswered'];
    _arSubmitTime = json['ar_submitTime'];
    _arDateTime = json['ar_dateTime'];
    _arTotalQuestion = json['ar_totalQuestion'];
  }
  String? _arCreatedAt;
  int? _arId;
  int? _stId;
  int? _asnId;
  String? _arAnswerKeys;
  int? _arScore;
  int? _arUnanswered;
  String? _arSubmitTime;
  String? _arDateTime;
  int? _arTotalQuestion;
  AssignmentResult copyWith({  String? arCreatedAt,
    int? arId,
    int? stId,
    int? asnId,
    String? arAnswerKeys,
    int? arScore,
    int? arUnanswered,
    String? arSubmitTime,
    String? arDateTime,
    int? arTotalQuestion,
  }) => AssignmentResult(  arCreatedAt: arCreatedAt ?? _arCreatedAt,
    arId: arId ?? _arId,
    stId: stId ?? _stId,
    asnId: asnId ?? _asnId,
    arAnswerKeys: arAnswerKeys ?? _arAnswerKeys,
    arScore: arScore ?? _arScore,
    arUnanswered: arUnanswered ?? _arUnanswered,
    arSubmitTime: arSubmitTime ?? _arSubmitTime,
    arDateTime: arDateTime ?? _arDateTime,
    arTotalQuestion: arTotalQuestion ?? _arTotalQuestion,
  );
  String? get arCreatedAt => _arCreatedAt;
  int? get arId => _arId;
  int? get stId => _stId;
  int? get asnId => _asnId;
  String? get arAnswerKeys => _arAnswerKeys;
  int? get arScore => _arScore;
  int? get arUnanswered => _arUnanswered;
  String? get arSubmitTime => _arSubmitTime;
  String? get arDateTime => _arDateTime;
  int? get arTotalQuestion => _arTotalQuestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ar_createdAt'] = _arCreatedAt;
    map['ar_id'] = _arId;
    map['st_id'] = _stId;
    map['asn_id'] = _asnId;
    map['ar_answerKeys'] = _arAnswerKeys;
    map['ar_score'] = _arScore;
    map['ar_unanswered'] = _arUnanswered;
    map['ar_submitTime'] = _arSubmitTime;
    map['ar_dateTime'] = _arDateTime;
    map['ar_totalQuestion'] = _arTotalQuestion;
    return map;
  }

}