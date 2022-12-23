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


/** This is an auto generated class representing the Bag type in your schema. */
@immutable
class Bag extends Model {
  static const classType = const _BagModelType();
  final String id;
  final BagStatus? _bagStatus;
  final User? _user;
  final List<BagProduct>? _BagProducts;
  final List<Review>? _Reviews;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  BagStatus? get bagStatus {
    return _bagStatus;
  }
  
  User? get user {
    return _user;
  }
  
  List<BagProduct>? get BagProducts {
    return _BagProducts;
  }
  
  List<Review>? get Reviews {
    return _Reviews;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Bag._internal({required this.id, bagStatus, user, BagProducts, Reviews, createdAt, updatedAt}): _bagStatus = bagStatus, _user = user, _BagProducts = BagProducts, _Reviews = Reviews, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Bag({String? id, BagStatus? bagStatus, User? user, List<BagProduct>? BagProducts, List<Review>? Reviews}) {
    return Bag._internal(
      id: id == null ? UUID.getUUID() : id,
      bagStatus: bagStatus,
      user: user,
      BagProducts: BagProducts != null ? List<BagProduct>.unmodifiable(BagProducts) : BagProducts,
      Reviews: Reviews != null ? List<Review>.unmodifiable(Reviews) : Reviews);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bag &&
      id == other.id &&
      _bagStatus == other._bagStatus &&
      _user == other._user &&
      DeepCollectionEquality().equals(_BagProducts, other._BagProducts) &&
      DeepCollectionEquality().equals(_Reviews, other._Reviews);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Bag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("bagStatus=" + (_bagStatus != null ? enumToString(_bagStatus)! : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Bag copyWith({String? id, BagStatus? bagStatus, User? user, List<BagProduct>? BagProducts, List<Review>? Reviews}) {
    return Bag._internal(
      id: id ?? this.id,
      bagStatus: bagStatus ?? this.bagStatus,
      user: user ?? this.user,
      BagProducts: BagProducts ?? this.BagProducts,
      Reviews: Reviews ?? this.Reviews);
  }
  
  Bag.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bagStatus = enumFromString<BagStatus>(json['bagStatus'], BagStatus.values),
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _BagProducts = json['BagProducts'] is List
        ? (json['BagProducts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => BagProduct.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _Reviews = json['Reviews'] is List
        ? (json['Reviews'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Review.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bagStatus': enumToString(_bagStatus), 'user': _user?.toJson(), 'BagProducts': _BagProducts?.map((BagProduct? e) => e?.toJson()).toList(), 'Reviews': _Reviews?.map((Review? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'bagStatus': _bagStatus, 'user': _user, 'BagProducts': _BagProducts, 'Reviews': _Reviews, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField BAGSTATUS = QueryField(fieldName: "bagStatus");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField BAGPRODUCTS = QueryField(
    fieldName: "BagProducts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (BagProduct).toString()));
  static final QueryField REVIEWS = QueryField(
    fieldName: "Reviews",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Review).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bag";
    modelSchemaDefinition.pluralName = "Bags";
    
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
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Bag.BAGSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Bag.USER,
      isRequired: false,
      targetName: "userID",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Bag.BAGPRODUCTS,
      isRequired: false,
      ofModelName: (BagProduct).toString(),
      associatedKey: BagProduct.BAGID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Bag.REVIEWS,
      isRequired: false,
      ofModelName: (Review).toString(),
      associatedKey: Review.BAGID
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

class _BagModelType extends ModelType<Bag> {
  const _BagModelType();
  
  @override
  Bag fromJson(Map<String, dynamic> jsonData) {
    return Bag.fromJson(jsonData);
  }
}