class PostModel {
  late String uId;
  late String name;
  late String image;
  late String dateTime;
  late String text;
  late String postImage;

  PostModel(this.uId, this.name, this.image, this.dateTime, this.text,
      this.postImage);

  PostModel.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    name = json?['name'];
    dateTime = json?['dateTime'];
    text = json?['text'];
    image = json?['image'];
    postImage = json?['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
