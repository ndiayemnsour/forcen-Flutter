import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();

}

class _AddEventPageState extends State<AddEventPage> {

  //permet cibler chaque champ pour la validation
  final _formKey = GlobalKey<FormState>();
  //controller pour recuperer les donnees du formulaire
  final certifNameController = TextEditingController();
  String selectedStatut = 'Gratuit';
  DateTime? selectedDate; // Déclaration correcte de selectedDate
  DateTime? selectedDateBegin; // Déclaration correcte de selectedDate
  DateTime? selectedDateEnd; // Déclaration correcte de selectedDate


  //Dispose permet de liberer permet de degager les controller
  @override
  void dispose(){
    super.dispose();

    certifNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom formation',
                    labelStyle: TextStyle(
                      color: Colors.blue
                    ),
                    hintText: 'Entrer le nom de la formation',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue
                      )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      )
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red
                      )
                    ),


                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom de la formation';
                    }
                    return null;
                  },
                  controller: certifNameController,
                ),
              ),


              Container(
                margin:EdgeInsets.only(bottom:20),
                child: DropdownButtonFormField(
                  items : [
                    DropdownMenuItem(value: 'Gratuit', child : Text('Gratuit')),
                    DropdownMenuItem(value: 'Payant', child : Text('Payant')),
                  ],
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                  ),

                  value:selectedStatut,
                  onChanged:(value){
                    setState(() {
                      selectedStatut=value!;
                    });
                  }
                ),
              ),


              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    labelText: 'Date fin d\'inscription',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.blue,),
                  ),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  initialPickerDateTime: DateTime.now(),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDate = value != null ? DateTime(value.year, value.month, value.day) : null;;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    labelText: 'Date de debut de la formation',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.blue,),
                  ),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  initialPickerDateTime: DateTime.now(),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDateBegin = value != null ? DateTime(value.year, value.month, value.day) : null;;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue
                        )
                    ),
                    labelText: 'Date fin de formation',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today, color: Colors.blue,),
                  ),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  initialPickerDateTime: DateTime.now(),
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDateEnd = value != null ? DateTime(value.year, value.month, value.day) : null;;
                    });
                  },
                ),
              ),


              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        //permet de recuperer le text du champ
                        final certifName = certifNameController.text;

                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enregistrement effectué'))
                        );
                        FocusScope.of(context).requestFocus(FocusNode());

                        int duration = selectedDateEnd!.difference(selectedDateBegin!).inDays;
                        print('la duree: $duration');
                        //ajout des donnees events dans la base de donnees
                        FirebaseFirestore.instance.collection('events').add({
                            'certifName': certifName,
                            'status': selectedStatut,
                            'signupDate': selectedDate,
                            'certifBeginDate': selectedDateBegin,
                            'certifDoneDate': selectedDateEnd,
                            'duration': duration,
                            'avatar': 'logo'
                        });
                    }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: Text('Enrigistrer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Roboto_Condensed',
                      fontWeight: FontWeight.bold
                    ),),

                ),
              )
            ],
          )
      ),
    )
    ;
  }
}

