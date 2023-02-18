class MyUser{
  static const String COLLECTION_NAME = "Users";
  String id;
  String fName;
  String email;

  MyUser({required this.id,required this.fName,required this.email});

  MyUser.fromJson(Map<String,dynamic> json):this(
    id: json["id"],
    fName: json["fName"],
    email: json["email"],
  );

  Map<String,dynamic> toJson(){
    return{
      "id" : id,
      "fName" : fName,
      "email" : email,
    };
  }
}