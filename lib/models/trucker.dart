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

  factory Trucker.fromMap(Map<String, dynamic> data) {
    return Trucker(
      uid: data['uid'] ?? null,
      nickName: data['nickName'] ?? null,
      createDate: data['createDate'] ?? null,
      type: data['type'] ?? null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid ?? null,
      'nickName': nickName ?? null,
      'createDate': createDate ?? null,
      'type': type ?? null,
    };
  }
}
