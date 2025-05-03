
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String confName;
  final Timestamp beginDate;
  final Timestamp signDateEnd;
  final Timestamp endDate;
  final Int duree;
  final String avatar;
  final String status;

  Event({
    required this.confName,
    required this.beginDate,
    required this.duree,
    required this.avatar,
    required this.endDate,
    required this.signDateEnd,
    required this.status

  });

  factory Event.fromData(dynamic data){
    return Event(
      confName: data['certifName'],
      beginDate: data['certifBeginDate'],
      signDateEnd: data['signupDate'],
      endDate: data['endDate'],
      duree: data['duration'],
      avatar: data['avatar'].toString().toLowerCase(),
      status: data['status']
    );
  }

}