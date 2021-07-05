class StudentData{
  String email;
  String password;
  String college;
  String currentYear;
  String name;
  String description = "";

  StudentData({
    this.email,
    this.password,
    this.college,
    this.currentYear,
    this.name,
    this.description,
  });

  Map<String, dynamic> returnStudentData(){
    return {
      "college" : this.college,
      "currentYear" : this.currentYear,
      "name" : this.name,
      "description" : this.description,
    };
  }
}