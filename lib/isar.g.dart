// ignore_for_file: unused_import, implementation_imports

import 'dart:ffi';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:isar/src/isar_native.dart';
import 'package:isar/src/query_builder.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'repository/db_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';

const _utf8Encoder = Utf8Encoder();

final _schema =
    '[{"name":"CategoryList","idProperty":"categoryId","properties":[{"name":"categoryId","type":3},{"name":"category","type":5}],"indexes":[],"links":[]},{"name":"Instract","idProperty":"instractId","properties":[{"name":"instractId","type":3},{"name":"categoryId","type":3},{"name":"question","type":5},{"name":"answers","type":11}],"indexes":[],"links":[]}]';

Future<Isar> openIsar(
    {String name = 'isar',
    String? directory,
    int maxSize = 1000000000,
    Uint8List? encryptionKey}) async {
  final path = await _preparePath(directory);
  return openIsarInternal(
      name: name,
      directory: path,
      maxSize: maxSize,
      encryptionKey: encryptionKey,
      schema: _schema,
      getCollections: (isar) {
        final collectionPtrPtr = malloc<Pointer>();
        final propertyOffsetsPtr = malloc<Uint32>(4);
        final propertyOffsets = propertyOffsetsPtr.asTypedList(4);
        final collections = <String, IsarCollection>{};
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 0));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['RepositoryCategory'] =
            IsarCollectionImpl<RepositoryCategory>(
          isar: isar,
          adapter: _RepositoryCategoryAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 2),
          propertyIds: {'categoryId': 0, 'category': 1},
          indexIds: {},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.categoryId,
          setId: (obj, id) => obj.categoryId = id,
        );
        nCall(IC.isar_get_collection(isar.ptr, collectionPtrPtr, 1));
        IC.isar_get_property_offsets(
            collectionPtrPtr.value, propertyOffsetsPtr);
        collections['RepositoryInstract'] =
            IsarCollectionImpl<RepositoryInstract>(
          isar: isar,
          adapter: _RepositoryInstractAdapter(),
          ptr: collectionPtrPtr.value,
          propertyOffsets: propertyOffsets.sublist(0, 4),
          propertyIds: {
            'instractId': 0,
            'categoryId': 1,
            'question': 2,
            'answers': 3
          },
          indexIds: {},
          linkIds: {},
          backlinkIds: {},
          getId: (obj) => obj.instractId,
          setId: (obj, id) => obj.instractId = id,
        );
        malloc.free(propertyOffsetsPtr);
        malloc.free(collectionPtrPtr);

        return collections;
      });
}

Future<String> _preparePath(String? path) async {
  if (path == null || p.isRelative(path)) {
    WidgetsFlutterBinding.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    // print(dir);
    return p.join(dir.path, path ?? 'isar');
  } else {
    return path;
  }
}

class _RepositoryCategoryAdapter extends TypeAdapter<RepositoryCategory> {
  @override
  int serialize(IsarCollectionImpl<RepositoryCategory> collection,
      RawObject rawObj, RepositoryCategory object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.categoryId;
    final _categoryId = value0;
    final value1 = object.category;
    final _category = _utf8Encoder.convert(value1);
    dynamicSize += _category.length;
    final size = dynamicSize + 18;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        malloc.free(rawObj.buffer);
        rawObj.buffer = malloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = malloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = rawObj.buffer.asTypedList(size);
    final writer = BinaryWriter(buffer, 18);
    writer.writeLong(offsets[0], _categoryId);
    writer.writeBytes(offsets[1], _category);
    return bufferSize;
  }

