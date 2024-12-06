import 'package:intl/intl.dart';

class BokinConverted{
  static String getDate(DateTime date){
    return DateFormat.yMd().format(date);
  }
  static String getDay(int day){
    switch(day){
      case 1:
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'Sex';
      case 6:
        return 'Sab';
      case 7:
        return 'Dom';
      default:
        return 'Dom';
    }
  }
  static String getTime(int time){
    switch (time){
      case 0:
        return '9:00 AM';
      case 1:
        return '10:00 AM';
      case 2:
        return '11:00 AM';
      case 3:
        return '12:00 PM';
      case 4:
        return '13:00 PM';
      case 5:
        return '14:00 PM';
      case 6:
        return '15:00 PM';
      case 7:
        return '16:00 PM';
      default:
        return '9:00 AM';
    }
  }
}