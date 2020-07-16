class Settings {
  Settings({
    this.currency,
    this.currencySymbol,
    this.currencyPosition,
    this.thousandSeparator,
    this.decimalSeparator,
    this.numberOfDecimals,
  });

  String currency;
  String currencySymbol;
  String currencyPosition;
  String thousandSeparator;
  String decimalSeparator;
  int numberOfDecimals;


  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    currency: json["currency"],
    currencySymbol: json["currency_symbol"],
    currencyPosition: json["currency_position"],
    thousandSeparator: json["thousand_separator"],
    decimalSeparator: json["decimal_separator"],
    numberOfDecimals: json["number_of_decimals"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "currency_symbol": currencySymbol,
    "currency_position": currencyPosition,
    "thousand_separator": thousandSeparator,
    "decimal_separator": decimalSeparator,
    "number_of_decimals": numberOfDecimals,
  };
}

class UserSettings{

  String currency;
  bool darkMode;
  String language;
  int id;



  UserSettings(this.currency, this.darkMode, this.language);

  toJson()=>{
    "currency":currency,
    "darkMode":darkMode,
    "language":language,
    "id":0
  };

 factory UserSettings.fromJson(Map<String,dynamic>data)=>UserSettings(data["currency"],data["darkMode"],data["language"]);

}