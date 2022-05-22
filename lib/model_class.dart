class People{
  final String gender;
  final String name;
  final String street;
  final String city;
  final String state;
  final String country;
  final String email;
  final String dob;
  final String phone;


  People({
    required this.gender,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.dob,
    required this.phone,

  });

  factory People.fromJson(Map<String, dynamic> json){
    return People(
      gender: json["results"][0]["gender"],
      name: json["results"][0]["name"]["first"],
      street: json["results"][0]["location"]["street"]["name"],
      city: json["results"][0]["location"]["city"],
      state: json["results"][0]["location"]["state"],
      country: json["results"][0]["location"]["country"],
      email: json["results"][0]["email"],
      dob: json["results"][0]["dob"]["date"],
      phone: json["results"][0]["phone"],

    );
  }

}