class GetArtikel {
  int? status;
  String? message;
  List<DataArtikel>? data;

  GetArtikel({this.status, this.message, this.data});

  GetArtikel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataArtikel>[];
      json['data'].forEach((v) {
        data!.add(DataArtikel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataArtikel {
  int? blogId;
  String? blogTitle;
  String? blog;
  String? postBy;
  String? postDate;

  String? bannerImage;

  DataArtikel(
      {this.blogId,
      this.blogTitle,
      this.blog,
      this.postBy,
      this.postDate,
      this.bannerImage});

  DataArtikel.fromJson(Map<String, dynamic> json) {
    blogId = json['blog_id'];
    blogTitle = json['blog_title'];
    blog = json['blog'];
    postBy = json['post_by'];
    postDate = json['post_date'];

    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blog_id'] = blogId;
    data['blog_title'] = blogTitle;
    data['blog'] = blog;
    data['post_by'] = postBy;
    data['post_date'] = postDate;

    data['banner_image'] = bannerImage;
    return data;
  }
}
