class BankCard {
  final String cardToken;
  final String cardAlias;
  final String binNumber;
  final String lastFourDigits;
  final String cardType;
  final String cardAssociation;
  final String cardFamily;
  final int cardBankCode;
  final String cardBankName;

  BankCard({
    required this.cardToken,
    required this.cardAlias,
    required this.binNumber,
    required this.lastFourDigits,
    required this.cardType,
    required this.cardAssociation,
    required this.cardFamily,
    required this.cardBankCode,
    required this.cardBankName,
  });

  // JSON'dan Card nesnesine dönüştürmek için bir factory metodu
  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      cardToken: json['cardToken'],
      cardAlias: json['cardAlias'],
      binNumber: json['binNumber'],
      lastFourDigits: json['lastFourDigits'],
      cardType: json['cardType'],
      cardAssociation: json['cardAssociation'],
      cardFamily: json['cardFamily'],
      cardBankCode: json['cardBankCode'],
      cardBankName: json['cardBankName'],
    );
  }
}
