class InputValidation{

  static String? phone(String? value){
    if(value!.isEmpty)
      return "Must enter phone number";
    else if(value.length <8)
      return "Invalid phone number";
    else return null;
  }

  static String? password(String? value){
    if(value!.isEmpty)
      return "Must enter password";
    else if(value.length < 8)
      return "Password must at least 8 charcters";
    else return null;
  }

  static String? fname(String? value){
    if(value!.isEmpty)
      return "Must enter your name";
    else if(!value.contains(" "))
      return "Must enter your full name";
    else return null;
  }

  static String? email(String? value){
    if(value!.isEmpty)
      return "Must enter your email";
    else if(!value.contains("@"))
      return "Must enter valid email";
    else if(!value.contains("."))
      return "Must enter valid email";
    else return null;
  }

}