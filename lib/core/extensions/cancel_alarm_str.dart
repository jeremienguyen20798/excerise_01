extension CancelAlarmStr on Duration {

  String getTitleOption() {
    switch (inDays) {
      case 1:
        return 'Ngày mai';
      default:
        return '';
    }
  }
}
