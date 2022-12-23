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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _email;
  final String? _avatar;
  final String? _savedStorageID;
  final SavedStorage? _savedStorage;
  final List<Bag>? _Bags;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get avatar {
    return _avatar;
  }
  
  String? get savedStorageID {
    return _savedStorageID;
  }
  
  SavedStorage? get savedStorage {
    return _savedStorage;
  }
  
  List<Bag>? get Bags {
    return _Bags;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required username, required email, avatar, savedStorageID, savedStorage, Bags, createdAt, updatedAt}): _username = username, _email = email, _avatar = avatar, _savedStorageID = savedStorageID, _savedStorage = savedStorage, _Bags = Bags, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String username, required String email, String? avatar, String? savedStorageID, SavedStorage? savedStorage, List<Bag>? Bags}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      email: email,
      avatar: avatar,
      savedStorageID: savedStorageID,
      savedStorage: savedStorage,
      Bags: Bags != null ? List<Bag>.unmodifiable(Bags) : Bags);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _email == other._email &&
      _avatar == other._avatar &&
      _savedStorageID == other._savedStorageID &&
      _savedStorage == other._savedStorage &&
      DeepCollectionEquality().equals(_Bags, other._Bags);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("avatar=" + "$_avatar" + ", ");
    buffer.write("savedStorageID=" + "$_savedStorageID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? email, String? avatar, String? savedStorageID, SavedStorage? savedStorage, List<Bag>? Bags}) {
    return User._internal(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      savedStorageID: savedStorageID ?? this.savedStorageID,
      savedStorage: savedStorage ?? this.savedStorage,
      Bags: Bags ?? this.Bags);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _email = json['email'],
      _avatar = json['avatar'],
      _savedStorageID = json['savedStorageID'],
      _savedStorage = json['savedStorage']?['serializedData'] != null
        ? SavedStorage.fromJson(new Map<String, dynamic>.from(json['savedStorage']['serializedData']))
        : null,
      _Bags = json['Bags'] is List
        ? (json['Bags'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Bag.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'email': _email, 'avatar': _avatar, 'savedStorageID': _savedStorageID, 'savedStorage': _savedStorage?.toJson(), 'Bags': _Bags?.map((Bag? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'username': _username, 'email': _email, 'avatar': _avatar, 'savedStorageID': _savedStorageID, 'savedStorage': _savedStorage, 'Bags': _Bags, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField AVATAR = QueryField(fieldName: "avatar");
  static final QueryField SAVEDSTORAGEID = QueryField(fieldName: "savedStorageID");
  static final QueryField SAVEDSTORAGE = QueryField(
    fieldName: "savedStorage",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (SavedStorage).toString()));
  static final QueryField BAGS = QueryField(
    fieldName: "Bags",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Bag).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.AVATAR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.SAVEDSTORAGEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.SAVEDSTORAGE,
      isRequired: false,
      ofModelName: (SavedStorage).toString(),
      associatedKey: SavedStorage.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.BAGS,
      isRequired: false,
      ofModelName: (Bag).toString(),
      associatedKey: Bag.USER
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

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}