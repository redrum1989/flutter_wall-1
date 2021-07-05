class AlumniData{
  String email;
  String password;
  String name;
  String college;
  String yearStarted;
  String yearGraduated;
  String currentWork;
  String description = "";

  AlumniData({
    this.email,
    this.password,
    this.name,
    this.college,
    this.yearStarted,
    this.yearGraduated,
    this.currentWork,
    this.description,
  });

  Map<String, dynamic> returnAlumniData(){
    return {
      "name" : this.name,
      "college" : this.college,
      "yearStarted" : this.yearStarted,
      "yearGraduated" : this.yearGraduated,
      "currentWork" : this.currentWork,
      "description" : this.description
    }; 
  }
}