  @override
  RepositoryCategory deserialize(
      IsarCollectionImpl<RepositoryCategory> collection,
      BinaryReader reader,
      List<int> offsets) {
    final object = RepositoryCategory();
    object.categoryId = reader.readLongOrNull(offsets[0]);
    object.category = reader.readString(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

class _RepositoryInstractAdapter extends TypeAdapter<RepositoryInstract> {
  @override
  int serialize(IsarCollectionImpl<RepositoryInstract> collection,
      RawObject rawObj, RepositoryInstract object, List<int> offsets,
      [int? existingBufferSize]) {
    var dynamicSize = 0;
    final value0 = object.instractId;
    final _instractId = value0;
    final value1 = object.categoryId;
    final _categoryId = value1;
    final value2 = object.question;
    final _question = _utf8Encoder.convert(value2);
    dynamicSize += _question.length;
    final value3 = object.answers;
    dynamicSize += (value3.length) * 8;
    final bytesList3 = <Uint8List>[];
    for (var str in value3) {
      final bytes = _utf8Encoder.convert(str);
      bytesList3.add(bytes);
      dynamicSize += bytes.length;
    }
    final _answers = bytesList3;
    final size = dynamicSize + 34;

    late int bufferSize;
    if (existingBufferSize != null) {
      if (existingBufferSize < size) {
        malloc.free(rawObj.buffer);
        rawObj.buffer = malloc(size);
        bufferSize = size;
      } else {
        bufferSize = existingBufferSize;
      }
    } else {
      rawObj.buffer = malloc(size);
      bufferSize = size;
    }
    rawObj.buffer_length = size;
    final buffer = rawObj.buffer.asTypedList(size);
    final writer = BinaryWriter(buffer, 34);
    writer.writeLong(offsets[0], _instractId);
    writer.writeLong(offsets[1], _categoryId);
    writer.writeBytes(offsets[2], _question);
    writer.writeStringList(offsets[3], _answers);
    return bufferSize;
  }

  @override
  RepositoryInstract deserialize(
      IsarCollectionImpl<RepositoryInstract> collection,
      BinaryReader reader,
      List<int> offsets) {
    final object = RepositoryInstract();
    object.instractId = reader.readLongOrNull(offsets[0]);
    object.categoryId = reader.readLong(offsets[1]);
    object.question = reader.readString(offsets[2]);
    object.answers = reader.readStringList(offsets[3]) ?? [];
    return object;
  }

  @override
  P deserializeProperty<P>(BinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case 0:
        return (reader.readLongOrNull(offset)) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readStringList(offset) ?? []) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }
}

extension GetCollection on Isar {
  IsarCollection<RepositoryCategory> get repositoryCategorys {
    return getCollection('RepositoryCategory');
  }

  IsarCollection<RepositoryInstract> get repositoryInstracts {
    return getCollection('RepositoryInstract');
  }
}

extension RepositoryCategoryQueryWhereSort
    on QueryBuilder<RepositoryCategory, QWhere> {
  QueryBuilder<RepositoryCategory, QAfterWhere> anyCategoryId() {
    return addWhereClause(WhereClause(indexName: 'categoryId'));
  }
}

extension RepositoryCategoryQueryWhere
    on QueryBuilder<RepositoryCategory, QWhereClause> {}

extension RepositoryInstractQueryWhereSort
    on QueryBuilder<RepositoryInstract, QWhere> {
  QueryBuilder<RepositoryInstract, QAfterWhere> anyInstractId() {
    return addWhereClause(WhereClause(indexName: 'instractId'));
  }
}

extension RepositoryInstractQueryWhere
    on QueryBuilder<RepositoryInstract, QWhereClause> {}

extension RepositoryCategoryQueryFilter
    on QueryBuilder<RepositoryCategory, QFilterCondition> {
  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'categoryId',
      value: null,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryIdLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'categoryId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryEqualTo(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'category',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryEndsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'category',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'category',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'category',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension RepositoryInstractQueryFilter
    on QueryBuilder<RepositoryInstract, QFilterCondition> {
  QueryBuilder<RepositoryInstract, QAfterFilterCondition> instractIdIsNull() {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'instractId',
      value: null,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> instractIdEqualTo(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> instractIdGreaterThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> instractIdLessThan(
      int? value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> instractIdBetween(
      int? lower, int? upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'instractId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> categoryIdEqualTo(
      int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> categoryIdGreaterThan(
      int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Gt,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> categoryIdLessThan(
      int value) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Lt,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> categoryIdBetween(
      int lower, int upper) {
    return addFilterCondition(FilterCondition.between(
      property: 'categoryId',
      lower: lower,
      upper: upper,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> questionEqualTo(
      String value,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Eq,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> questionStartsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.StartsWith,
      property: 'question',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> questionEndsWith(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.EndsWith,
      property: 'question',
      value: convertedValue,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> questionContains(
      String value,
      {bool caseSensitive = true}) {
    final convertedValue = value;
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'question',
      value: '*$convertedValue*',
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, QAfterFilterCondition> questionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterCondition(FilterCondition(
      type: ConditionType.Matches,
      property: 'question',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension RepositoryCategoryQueryLinks
    on QueryBuilder<RepositoryCategory, QFilterCondition> {}

extension RepositoryInstractQueryLinks
    on QueryBuilder<RepositoryInstract, QFilterCondition> {}

extension RepositoryCategoryQueryWhereSortBy
    on QueryBuilder<RepositoryCategory, QSortBy> {
  QueryBuilder<RepositoryCategory, QAfterSortBy> sortByCategoryId() {
    return addSortByInternal('categoryId', Sort.Asc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> sortByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.Desc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> sortByCategory() {
    return addSortByInternal('category', Sort.Asc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> sortByCategoryDesc() {
    return addSortByInternal('category', Sort.Desc);
  }
}

extension RepositoryCategoryQueryWhereSortThenBy
    on QueryBuilder<RepositoryCategory, QSortThenBy> {
  QueryBuilder<RepositoryCategory, QAfterSortBy> thenByCategoryId() {
    return addSortByInternal('categoryId', Sort.Asc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> thenByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.Desc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> thenByCategory() {
    return addSortByInternal('category', Sort.Asc);
  }

  QueryBuilder<RepositoryCategory, QAfterSortBy> thenByCategoryDesc() {
    return addSortByInternal('category', Sort.Desc);
  }
}

extension RepositoryInstractQueryWhereSortBy
    on QueryBuilder<RepositoryInstract, QSortBy> {
  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByInstractId() {
    return addSortByInternal('instractId', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByInstractIdDesc() {
    return addSortByInternal('instractId', Sort.Desc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByCategoryId() {
    return addSortByInternal('categoryId', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.Desc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByQuestion() {
    return addSortByInternal('question', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> sortByQuestionDesc() {
    return addSortByInternal('question', Sort.Desc);
  }
}

extension RepositoryInstractQueryWhereSortThenBy
    on QueryBuilder<RepositoryInstract, QSortThenBy> {
  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByInstractId() {
    return addSortByInternal('instractId', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByInstractIdDesc() {
    return addSortByInternal('instractId', Sort.Desc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByCategoryId() {
    return addSortByInternal('categoryId', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.Desc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByQuestion() {
    return addSortByInternal('question', Sort.Asc);
  }

  QueryBuilder<RepositoryInstract, QAfterSortBy> thenByQuestionDesc() {
    return addSortByInternal('question', Sort.Desc);
  }
}

extension RepositoryCategoryQueryWhereDistinct
    on QueryBuilder<RepositoryCategory, QDistinct> {
  QueryBuilder<RepositoryCategory, QDistinct> distinctByCategoryId() {
    return addDistinctByInternal('categoryId');
  }

  QueryBuilder<RepositoryCategory, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('category', caseSensitive: caseSensitive);
  }
}

extension RepositoryInstractQueryWhereDistinct
    on QueryBuilder<RepositoryInstract, QDistinct> {
  QueryBuilder<RepositoryInstract, QDistinct> distinctByInstractId() {
    return addDistinctByInternal('instractId');
  }

  QueryBuilder<RepositoryInstract, QDistinct> distinctByCategoryId() {
    return addDistinctByInternal('categoryId');
  }

  QueryBuilder<RepositoryInstract, QDistinct> distinctByQuestion(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('question', caseSensitive: caseSensitive);
  }
}

extension RepositoryCategoryQueryProperty
    on QueryBuilder<RepositoryCategory, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> categoryIdProperty() {
    return addPropertyName('categoryId');
  }

  QueryBuilder<String, QQueryOperations> categoryProperty() {
    return addPropertyName('category');
  }
}

extension RepositoryInstractQueryProperty
    on QueryBuilder<RepositoryInstract, QQueryProperty> {
  QueryBuilder<int?, QQueryOperations> instractIdProperty() {
    return addPropertyName('instractId');
  }

  QueryBuilder<int, QQueryOperations> categoryIdProperty() {
    return addPropertyName('categoryId');
  }

  QueryBuilder<String, QQueryOperations> questionProperty() {
    return addPropertyName('question');
  }

  QueryBuilder<List<String>, QQueryOperations> answersProperty() {
    return addPropertyName('answers');
  }
}
