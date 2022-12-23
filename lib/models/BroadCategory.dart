/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the BroadCategory type in your schema. */
@immutable
class BroadCategory extends Model {
  static const classType = const _BroadCategoryModelType();
  final String id;
  final String? _title;
  final Gender? _gender;
  final String? _image;
  final List<FinerCategory>? _FinerCategories;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get title {
    return _title;
  }
  
  Gender? get gender {
    return _gender;
  }
  
  String? get image {
    return _image;
  }
  
  List<FinerCategory>? get FinerCategories {
    return _FinerCategories;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const BroadCategory._internal({required this.id, title, gender, image, FinerCategories, createdAt, updatedAt}): _title = title, _gender = gender, _image = image, _FinerCategories = FinerCategories, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BroadCategory({String? id, String? title, Gender? gender, String? image, List<FinerCategory>? FinerCategories}) {
    return BroadCategory._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      gender: gender,
      image: image,
      FinerCategories: FinerCategories != null ? List<FinerCategory>.unmodifiable(FinerCategories) : FinerCategories);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BroadCategory &&
      id == other.id &&
      _title == other._title &&
      _gender == other._gender &&
      _image == other._image &&
      DeepCollectionEquality().equals(_FinerCategories, other._FinerCategories);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BroadCategory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("gender=" + (_gender != null ? enumToString(_gender)! : "null") + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BroadCategory copyWith({String? id, String? title, Gender? gender, String? image, List<FinerCategory>? FinerCategories}) {
    return BroadCategory._internal(
      id: id ?? this.id,
      title: title ?? this.title,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      FinerCategories: FinerCategories ?? this.FinerCategories);
  }
  
  BroadCategory.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _gender = enumFromString<Gender>(json['gender'], Gender.values),
      _image = json['image'],
      _FinerCategories = json['FinerCategories'] is List
        ? (json['FinerCategories'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => FinerCategory.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'gender': enumToString(_gender), 'image': _image, 'FinerCategories': _FinerCategories?.map((FinerCategory? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'title': _title, 'gender': _gender, 'image': _image, 'FinerCategories': _FinerCategories, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField FINERCATEGORIES = QueryField(
    fieldName: "FinerCategories",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FinerCategory).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BroadCategory";
    modelSchemaDefinition.pluralName = "BroadCategories";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BroadCategory.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BroadCategory.GENDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BroadCategory.IMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: BroadCategory.FINERCATEGORIES,
      isRequired: false,
      ofModelName: (FinerCategory).toString(),
      associatedKey: FinerCategory.BROADCATEGORYID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BroadCategoryModelType extends ModelType<BroadCategory> {
  const _BroadCategoryModelType();
  
  @override
  BroadCategory fromJson(Map<String, dynamic> jsonData) {
    return BroadCategory.fromJson(jsonData);
  }
}