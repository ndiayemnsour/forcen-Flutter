import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forcen/models/event_model.dart';
import 'package:intl/intl.dart';

//Page Evenement
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    //Alert dialog
    Future<void> showEventDetails(Event eventData) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text('Certification : ${eventData.confName}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto_Condensed',

              ),),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                 children: <Widget>[
                  Image.asset("assets/images/${eventData.avatar}.png", height: 50,),
                  Text("Durée de la formation : ${eventData.duree} jours"),
                  Text("Date Fin d'inscription : ${DateFormat('dd/MM/yyyy').format(eventData.signDateEnd.toDate())}"),
                  Text("la formation est ${eventData.status}"),
                ],
              ),
            ),
            actions: <Widget>[

              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              TextButton(
                  onPressed: (){

                  },
                  child: Text("Postuler")),

            ],
          );
        },
      );
    }

    return  Center(
      child: StreamBuilder(
              stream:FirebaseFirestore.instance.collection('events').snapshots(),// orderBy('certifName') where('status', isEqualTo: 'Payant') option filtre
              builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text("Aucun èvènement trouver dans la base de données");
                }

                List<Event> events = [];
                for (var data in snapshot.data!.docs) {
                    events.add(Event.fromData(data));
              }

                return ListView.builder( //ListView.builder nous permet de gener dynamiquement les cards avce les contenus
                    itemCount: events.length,
                    itemBuilder: (context, index){
                      final event = events[index];
                      final avatar = event.avatar;
                      final duration = event.duree;
                      final Timestamp timestamp = event.beginDate;
                      final String beginDate = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
                      final Timestamp timestampSign = event.signDateEnd;
                      final String inscriptionDate = DateFormat('dd/MM/yyyy').format(timestampSign.toDate());
                      final nameFormation = event.confName;
                      final statut = event.status;

                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset("assets/images/$avatar.png",
                            width: 90,),
                          title: Text('$nameFormation ($statut - $duration jours)  '),
                          subtitle: Text("Fin d'inscription : $inscriptionDate \nDébut de formation : $beginDate"),
                          trailing: IconButton(
                              onPressed: (){showEventDetails(event);},
                              icon: Icon(Icons.info, color: Colors.blue)
                          ),

                        ),

                      );
                    },

                );
              }

    )
  );
  }
}