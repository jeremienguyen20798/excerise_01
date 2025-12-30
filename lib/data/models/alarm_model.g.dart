// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAlarmModelCollection on Isar {
  IsarCollection<AlarmModel> get alarmModels => this.collection();
}

const AlarmModelSchema = CollectionSchema(
  name: r'AlarmModel',
  id: 1796575337475990193,
  properties: {
    r'days': PropertySchema(id: 0, name: r'days', type: IsarType.longList),
    r'isActive': PropertySchema(id: 1, name: r'isActive', type: IsarType.bool),
    r'isDeletedAfterRing': PropertySchema(
      id: 2,
      name: r'isDeletedAfterRing',
      type: IsarType.bool,
    ),
    r'isVibration': PropertySchema(
      id: 3,
      name: r'isVibration',
      type: IsarType.bool,
    ),
    r'message': PropertySchema(id: 4, name: r'message', type: IsarType.string),
    r'repeatType': PropertySchema(
      id: 5,
      name: r'repeatType',
      type: IsarType.byte,
      enumMap: _AlarmModelrepeatTypeEnumValueMap,
    ),
    r'time': PropertySchema(id: 6, name: r'time', type: IsarType.dateTime),
  },

  estimateSize: _alarmModelEstimateSize,
  serialize: _alarmModelSerialize,
  deserialize: _alarmModelDeserialize,
  deserializeProp: _alarmModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'message': IndexSchema(
      id: 800701444045231354,
      name: r'message',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'message',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
    r'time': IndexSchema(
      id: -2250472054110640942,
      name: r'time',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'time',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'days': IndexSchema(
      id: -8885427885754891039,
      name: r'days',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'days',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'isVibration': IndexSchema(
      id: 48614757782046555,
      name: r'isVibration',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isVibration',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'isDeletedAfterRing': IndexSchema(
      id: -4242100497474826981,
      name: r'isDeletedAfterRing',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isDeletedAfterRing',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _alarmModelGetId,
  getLinks: _alarmModelGetLinks,
  attach: _alarmModelAttach,
  version: '3.3.0',
);

int _alarmModelEstimateSize(
  AlarmModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.days;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _alarmModelSerialize(
  AlarmModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.days);
  writer.writeBool(offsets[1], object.isActive);
  writer.writeBool(offsets[2], object.isDeletedAfterRing);
  writer.writeBool(offsets[3], object.isVibration);
  writer.writeString(offsets[4], object.message);
  writer.writeByte(offsets[5], object.repeatType.index);
  writer.writeDateTime(offsets[6], object.time);
}

AlarmModel _alarmModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AlarmModel(
    days: reader.readLongList(offsets[0]),
    isActive: reader.readBoolOrNull(offsets[1]),
    isDeletedAfterRing: reader.readBoolOrNull(offsets[2]),
    isVibration: reader.readBoolOrNull(offsets[3]) ?? true,
    message: reader.readStringOrNull(offsets[4]),
    repeatType:
        _AlarmModelrepeatTypeValueEnumMap[reader.readByteOrNull(offsets[5])] ??
        AlarmRepeatType.onlyOnce,
    time: reader.readDateTime(offsets[6]),
  );
  object.id = id;
  return object;
}

P _alarmModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (_AlarmModelrepeatTypeValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              AlarmRepeatType.onlyOnce)
          as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AlarmModelrepeatTypeEnumValueMap = {
  'onlyOnce': 0,
  'daily': 1,
  'mondayToFriday': 2,
  'custom': 3,
};
const _AlarmModelrepeatTypeValueEnumMap = {
  0: AlarmRepeatType.onlyOnce,
  1: AlarmRepeatType.daily,
  2: AlarmRepeatType.mondayToFriday,
  3: AlarmRepeatType.custom,
};

Id _alarmModelGetId(AlarmModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _alarmModelGetLinks(AlarmModel object) {
  return [];
}

void _alarmModelAttach(IsarCollection<dynamic> col, Id id, AlarmModel object) {
  object.id = id;
}

extension AlarmModelQueryWhereSort
    on QueryBuilder<AlarmModel, AlarmModel, QWhere> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'message'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'time'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isActive'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyDaysElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'days'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyIsVibration() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isVibration'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhere> anyIsDeletedAfterRing() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isDeletedAfterRing'),
      );
    });
  }
}

