class Post {
  String title;
  String text;
  String authorUID;

  Post({
    this.title,
    this.text,
    this.authorUID
  });

  Map<String, dynamic> returnPostData(){
    return {
      "title" : this.title,
      "text" : this.text,
      "authorUID" : this.authorUID
    };
  }
}