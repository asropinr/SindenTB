class GetPsp {
  int? status;
  String? message;
  Data? data;

  GetPsp({this.status, this.message, this.data});

  GetPsp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? pspTitle;
  String? psp;

  Data({this.pspTitle, this.psp});

  Data.fromJson(Map<String, dynamic> json) {
    pspTitle = json['psp_title'];
    psp = json['psp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psp_title'] = pspTitle;
    data['psp'] = psp;
    return data;
  }
}
