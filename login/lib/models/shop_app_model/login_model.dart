class ShopLoginModel {
  late bool status;
  late dynamic message;
  late UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData {
  late dynamic id;
  late dynamic name;
  late dynamic email;
  late dynamic phone;
  late dynamic image;
  late dynamic points;
  late dynamic credit;
  late dynamic token;

  // Named Constructor
  UserData.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }
}
