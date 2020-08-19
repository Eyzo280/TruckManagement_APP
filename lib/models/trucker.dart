class Trucker {
  String uid;
  String nickName;
  String createDate;
  String type;

  Trucker({
    this.uid,
    this.nickName,
    this.createDate,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickName': nickName,
      'createDate': createDate,
      'type': type,
    };
  }
}
