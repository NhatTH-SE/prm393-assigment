class Student {
  String name;
  double gpa;

  Student(this.name, this.gpa);

  String display() {
    return "$name - GPA: $gpa";
  }
}
