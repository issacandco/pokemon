class MobileNumber {
  String countryCode;
  String number;

  MobileNumber({
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }

  @override
  String toString() =>
      'MobileNumber(CountryCode: $countryCode, number: $number)';
}
