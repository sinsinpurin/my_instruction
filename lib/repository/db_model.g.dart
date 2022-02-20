// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetRepositoryCategoryCollection on Isar {
  IsarCollection<RepositoryCategory> get repositoryCategorys {
    return getCollection('CategoryList');
  }
}

final RepositoryCategorySchema = CollectionSchema(
  name: 'CategoryList',
  schema:
      '{"name":"CategoryList","idName":"categoryId","properties":[{"name":"category","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _RepositoryCategoryNativeAdapter(),
  webAdapter: const _RepositoryCategoryWebAdapter(),
  idName: 'categoryId',
  propertyIds: {'category': 0},
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.categoryId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.categoryId;
    }
  },
  setId: (obj, id) => obj.categoryId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _RepositoryCategoryWebAdapter
    extends IsarWebTypeAdapter<RepositoryCategory> {
  const _RepositoryCategoryWebAdapter();

  @override
  Object serialize(IsarCollection<RepositoryCategory> collection,
      RepositoryCategory object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'category', object.category);
    IsarNative.jsObjectSet(jsObj, 'categoryId', object.categoryId);
    return jsObj;
  }

  @override
  RepositoryCategory deserialize(
      IsarCollection<RepositoryCategory> collection, dynamic jsObj) {
    final object = RepositoryCategory();
    object.category = IsarNative.jsObjectGet(jsObj, 'category') ?? '';
    object.categoryId = IsarNative.jsObjectGet(jsObj, 'categoryId');
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'category':
        return (IsarNative.jsObjectGet(jsObj, 'category') ?? '') as P;
      case 'categoryId':
        return (IsarNative.jsObjectGet(jsObj, 'categoryId')) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RepositoryCategory object) {}
}

class _RepositoryCategoryNativeAdapter
    extends IsarNativeTypeAdapter<RepositoryCategory> {
  const _RepositoryCategoryNativeAdapter();

  @override
  void serialize(
      IsarCollection<RepositoryCategory> collection,
      IsarRawObject rawObj,
      RepositoryCategory object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.category;
    final _category = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_category.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _category);
  }

  @override
  RepositoryCategory deserialize(IsarCollection<RepositoryCategory> collection,
      int id, IsarBinaryReader reader, List<int> offsets) {
    final object = RepositoryCategory();
    object.category = reader.readString(offsets[0]);
    object.categoryId = id;
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RepositoryCategory object) {}
}

extension RepositoryCategoryQueryWhereSort
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QWhere> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhere>
      anyCategoryId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension RepositoryCategoryQueryWhere
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QWhereClause> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhereClause>
      categoryIdEqualTo(int? categoryId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [categoryId],
      includeLower: true,
      upper: [categoryId],
      includeUpper: true,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhereClause>
      categoryIdNotEqualTo(int? categoryId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [categoryId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [categoryId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [categoryId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [categoryId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhereClause>
      categoryIdGreaterThan(
    int? categoryId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [categoryId],
      includeLower: include,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhereClause>
      categoryIdLessThan(
    int? categoryId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [categoryId],
      includeUpper: include,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterWhereClause>
      categoryIdBetween(
    int? lowerCategoryId,
    int? upperCategoryId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerCategoryId],
      includeLower: includeLower,
      upper: [upperCategoryId],
      includeUpper: includeUpper,
    ));
  }
}

extension RepositoryCategoryQueryFilter
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QFilterCondition> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'category',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'category',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'categoryId',
      value: null,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterFilterCondition>
      categoryIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'categoryId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension RepositoryCategoryQueryWhereSortBy
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QSortBy> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      sortByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      sortByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      sortByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      sortByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }
}

extension RepositoryCategoryQueryWhereSortThenBy
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QSortThenBy> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      thenByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      thenByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      thenByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QAfterSortBy>
      thenByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }
}

