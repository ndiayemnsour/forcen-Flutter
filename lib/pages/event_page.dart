import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

    Future<void> showEventDetails() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Force-N'),
            content: SingleChildScrollView(
              child: ListBody(
                 children: <Widget>[
                  Image.asset("assets/images/logo.png"),
                  Text('sa eleeg ci xarale yi'),
                  Text('Un programme financer par mastercard'),
                  Text('Formez vous gratuitement'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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

                List<dynamic> events = [];
                snapshot.data!.docs.forEach((element){
                    events.add(element);
              });

                return ListView.builder( //ListView.builder nous permet de gener dynamiquement les cards avce les contenus
                    itemCount: events.length,
                    itemBuilder: (context, index){
                      final event = events[index];
                      final avatar = event["avatar"].toString().toLowerCase();
                      final duration = event["duration"];
                      final Timestamp timestamp = event["certifBeginDate"];
                      final String beginDate = DateFormat('dd/MM/yyyy').format(timestamp.toDate());
                      final Timestamp timestampSign = event["signupDate"];
                      final String inscriptionDate = DateFormat('dd/MM/yyyy').format(timestampSign.toDate());
                      final nameFormation = event['certifName'];
                      final statut = event['status'];

                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset("assets/images/$avatar.png",
                            width: 90,),
                          title: Text('$nameFormation ($statut - $duration jours)  '),
                          subtitle: Text("Fin d'inscription : $inscriptionDate \nDébut de formation : $beginDate"),
                          trailing: IconButton(
                              onPressed: (){showEventDetails();},
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