class Post{
  String userId;
  String content;
  String firstName;
  String lastName;
  String date;

  Post(String userId, String content, String firstName, String lastName, String date) {
    this.userId = userId;
    this.content = content;
    this.firstName = firstName;
    this.lastName = lastName;
    this.date = date;

  }
  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        content = json['content'],
        firstName = json ['firstName'],
        lastName = json ['lastName'],
        date = json ['date'];


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'content': content,
    'firstName': firstName,
    'lastName': lastName,
    'date': date,
  };
}