extension RepositoryCategoryQueryWhereDistinct
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QDistinct> {
  QueryBuilder<RepositoryCategory, RepositoryCategory, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return addDistinctByInternal('category', caseSensitive: caseSensitive);
  }

  QueryBuilder<RepositoryCategory, RepositoryCategory, QDistinct>
      distinctByCategoryId() {
    return addDistinctByInternal('categoryId');
  }
}

extension RepositoryCategoryQueryProperty
    on QueryBuilder<RepositoryCategory, RepositoryCategory, QQueryProperty> {
  QueryBuilder<RepositoryCategory, String, QQueryOperations>
      categoryProperty() {
    return addPropertyNameInternal('category');
  }

  QueryBuilder<RepositoryCategory, int?, QQueryOperations>
      categoryIdProperty() {
    return addPropertyNameInternal('categoryId');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetRepositoryInstractCollection on Isar {
  IsarCollection<RepositoryInstract> get repositoryInstracts {
    return getCollection('Instract');
  }
}

final RepositoryInstractSchema = CollectionSchema(
  name: 'Instract',
  schema:
      '{"name":"Instract","idName":"instractId","properties":[{"name":"answers","type":"StringList"},{"name":"categoryId","type":"Long"},{"name":"question","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _RepositoryInstractNativeAdapter(),
  webAdapter: const _RepositoryInstractWebAdapter(),
  idName: 'instractId',
  propertyIds: {'answers': 0, 'categoryId': 1, 'question': 2},
  listProperties: {'answers'},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.instractId == Isar.autoIncrement) {
      return null;
    } else {
      return obj.instractId;
    }
  },
  setId: (obj, id) => obj.instractId = id,
  getLinks: (obj) => [],
  version: 2,
);

class _RepositoryInstractWebAdapter
    extends IsarWebTypeAdapter<RepositoryInstract> {
  const _RepositoryInstractWebAdapter();

  @override
  Object serialize(IsarCollection<RepositoryInstract> collection,
      RepositoryInstract object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'answers', object.answers);
    IsarNative.jsObjectSet(jsObj, 'categoryId', object.categoryId);
    IsarNative.jsObjectSet(jsObj, 'instractId', object.instractId);
    IsarNative.jsObjectSet(jsObj, 'question', object.question);
    return jsObj;
  }

  @override
  RepositoryInstract deserialize(
      IsarCollection<RepositoryInstract> collection, dynamic jsObj) {
    final object = RepositoryInstract();
    object.answers = (IsarNative.jsObjectGet(jsObj, 'answers') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [];
    object.categoryId =
        IsarNative.jsObjectGet(jsObj, 'categoryId') ?? double.negativeInfinity;
    object.instractId = IsarNative.jsObjectGet(jsObj, 'instractId');
    object.question = IsarNative.jsObjectGet(jsObj, 'question') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'answers':
        return ((IsarNative.jsObjectGet(jsObj, 'answers') as List?)
                ?.map((e) => e ?? '')
                .toList()
                .cast<String>() ??
            []) as P;
      case 'categoryId':
        return (IsarNative.jsObjectGet(jsObj, 'categoryId') ??
            double.negativeInfinity) as P;
      case 'instractId':
        return (IsarNative.jsObjectGet(jsObj, 'instractId')) as P;
      case 'question':
        return (IsarNative.jsObjectGet(jsObj, 'question') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RepositoryInstract object) {}
}

class _RepositoryInstractNativeAdapter
    extends IsarNativeTypeAdapter<RepositoryInstract> {
  const _RepositoryInstractNativeAdapter();

  @override
  void serialize(
      IsarCollection<RepositoryInstract> collection,
      IsarRawObject rawObj,
      RepositoryInstract object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.answers;
    dynamicSize += (value0.length) * 8;
    final bytesList0 = <IsarUint8List>[];
    for (var str in value0) {
      final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
      bytesList0.add(bytes);
      dynamicSize += bytes.length as int;
    }
    final _answers = bytesList0;
    final value1 = object.categoryId;
    final _categoryId = value1;
    final value2 = object.question;
    final _question = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_question.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeStringList(offsets[0], _answers);
    writer.writeLong(offsets[1], _categoryId);
    writer.writeBytes(offsets[2], _question);
  }

  @override
  RepositoryInstract deserialize(IsarCollection<RepositoryInstract> collection,
      int id, IsarBinaryReader reader, List<int> offsets) {
    final object = RepositoryInstract();
    object.answers = reader.readStringList(offsets[0]) ?? [];
    object.categoryId = reader.readLong(offsets[1]);
    object.instractId = id;
    object.question = reader.readString(offsets[2]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readStringList(offset) ?? []) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RepositoryInstract object) {}
}

extension RepositoryInstractQueryWhereSort
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QWhere> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhere>
      anyInstractId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension RepositoryInstractQueryWhere
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QWhereClause> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhereClause>
      instractIdEqualTo(int? instractId) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [instractId],
      includeLower: true,
      upper: [instractId],
      includeUpper: true,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhereClause>
      instractIdNotEqualTo(int? instractId) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [instractId],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [instractId],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [instractId],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [instractId],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhereClause>
      instractIdGreaterThan(
    int? instractId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [instractId],
      includeLower: include,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhereClause>
      instractIdLessThan(
    int? instractId, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [instractId],
      includeUpper: include,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterWhereClause>
      instractIdBetween(
    int? lowerInstractId,
    int? upperInstractId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerInstractId],
      includeLower: includeLower,
      upper: [upperInstractId],
      includeUpper: includeUpper,
    ));
  }
}

