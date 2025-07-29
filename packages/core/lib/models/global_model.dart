import 'package:core/utils/string_utils/string_utils.dart';
import 'package:core/widgets/base_form/suggestion_form_field.dart';
import 'package:flutter/widgets.dart';

enum FormType { baseForm, dropdownForm }

class WhereFieldTabel {
  final String key;
  final String method;
  final String? value;

  WhereFieldTabel({
    required this.key,
    required this.method,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'method': method,
      'value': value,
    };
  }

  factory WhereFieldTabel.fromJson(Map<String, dynamic> json) {
    return WhereFieldTabel(
      key: json['key'] ?? "",
      method: json['method'] ?? "",
      value: json['value'] ?? "",
    );
  }
}

class BaseTabelPayloadNullable {
  final String perPage;
  final String currentPage;
  List<Map<String, String>> orderBy = [];
  final List<WhereFieldTabel> whereFields;

  BaseTabelPayloadNullable({
    required this.perPage,
    required this.currentPage,
    required this.whereFields,
    this.orderBy = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'perPage': perPage,
      'currentPage': currentPage,
      'whereFields': whereFields.map((field) => field.toJson()).toList(),
      'orderBy': orderBy,
    };
  }

  BaseTabelPayloadNullable copyWith({
    String? perPage,
    String? currentPage,
    List<WhereFieldTabel>? whereFields,
    List<Map<String, String>>? orderBy,
  }) {
    return BaseTabelPayloadNullable(
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      whereFields: whereFields ?? this.whereFields,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}

class YaTidakModel {
  String? yt;
  String? yaTidak;
  YaTidakModel({
    this.yt,
    this.yaTidak,
  });

  String yaTidakAsString() {
    return StringUtils.trimString(yaTidak);
  }
}

List<YaTidakModel> dataYaTidak = [
  YaTidakModel(yt: 'Y', yaTidak: 'YA'),
  YaTidakModel(yt: 'T', yaTidak: 'TIDAK'),
];

class FormMetadata<T> {
  String id;
  String? defaultValue;

  FormMetadata({
    required this.id,
    this.defaultValue = "",
  });
}

class WhereField {
  String key;
  String method;
  String? value;

  WhereField({
    required this.key,
    required this.method,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'method': method,
      'value': value,
    };
  }
}

class OrderBy {
  String? key;
  String? method;

  OrderBy({this.key, this.method});

  OrderBy.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['method'] = method;
    return data;
  }
}

class BaseTabelPayload {
  final String perPage;
  final String currentPage;
  final List<WhereField> whereFields;

  BaseTabelPayload({
    required this.perPage,
    required this.currentPage,
    required this.whereFields,
  });

  Map<String, dynamic> toJson() {
    return {
      'perPage': perPage,
      'currentPage': currentPage,
      'whereFields': whereFields.map((field) => field.toJson()).toList(),
    };
  }

  BaseTabelPayload copyWith({
    String? perPage,
    String? currentPage,
    List<WhereField>? whereFields,
  }) {
    return BaseTabelPayload(
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      whereFields: whereFields ?? this.whereFields,
    );
  }
}

class BasePayloadWithOrderBy {
  final String perPage;
  final String currentPage;
  final List<WhereField> whereFields;
  final List<OrderBy> orderBy;

  BasePayloadWithOrderBy({
    required this.perPage,
    required this.currentPage,
    required this.whereFields,
    required this.orderBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "datatable": {
        'per_page': perPage,
        'current_page': currentPage,
        'where_fields': whereFields.map((field) => field.toJson()).toList(),
        'order_by': orderBy.map((field) => field.toJson()).toList(),
      }
    };
  }

