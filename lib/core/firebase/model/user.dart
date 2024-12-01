class User{
  int? userId;
  String? userName;
  String? userMob;
  String? userEmail;

  User({this.userId,this.userName,this.userMob,this.userEmail});

  Map<String,dynamic> toMap(){
    return {
      "userId":userId,
      "userName":userName,
      "userMob":userMob,
      "userEmail":userEmail
    };
  }

  User.fromMap(Map<String,dynamic> map){
    userId=map['userId'];
    userName=map['userName'];
    userMob=map['userMob'];
    userEmail=map['userEmail'];
  }
}