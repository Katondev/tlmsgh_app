class ApiRequest {
  final String url;
  final Map<String, String> headers;
  final Map<String, dynamic> body;
  final RequestType requestType;

  ApiRequest(
      {required this.url,
      required this.headers,
      required this.body,
      this.requestType = RequestType.get});
}

enum RequestType { get, post, patch, delete }
