class GetChatBoxModel {
  int? status;
  String? message;
  Data? data;

  GetChatBoxModel({this.status, this.message, this.data});

  GetChatBoxModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? text;
  String? parentId;
  bool? isEnd;
  String? actionType;
  String? actionUrl;
  List<Options>? options;

  Data(
      {this.id,
      this.text,
      this.parentId,
      this.isEnd,
      this.actionType,
      this.actionUrl,
      this.options});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    parentId = json['parent_id'];
    isEnd = json['is_end'];
    actionType = json['action_type'];
    actionUrl = json['action_url'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['parent_id'] = this.parentId;
    data['is_end'] = this.isEnd;
    data['action_type'] = this.actionType;
    data['action_url'] = this.actionUrl;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? label;
  String? nextStepId;

  Options({this.id, this.label, this.nextStepId});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    nextStepId = json['next_step_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['next_step_id'] = this.nextStepId;
    return data;
  }
}
