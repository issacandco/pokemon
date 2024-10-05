class BaseInfo {
  String? name;
  String? url;

  BaseInfo({this.name, this.url});

  factory BaseInfo.fromJson(Map<String, dynamic> json) {
    return BaseInfo(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
