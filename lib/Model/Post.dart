class Post {
  String title;
  String text;
  String authorUID;
  String college;

  Post({
    this.title,
    this.text,
    this.authorUID,
    this.college
  });

  Map<String, dynamic> returnPostData(){
    return {
      "title" : this.title,
      "text" : this.text,
      "authorUID" : this.authorUID,
      "college" : this.college
    };
  }
}