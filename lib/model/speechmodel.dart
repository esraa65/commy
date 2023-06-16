class OutputText {
  List<String>? filteredText;

  OutputText({this.filteredText});

  OutputText.fromJson(Map<String, dynamic> json) {
    filteredText = json['Filtered Text: '].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Filtered Text: '] = this.filteredText;
    return data;
  }
}
