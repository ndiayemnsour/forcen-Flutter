import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Event {
  final String confName;
  final Timestamp beginDate;
  final Timestamp signDateEnd;
  final Timestamp endDate;
  final int duree;
  final String avatar;
  final String status;
//Constructeur
  Event({
    required this.confName,
    required this.beginDate,
    required this.duree,
    required this.avatar,
    required this.endDate,
    required this.signDateEnd,
    required this.status

  });
//convertir un objet en json
  factory Event.fromData(dynamic data){
    return Event(
      confName: data['certifName'],
      beginDate: data['certifBeginDate'],
      signDateEnd: data['signupDate'],
      endDate: data['certifBeginDate'],
      duree: data['duration'],
      avatar: data['avatar'].toString().toLowerCase(),
      status: data['status']
    );
  }
  /// 🔽 Formateurs de date
  String get formattedBeginDate => DateFormat('dd MMMM yyyy', 'fr_FR').format(beginDate.toDate());
  String get formattedEndDate => DateFormat('dd MMMM yyyy', 'fr_FR').format(endDate.toDate());
  String get formattedSignDate => DateFormat('dd MMMM yyyy', 'fr_FR').format(signDateEnd.toDate());
}