extension RepositoryInstractQueryFilter
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QFilterCondition> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'answers',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'answers',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      answersAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'answers',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      categoryIdEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      categoryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      categoryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'categoryId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'categoryId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      instractIdIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'instractId',
      value: null,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      instractIdEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      instractIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      instractIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'instractId',
      value: value,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      instractIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'instractId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'question',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'question',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'question',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension RepositoryInstractQueryWhereSortBy
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QSortBy> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByInstractId() {
    return addSortByInternal('instractId', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByInstractIdDesc() {
    return addSortByInternal('instractId', Sort.desc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByQuestion() {
    return addSortByInternal('question', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      sortByQuestionDesc() {
    return addSortByInternal('question', Sort.desc);
  }
}

extension RepositoryInstractQueryWhereSortThenBy
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QSortThenBy> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByCategoryId() {
    return addSortByInternal('categoryId', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByCategoryIdDesc() {
    return addSortByInternal('categoryId', Sort.desc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByInstractId() {
    return addSortByInternal('instractId', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByInstractIdDesc() {
    return addSortByInternal('instractId', Sort.desc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByQuestion() {
    return addSortByInternal('question', Sort.asc);
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QAfterSortBy>
      thenByQuestionDesc() {
    return addSortByInternal('question', Sort.desc);
  }
}

extension RepositoryInstractQueryWhereDistinct
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QDistinct> {
  QueryBuilder<RepositoryInstract, RepositoryInstract, QDistinct>
      distinctByCategoryId() {
    return addDistinctByInternal('categoryId');
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QDistinct>
      distinctByInstractId() {
    return addDistinctByInternal('instractId');
  }

  QueryBuilder<RepositoryInstract, RepositoryInstract, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return addDistinctByInternal('question', caseSensitive: caseSensitive);
  }
}

extension RepositoryInstractQueryProperty
    on QueryBuilder<RepositoryInstract, RepositoryInstract, QQueryProperty> {
  QueryBuilder<RepositoryInstract, List<String>, QQueryOperations>
      answersProperty() {
    return addPropertyNameInternal('answers');
  }

  QueryBuilder<RepositoryInstract, int, QQueryOperations> categoryIdProperty() {
    return addPropertyNameInternal('categoryId');
  }

  QueryBuilder<RepositoryInstract, int?, QQueryOperations>
      instractIdProperty() {
    return addPropertyNameInternal('instractId');
  }

  QueryBuilder<RepositoryInstract, String, QQueryOperations>
      questionProperty() {
    return addPropertyNameInternal('question');
  }
}
