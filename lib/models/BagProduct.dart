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


/** This is an auto generated class representing the BagProduct type in your schema. */
@immutable
class BagProduct extends Model {
  static const classType = const _BagProductModelType();
  final String id;
  final String? _bagID;
  final String? _productID;
  final Product? _product;
  final String? _size;
  final int? _quantity;
  final bool? _isRated;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get bagID {
    try {
      return _bagID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get productID {
    try {
      return _productID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Product? get product {
    return _product;
  }
  
  String? get size {
    return _size;
  }
  
  int? get quantity {
    return _quantity;
  }
  
  bool? get isRated {
    return _isRated;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const BagProduct._internal({required this.id, required bagID, required productID, product, size, quantity, isRated, createdAt, updatedAt}): _bagID = bagID, _productID = productID, _product = product, _size = size, _quantity = quantity, _isRated = isRated, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BagProduct({String? id, required String bagID, required String productID, Product? product, String? size, int? quantity, bool? isRated}) {
    return BagProduct._internal(
      id: id == null ? UUID.getUUID() : id,
      bagID: bagID,
      productID: productID,
      product: product,
      size: size,
      quantity: quantity,
      isRated: isRated);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BagProduct &&
      id == other.id &&
      _bagID == other._bagID &&
      _productID == other._productID &&
      _product == other._product &&
      _size == other._size &&
      _quantity == other._quantity &&
      _isRated == other._isRated;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BagProduct {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("bagID=" + "$_bagID" + ", ");
    buffer.write("productID=" + "$_productID" + ", ");
    buffer.write("size=" + "$_size" + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("isRated=" + (_isRated != null ? _isRated!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BagProduct copyWith({String? id, String? bagID, String? productID, Product? product, String? size, int? quantity, bool? isRated}) {
    return BagProduct._internal(
      id: id ?? this.id,
      bagID: bagID ?? this.bagID,
      productID: productID ?? this.productID,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      isRated: isRated ?? this.isRated);
  }
  
  BagProduct.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _bagID = json['bagID'],
      _productID = json['productID'],
      _product = json['product']?['serializedData'] != null
        ? Product.fromJson(new Map<String, dynamic>.from(json['product']['serializedData']))
        : null,
      _size = json['size'],
      _quantity = (json['quantity'] as num?)?.toInt(),
      _isRated = json['isRated'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'bagID': _bagID, 'productID': _productID, 'product': _product?.toJson(), 'size': _size, 'quantity': _quantity, 'isRated': _isRated, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'bagID': _bagID, 'productID': _productID, 'product': _product, 'size': _size, 'quantity': _quantity, 'isRated': _isRated, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField BAGID = QueryField(fieldName: "bagID");
  static final QueryField PRODUCTID = QueryField(fieldName: "productID");
  static final QueryField PRODUCT = QueryField(
    fieldName: "product",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Product).toString()));
  static final QueryField SIZE = QueryField(fieldName: "size");
  static final QueryField QUANTITY = QueryField(fieldName: "quantity");
  static final QueryField ISRATED = QueryField(fieldName: "isRated");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BagProduct";
    modelSchemaDefinition.pluralName = "BagProducts";
    
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
      ModelIndex(fields: const ["bagID"], name: "byBag")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BagProduct.BAGID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BagProduct.PRODUCTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: BagProduct.PRODUCT,
      isRequired: false,
      ofModelName: (Product).toString(),
      associatedKey: Product.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BagProduct.SIZE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BagProduct.QUANTITY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BagProduct.ISRATED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
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

class _BagProductModelType extends ModelType<BagProduct> {
  const _BagProductModelType();
  
  @override
  BagProduct fromJson(Map<String, dynamic> jsonData) {
    return BagProduct.fromJson(jsonData);
  }
}