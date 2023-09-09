class SocialUserModel {
  late String uId;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String cover;
  late String bio;

  SocialUserModel(this.uId, this.name, this.email, this.phone, this.image,
      this.cover, this.bio);

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    uId = json?['uId'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    cover = json?['cover'];
    bio = json?['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
