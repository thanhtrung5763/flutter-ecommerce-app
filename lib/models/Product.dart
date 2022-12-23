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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Product type in your schema. */
@immutable
class Product extends Model {
  static const classType = const _ProductModelType();
  final String id;
  final String? _title;
  final String? _images;
  final String? _description;
  final String? _discountPrice;
  final String? _originalPrice;
  final String? _discountOffer;
  final String? _sizeOption;
  final Brand? _brand;
  final FinerCategory? _finercategory;
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
  
  String? get images {
    return _images;
  }
  
  String? get description {
    return _description;
  }
  
  String? get discountPrice {
    return _discountPrice;
  }
  
  String? get originalPrice {
    return _originalPrice;
  }
  
  String? get discountOffer {
    return _discountOffer;
  }
  
  String? get sizeOption {
    return _sizeOption;
  }
  
  Brand? get brand {
    return _brand;
  }
  
  FinerCategory? get finercategory {
    return _finercategory;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Product._internal({required this.id, title, images, description, discountPrice, originalPrice, discountOffer, sizeOption, brand, finercategory, createdAt, updatedAt}): _title = title, _images = images, _description = description, _discountPrice = discountPrice, _originalPrice = originalPrice, _discountOffer = discountOffer, _sizeOption = sizeOption, _brand = brand, _finercategory = finercategory, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Product({String? id, String? title, String? images, String? description, String? discountPrice, String? originalPrice, String? discountOffer, String? sizeOption, Brand? brand, FinerCategory? finercategory}) {
    return Product._internal(
      id: id == null ? UUID.getUUID() : id,
      title: title,
      images: images,
      description: description,
      discountPrice: discountPrice,
      originalPrice: originalPrice,
      discountOffer: discountOffer,
      sizeOption: sizeOption,
      brand: brand,
      finercategory: finercategory);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
      id == other.id &&
      _title == other._title &&
      _images == other._images &&
      _description == other._description &&
      _discountPrice == other._discountPrice &&
      _originalPrice == other._originalPrice &&
      _discountOffer == other._discountOffer &&
      _sizeOption == other._sizeOption &&
      _brand == other._brand &&
      _finercategory == other._finercategory;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Product {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("images=" + "$_images" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("discountPrice=" + "$_discountPrice" + ", ");
    buffer.write("originalPrice=" + "$_originalPrice" + ", ");
    buffer.write("discountOffer=" + "$_discountOffer" + ", ");
    buffer.write("sizeOption=" + "$_sizeOption" + ", ");
    buffer.write("brand=" + (_brand != null ? _brand!.toString() : "null") + ", ");
    buffer.write("finercategory=" + (_finercategory != null ? _finercategory!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Product copyWith({String? id, String? title, String? images, String? description, String? discountPrice, String? originalPrice, String? discountOffer, String? sizeOption, Brand? brand, FinerCategory? finercategory}) {
    return Product._internal(
      id: id ?? this.id,
      title: title ?? this.title,
      images: images ?? this.images,
      description: description ?? this.description,
      discountPrice: discountPrice ?? this.discountPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountOffer: discountOffer ?? this.discountOffer,
      sizeOption: sizeOption ?? this.sizeOption,
      brand: brand ?? this.brand,
      finercategory: finercategory ?? this.finercategory);
  }
  
  Product.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _images = json['images'],
      _description = json['description'],
      _discountPrice = json['discountPrice'],
      _originalPrice = json['originalPrice'],
      _discountOffer = json['discountOffer'],
      _sizeOption = json['sizeOption'],
      _brand = json['brand']?['serializedData'] != null
        ? Brand.fromJson(new Map<String, dynamic>.from(json['brand']['serializedData']))
        : null,
      _finercategory = json['finercategory']?['serializedData'] != null
        ? FinerCategory.fromJson(new Map<String, dynamic>.from(json['finercategory']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'images': _images, 'description': _description, 'discountPrice': _discountPrice, 'originalPrice': _originalPrice, 'discountOffer': _discountOffer, 'sizeOption': _sizeOption, 'brand': _brand?.toJson(), 'finercategory': _finercategory?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'title': _title, 'images': _images, 'description': _description, 'discountPrice': _discountPrice, 'originalPrice': _originalPrice, 'discountOffer': _discountOffer, 'sizeOption': _sizeOption, 'brand': _brand, 'finercategory': _finercategory, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField IMAGES = QueryField(fieldName: "images");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField DISCOUNTPRICE = QueryField(fieldName: "discountPrice");
  static final QueryField ORIGINALPRICE = QueryField(fieldName: "originalPrice");
  static final QueryField DISCOUNTOFFER = QueryField(fieldName: "discountOffer");
  static final QueryField SIZEOPTION = QueryField(fieldName: "sizeOption");
  static final QueryField BRAND = QueryField(
    fieldName: "brand",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Brand).toString()));
  static final QueryField FINERCATEGORY = QueryField(
    fieldName: "finercategory",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FinerCategory).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Product";
    modelSchemaDefinition.pluralName = "Products";
    
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
      ModelIndex(fields: const ["brandID"], name: "byBrand"),
      ModelIndex(fields: const ["finercategoryID"], name: "byFinerCategory")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.TITLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.IMAGES,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.DISCOUNTPRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.ORIGINALPRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.DISCOUNTOFFER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Product.SIZEOPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Product.BRAND,
      isRequired: false,
      targetName: "brandID",
      ofModelName: (Brand).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Product.FINERCATEGORY,
      isRequired: false,
      targetName: "finercategoryID",
      ofModelName: (FinerCategory).toString()
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

class _ProductModelType extends ModelType<Product> {
  const _ProductModelType();
  
  @override
  Product fromJson(Map<String, dynamic> jsonData) {
    return Product.fromJson(jsonData);
  }
}