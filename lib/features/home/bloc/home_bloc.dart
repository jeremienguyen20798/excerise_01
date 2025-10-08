import 'package:excerise_01/domain/usecase/delete_alarms_usecase.dart';
import 'package:excerise_01/domain/usecase/get_alarms_usecase.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/notification/alarm_notification.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AlarmNotification alarmNotification = AlarmNotification();
  List<int> itemDeleteIds = [];

  HomeBloc() : super(InitHomeState()) {
    on<ItemAlarmLongPressEvent>(_onLongPressItem);
    on<OnRestartEvent>(_onRestart);
    on<OnReloadAlarmListEvent>(_onReloadAlarmList);
    on<CancelDeleteAllItemsEvent>(_cancelDeleteAllItems);
    on<AddItemForDeleteEvent>(_addItemDelete);
    on<GetAlarmListEvent>(_getAlarmList);
    on<UpdateAlarmStatusEvent>(_updateAlarmStatus);
    on<UpdateAlarmEvent>(_updateAlarm);
    on<UpdateItemForListEvent>(_updateItemForList);
    on<DeleteAlarmEvent>(_onDeleteAlarm);
    on<DeleteAllAlarmsEvent>(_onDeleteAllAlarms);
    on<RequestNotificationPermissionEvent>(_requestNotificationPermission);
  }

  //Lấy ra danh sách các báo thức
  Future<void> _getAlarmList(
    GetAlarmListEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final dataList = await GetAlarmsUseCase().execute();
    emitter(GetAlarmListState(dataList));
  }

  //Xử lý khi long press item alarm thì hiện UI chọn một hoặc nhiều item để xoá
  void _onLongPressItem(
    ItemAlarmLongPressEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ItemAlarmLongPressState());
  }

  //Đưa mọi thứ trở về trạng thái ban đầu
  void _onRestart(OnRestartEvent event, Emitter<HomeState> emitter) {
    emitter(OnRestartState());
  }

  //Them các item vào danh sách để xoá
  void _addItemDelete(AddItemForDeleteEvent event, Emitter<HomeState> emitter) {
    itemDeleteIds.add(event.id);
    emitter(AddItemForDeleteState());
  }

  //Xoá các item alarm
  Future<void> _onDeleteAlarm(
    DeleteAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    await DeleteAlarmsUseCase().execute(itemDeleteIds);
    await alarmNotification.cancelAllAlarmRing();
    final dataList = await GetAlarmsUseCase().execute();
    emitter(DeleteAlarmState(dataList));
  }

  //Add all items alarm into blacklist
  Future<void> _onDeleteAllAlarms(
    DeleteAllAlarmsEvent event,
    Emitter<HomeState> emitter,
  ) async {
    // final alarms = await localDB.getAlarms();
    // if (alarms.isNotEmpty) {
    //   itemDeleteIds = alarms.map((item) => item.id).toList();
    //   emitter(DeleteAllAlarmsState(true));
    // }
    // final alarms = await localDB.getAlarms();
    // if (alarms.isNotEmpty) {
    //   itemDeleteIds = alarms.map((item) => item.id).toList();
    //   alarmNotification.cancelAllAlarmRing();
    //   emitter(DeleteAllAlarmsState(true));
    // }
  }

  //Cập nhật nhanh trạng thái của báo thức
  Future<void> _updateAlarmStatus(
    UpdateAlarmStatusEvent event,
    Emitter<HomeState> emitter,
  ) async {
    // int id = event.id;
    // bool isActive = event.isActive;
    // await localDB.updateAlarmStatus(id, isActive);
    // final alarm = await localDB.getAlarmById(id);
    // if (event.option == null) {
    //   if (alarm != null) {
    //     if (isActive) {
    //       await alarmNotification.showNotification(alarm);
    //     } else {
    //       await alarmNotification.cancelAlarmRingById(id);
    //     }
    //   }
    // } else {
    //   String cancelOption = event.option!;
    //   if (cancelOption == "cancel") {
    //     if (alarm != null) {
    //       if (isActive) {
    //         await alarmNotification.showNotification(alarm);
    //       } else {
    //         await alarmNotification.cancelAlarmRingById(id);
    //       }
    //     }
    //   } else {
    //     log('Tính năng đang được phát triển');
    //   }
    // }
  }

  //Cập nhật nội dung chi tiết của báo thức
  Future<void> _updateAlarm(
    UpdateAlarmEvent event,
    Emitter<HomeState> emitter,
  ) async {
    // final int index = event.index;
    // final data = event.data;
    // final idAlarm = data['id'];
    // final dateTime = data['dateTime'];
    // final isActive = data['isActive'];
    // log("Data update: $dateTime - $isActive");
    // await localDB.updateAlarm(idAlarm, dateTime, isActive);
    // final alarm = await localDB.getAlarmById(idAlarm);
    // if (alarm != null) {
    //   if (isActive) {
    //     await alarmNotification.showNotification(alarm);
    //   } else {
    //     await alarmNotification.cancelAlarmRingById(idAlarm);
    //   }
    //   emitter(UpdateItemState(index, alarm));
    // }
  }

  //Reload danh sách báo thức khi có thêm mới item
  void _onReloadAlarmList(
    OnReloadAlarmListEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ReloadAlarmListState(event.alarm));
  }

  //Cập nhật dữ liệu item báo thức
  Future<void> _updateItemForList(
    UpdateItemForListEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final int index = event.index;
    await alarmNotification.showNotification(event.alarm);
    emitter(UpdateItemForListState(index, event.alarm));
  }

  //Huỷ việc xoá tất cả item báo thức
  void _cancelDeleteAllItems(
    CancelDeleteAllItemsEvent event,
    Emitter<HomeState> emitter,
  ) {
    itemDeleteIds = [];
    emitter(CancelDeleteAllItemsState());
  }

  //Xử lý UI khi xin quyền hiện thông báo
  Future<void> _requestNotificationPermission(
    RequestNotificationPermissionEvent event,
    Emitter<HomeState> emitter,
  ) async {
    final result = await Permission.notification.request();
    if (result.isDenied || result.isPermanentlyDenied) {
      emitter(DeniedNotificationPermissionRequestState());
    }
  }
}
