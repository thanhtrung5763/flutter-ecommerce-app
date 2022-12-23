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


/** This is an auto generated class representing the SavedStorage type in your schema. */
@immutable
class SavedStorage extends Model {
  static const classType = const _SavedStorageModelType();
  final String id;
  final List<SavedStorageProduct>? _SavedStorageProducts;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  List<SavedStorageProduct>? get SavedStorageProducts {
    return _SavedStorageProducts;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SavedStorage._internal({required this.id, SavedStorageProducts, createdAt, updatedAt}): _SavedStorageProducts = SavedStorageProducts, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SavedStorage({String? id, List<SavedStorageProduct>? SavedStorageProducts}) {
    return SavedStorage._internal(
      id: id == null ? UUID.getUUID() : id,
      SavedStorageProducts: SavedStorageProducts != null ? List<SavedStorageProduct>.unmodifiable(SavedStorageProducts) : SavedStorageProducts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SavedStorage &&
      id == other.id &&
      DeepCollectionEquality().equals(_SavedStorageProducts, other._SavedStorageProducts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SavedStorage {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SavedStorage copyWith({String? id, List<SavedStorageProduct>? SavedStorageProducts}) {
    return SavedStorage._internal(
      id: id ?? this.id,
      SavedStorageProducts: SavedStorageProducts ?? this.SavedStorageProducts);
  }
  
  SavedStorage.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _SavedStorageProducts = json['SavedStorageProducts'] is List
        ? (json['SavedStorageProducts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => SavedStorageProduct.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'SavedStorageProducts': _SavedStorageProducts?.map((SavedStorageProduct? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'SavedStorageProducts': _SavedStorageProducts, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SAVEDSTORAGEPRODUCTS = QueryField(
    fieldName: "SavedStorageProducts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (SavedStorageProduct).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SavedStorage";
    modelSchemaDefinition.pluralName = "SavedStorages";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: SavedStorage.SAVEDSTORAGEPRODUCTS,
      isRequired: false,
      ofModelName: (SavedStorageProduct).toString(),
      associatedKey: SavedStorageProduct.SAVEDSTORAGEID
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

class _SavedStorageModelType extends ModelType<SavedStorage> {
  const _SavedStorageModelType();
  
  @override
  SavedStorage fromJson(Map<String, dynamic> jsonData) {
    return SavedStorage.fromJson(jsonData);
  }
}