extension AlarmModelQueryWhere
    on QueryBuilder<AlarmModel, AlarmModel, QWhereClause> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'message', value: [null]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'message',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageEqualTo(
    String? message,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'message', value: [message]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageNotEqualTo(
    String? message,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'message',
                lower: [],
                upper: [message],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'message',
                lower: [message],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'message',
                lower: [message],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'message',
                lower: [],
                upper: [message],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageGreaterThan(
    String? message, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'message',
          lower: [message],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageLessThan(
    String? message, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'message',
          lower: [],
          upper: [message],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageBetween(
    String? lowerMessage,
    String? upperMessage, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'message',
          lower: [lowerMessage],
          includeLower: includeLower,
          upper: [upperMessage],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageStartsWith(
    String MessagePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'message',
          lower: [MessagePrefix],
          upper: ['$MessagePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'message', value: ['']),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'message', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'message', lower: ['']),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(indexName: r'message', lower: ['']),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'message', upper: ['']),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> timeEqualTo(
    DateTime time,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'time', value: [time]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> timeNotEqualTo(
    DateTime time,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'time',
                lower: [],
                upper: [time],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'time',
                lower: [time],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'time',
                lower: [time],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'time',
                lower: [],
                upper: [time],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> timeGreaterThan(
    DateTime time, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'time',
          lower: [time],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> timeLessThan(
    DateTime time, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'time',
          lower: [],
          upper: [time],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> timeBetween(
    DateTime lowerTime,
    DateTime upperTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'time',
          lower: [lowerTime],
          includeLower: includeLower,
          upper: [upperTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'isActive', value: [null]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'isActive',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isActiveEqualTo(
    bool? isActive,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'isActive', value: [isActive]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isActiveNotEqualTo(
    bool? isActive,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isActive',
                lower: [],
                upper: [isActive],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isActive',
                lower: [isActive],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isActive',
                lower: [isActive],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isActive',
                lower: [],
                upper: [isActive],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> daysElementEqualTo(
    int daysElement,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'days', value: [daysElement]),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> daysElementNotEqualTo(
    int daysElement,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'days',
                lower: [],
                upper: [daysElement],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'days',
                lower: [daysElement],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'days',
                lower: [daysElement],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'days',
                lower: [],
                upper: [daysElement],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause>
  daysElementGreaterThan(int daysElement, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'days',
          lower: [daysElement],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> daysElementLessThan(
    int daysElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'days',
          lower: [],
          upper: [daysElement],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> daysElementBetween(
    int lowerDaysElement,
    int upperDaysElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'days',
          lower: [lowerDaysElement],
          includeLower: includeLower,
          upper: [upperDaysElement],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isVibrationEqualTo(
    bool isVibration,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'isVibration',
          value: [isVibration],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause> isVibrationNotEqualTo(
    bool isVibration,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isVibration',
                lower: [],
                upper: [isVibration],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isVibration',
                lower: [isVibration],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isVibration',
                lower: [isVibration],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isVibration',
                lower: [],
                upper: [isVibration],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause>
  isDeletedAfterRingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'isDeletedAfterRing',
          value: [null],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause>
  isDeletedAfterRingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'isDeletedAfterRing',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause>
  isDeletedAfterRingEqualTo(bool? isDeletedAfterRing) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'isDeletedAfterRing',
          value: [isDeletedAfterRing],
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterWhereClause>
  isDeletedAfterRingNotEqualTo(bool? isDeletedAfterRing) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isDeletedAfterRing',
                lower: [],
                upper: [isDeletedAfterRing],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isDeletedAfterRing',
                lower: [isDeletedAfterRing],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isDeletedAfterRing',
                lower: [isDeletedAfterRing],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'isDeletedAfterRing',
                lower: [],
                upper: [isDeletedAfterRing],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AlarmModelQueryFilter
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'days'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'days'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'days', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'days',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'days',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'days',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'days', length, true, length, true);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'days', 0, true, 0, true);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'days', 0, false, 999999, true);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'days', 0, true, length, include);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  daysLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'days', length, include, 999999, true);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> daysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'days',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'isActive'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'isActive'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> isActiveEqualTo(
    bool? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isActive', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  isDeletedAfterRingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'isDeletedAfterRing'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  isDeletedAfterRingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'isDeletedAfterRing'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  isDeletedAfterRingEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDeletedAfterRing', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  isVibrationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isVibration', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'message'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'message'),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'message',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'message',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'message',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'message', value: ''),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> repeatTypeEqualTo(
    AlarmRepeatType value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repeatType', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  repeatTypeGreaterThan(AlarmRepeatType value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repeatType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition>
  repeatTypeLessThan(AlarmRepeatType value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repeatType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> repeatTypeBetween(
    AlarmRepeatType lower,
    AlarmRepeatType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repeatType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> timeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'time', value: value),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> timeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'time',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> timeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'time',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterFilterCondition> timeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'time',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AlarmModelQueryObject
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {}

extension AlarmModelQueryLinks
    on QueryBuilder<AlarmModel, AlarmModel, QFilterCondition> {}

extension AlarmModelQuerySortBy
    on QueryBuilder<AlarmModel, AlarmModel, QSortBy> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
  sortByIsDeletedAfterRing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAfterRing', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
  sortByIsDeletedAfterRingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAfterRing', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsVibration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVibration', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByIsVibrationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVibration', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByRepeatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByRepeatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }
}

extension AlarmModelQuerySortThenBy
    on QueryBuilder<AlarmModel, AlarmModel, QSortThenBy> {
  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
  thenByIsDeletedAfterRing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAfterRing', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy>
  thenByIsDeletedAfterRingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeletedAfterRing', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsVibration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVibration', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByIsVibrationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVibration', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByRepeatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByRepeatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.desc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }
}

extension AlarmModelQueryWhereDistinct
    on QueryBuilder<AlarmModel, AlarmModel, QDistinct> {
  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'days');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct>
  distinctByIsDeletedAfterRing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeletedAfterRing');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByIsVibration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVibration');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByMessage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByRepeatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatType');
    });
  }

  QueryBuilder<AlarmModel, AlarmModel, QDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time');
    });
  }
}

extension AlarmModelQueryProperty
    on QueryBuilder<AlarmModel, AlarmModel, QQueryProperty> {
  QueryBuilder<AlarmModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AlarmModel, List<int>?, QQueryOperations> daysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'days');
    });
  }

  QueryBuilder<AlarmModel, bool?, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<AlarmModel, bool?, QQueryOperations>
  isDeletedAfterRingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeletedAfterRing');
    });
  }

  QueryBuilder<AlarmModel, bool, QQueryOperations> isVibrationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVibration');
    });
  }

  QueryBuilder<AlarmModel, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<AlarmModel, AlarmRepeatType, QQueryOperations>
  repeatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatType');
    });
  }

  QueryBuilder<AlarmModel, DateTime, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }
}
