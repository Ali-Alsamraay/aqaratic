enum FieldType {
  TextField,
  CheckBox,
  DropDown,
}

class PropertyField {
  int? id;
  String? labelText;
  String? lang_key;
  FieldType? fieldType;
  dynamic value;
  List<dynamic>? values = [];

  PropertyField({
    this.id,
    this.labelText,
    this.lang_key,
    this.fieldType,
    this.value,
    List<dynamic>? values,
  }) {
    if (values == null) {
      this.values = [];
    } else
      this.values = values;
  }

  PropertyField.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.labelText = json['custom_text'];
    this.lang_key = json['lang_key'];
    this.value = json['value'];
    this.values = json['values'] == null ? [] : json['values'];
  }
}