  BasePayloadWithOrderBy copyWith({
    String? perPage,
    String? currentPage,
    List<WhereField>? whereFields,
    List<OrderBy>? orderBy,
  }) {
    return BasePayloadWithOrderBy(
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      whereFields: whereFields ?? this.whereFields,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}

class BaseApiResModel {
  String? code;
  bool? success;
  String? message;

  BaseApiResModel({this.code, this.success, this.message});

  BaseApiResModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class CheckboxMetadata {
  String id;
  String label;
  bool defaultValue;

  CheckboxMetadata({
    required this.id,
    required this.label,
    required this.defaultValue,
  });
}

class SearchAspect {
  String keyValue;
  String methodValue;
  TextEditingController textController;
  Suggestion? suggestion;

  SearchAspect({
    required this.keyValue,
    required this.methodValue,
    required this.textController,
    this.suggestion,
  });

  SearchAspect copyWith({
    String? keyValue,
    String? methodValue,
    TextEditingController? textController,
    Suggestion? suggestion,
  }) {
    return SearchAspect(
      keyValue: keyValue ?? this.keyValue,
      methodValue: methodValue ?? this.methodValue,
      textController: TextEditingController(text: this.textController.text),
      suggestion: suggestion ?? this.suggestion,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyValue'] = keyValue;
    data['methodValue'] = methodValue;
    data['textValue'] = textController.text;
    data['suggestion'] = suggestion?.toJson();
    return data;
  }

  Map<String, dynamic> toJsonWhereField() {
    return {
      'key': keyValue,
      'method': methodValue,
      'value': textController.text,
    };
  }
}

class SearchAspectV2 {
  String keyWidget;
  String keyValue;
  String methodValue;
  TextEditingController textController;
  Suggestion? suggestion;

  SearchAspectV2({
    required this.keyWidget,
    required this.keyValue,
    required this.methodValue,
    required this.textController,
    this.suggestion,
  });

  SearchAspectV2 copyWith({
    String? keyValue,
    String? methodValue,
    TextEditingController? textController,
    Suggestion? suggestion,
  }) {
    return SearchAspectV2(
      keyWidget: keyWidget,
      keyValue: keyValue ?? this.keyValue,
      methodValue: methodValue ?? this.methodValue,
      textController: TextEditingController(text: this.textController.text),
      suggestion: suggestion ?? this.suggestion,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyValue'] = keyValue;
    data['methodValue'] = methodValue;
    data['textValue'] = textController.text;
    data['suggestion'] = suggestion?.toJson();
    return data;
  }

  Map<String, dynamic> toJsonWhereField() {
    return {
      'key': keyValue,
      'method': methodValue,
      'value': textController.text,
    };
  }
}

class SearchKeyModel {
  final String key;
  final List<String> method;
  final List<Suggestion> suggestion;

  SearchKeyModel({
    required this.key,
    required this.suggestion,
    required this.method,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'method': method,
      'suggestion': suggestion.map((s) => {'label': s.label, 'value': s.value}).toList(),
    };
  }
}

class SearchKeyModelV2 {
  final String key;
  final String label;
  final List<String> method;
  final List<Suggestion> suggestion;

  SearchKeyModelV2({
    required this.key,
    required this.label,
    required this.suggestion,
    required this.method,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'method': method,
      'suggestion': suggestion.map((s) => {'label': s.label, 'value': s.value}).toList(),
    };
  }

  String asString() {
    return label;
  }
}

class BaseDropdownOption {
  final String label;
  final String value;

  BaseDropdownOption({
    required this.label,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }

  String asString() {
    return label;
  }
}

class KirimWaModel {
  String? code;
  bool? success;
  String? message;
  ParamKirimWa? param;
  KirimWaModel({this.code, this.success, this.message, this.param});

  KirimWaModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];

    message = json['message'];
    param = json['param'] != null ? ParamKirimWa.fromJson(json['param']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;

    data['message'] = message;
    if (param != null) {
      data['param'] = param!.toJson();
    }
    return data;
  }
}

class ParamKirimWa {
  List<String>? noHp;
  String? messageName;
  DataFileKirimWa? dataFile;

  ParamKirimWa({this.noHp, this.messageName, this.dataFile});

  ParamKirimWa.fromJson(Map<String, dynamic> json) {
    noHp = json['no_hp'].cast<String>();
    messageName = json['message_name'];
    dataFile = json['data_file'] != null ? DataFileKirimWa.fromJson(json['data_file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_hp'] = noHp;
    data['message_name'] = messageName;
    if (dataFile != null) {
      data['data_file'] = dataFile!.toJson();
    }
    return data;
  }
}

class DataFileKirimWa {
  String? fileName;
  String? fileExtension;
  String? file;

  DataFileKirimWa({this.fileName, this.fileExtension, this.file});

  DataFileKirimWa.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileExtension = json['file_extension'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_name'] = fileName;
    data['file_extension'] = fileExtension;
    data['file'] = file;
    return data;
  }
}

class KeysBaseWithHelper {
  String? key;
  List<String>? method;
  List<HelperModel>? helper;

  KeysBaseWithHelper({this.key, this.method, this.helper});

  KeysBaseWithHelper.fromJson(Map<String, dynamic> json) {
    key = StringUtils.checkModel(json['key']);
    method = json['method'].cast<String>();
    if (json['helper'] != null) {
      helper = <HelperModel>[];
      json['helper'].forEach((v) {
        helper!.add(HelperModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['method'] = method;
    if (helper != null) {
      data['helper'] = helper!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HelperModel {
  String? helperId;
  String? helperName;

  HelperModel({this.helperId, this.helperName});

  HelperModel.fromJson(Map<String, dynamic> json) {
    helperId = StringUtils.checkModel(json['helper_id']);
    helperName = StringUtils.checkModel(json['helper_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['helper_id'] = helperId;
    data['helper_name'] = helperName;
    return data;
  }
}
