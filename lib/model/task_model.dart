class Tasks {
  String? description;
  int? value;
  bool? checked;

  Tasks({this.description, this.value, this.checked});

  Tasks.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    value = json['value'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['value'] = value;
    data['checked'] = checked;
    return data;
  }
}
