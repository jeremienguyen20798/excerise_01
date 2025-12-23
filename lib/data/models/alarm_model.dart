import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:isar_community/isar.dart';
import '../../domain/entities/alarm_repeat_type.dart';

part 'alarm_model.g.dart';

@collection
class AlarmModel {
  Id id = Isar.autoIncrement;

  //Tin nhan bao thuc
  @Index(type: IndexType.value)
  String? message;

  //Thoi gian bao thuc
  @Index(type: IndexType.value)
  DateTime time;

  //Che do lap lai bao thuc
  @enumerated
  AlarmRepeatType repeatType;

  //Trang thai bao thuc
  @Index(type: IndexType.value)
  bool? isActive;

  //Danh sach cac ngay bao thuc
  @Index(type: IndexType.value)
  List<int>? days;

  AlarmModel({
    this.message = defaultMessage,
    required this.time,
    this.repeatType = AlarmRepeatType.onlyOnce,
    this.isActive = true,
    this.days,
  });

  AlarmEntity toEntity() {
    return AlarmEntity(
      alarmId: id,
      message: message,
      time: time,
      repeatType: repeatType,
      isActive: isActive,
      days: days,
    );
  }
}
