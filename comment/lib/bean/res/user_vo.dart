class UserVo {
  String? nickName;

  UserVo({
    this.nickName
  });

  factory UserVo.fromJson(json){
    return UserVo(
      nickName: json['nickName']
    );
  }
}