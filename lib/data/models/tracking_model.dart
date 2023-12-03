class TrackingModel {
  final String tokenId;
  String operSys;
  double latVar;
  double longVar;

  TrackingModel({
    required this.tokenId,
    required this.operSys,
    required this.latVar,
    required this.longVar,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenId'] = tokenId;
    data['OperSys'] = operSys;
    data['LatVar'] = latVar;
    data['LongVar'] = longVar;
    return data;
  }
}
