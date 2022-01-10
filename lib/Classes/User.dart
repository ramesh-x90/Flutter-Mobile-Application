class User {
  String _name;
  String _role;
  String _email;
  String _profileimage;
  // String key;
  bool _isAdmin = false;
  bool _isLecturer = false;

  User(this._name, this._email, this._profileimage, this._role) {
    if (this._role == 'admin') {
      this._isAdmin = true;
    } else if (this._role == 'lecturer') this._isLecturer = true;
  }

  String getname() => this._name;

  void setname(String name) {
    this._name = name;
  }

  String getrole() => this._role;

  void setrole(String role) {
    this._role = role;
  }

  String getEmail() => this._email;

  String getProfileImageURL() => this._profileimage;

  bool isLecturer() => this._isLecturer;

  bool isAdmin() => this._isAdmin;

  Map<String, dynamic> toJson() {
    return ({
      "_name": this._name,
      "_role": this._role,
      "_email": this._email,
      "_profileimage": this._profileimage,
    });
  }
}
