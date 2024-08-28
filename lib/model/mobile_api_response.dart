class MobileApiResponse {
  MobileApiResponse({
    this.errorMessage,
    this.messageType,
    this.statusCode,
    this.message,
    this.success,
  });

  bool? success;
  String? errorMessage;
  int? messageType;
  int? statusCode;
  String? message;

  factory MobileApiResponse.fromJson(Map<String, dynamic> json) =>
      MobileApiResponse(
        message: json['message'],
        success: json["success"],
        errorMessage: json["errorMessage"],
        messageType: json["messageType"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorMessage": errorMessage,
        "messageType": messageType,
        "statusCode": statusCode,
        "message": message,
      };
}
