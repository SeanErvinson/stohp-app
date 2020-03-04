class GenderType {
  final int id;
  final String name;
  final String code;

  GenderType(this.id, this.name, this.code);

  static GenderType parseGender(String code) {
    for (var gender in getGenders()) {
      if (gender.code == code) return gender;
    }
    return null;
  }

  static List<GenderType> getGenders() {
    return <GenderType>[
      GenderType(0, "Select gender", null),
      GenderType(1, "Male", "M"),
      GenderType(2, "Female", "F"),
      GenderType(3, "Others", "O")
    ];
  }
}
