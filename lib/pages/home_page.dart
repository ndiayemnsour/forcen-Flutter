import 'package:flutter/material.dart';

//home page
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Text("Bienvenue dans le programme FORCEN !",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto_Condensed',
                color: Colors.black
            ),
            textAlign: TextAlign.center,

          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text("C’est un programme dédié au développement de l’emploi et de l’employabilité des jeunes dans le numérique au Sénégal."
              " Il s’agit donc d’un programme innovant et structurant qui allie à la fois la formation, l’insertion professionnelle,"
              " l’entrepreneuriat dans le numérique, et qui assure également la promotion de la culture scientifique et de la culture numérique. "
              "Les activités du Programme FORCE-N seront déroulées sur cinq ans (2022-2026).",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto_Condensed',
                color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text("Formez-vous gratuitement",
            style: TextStyle(
              fontSize: 25,
              color: Colors.orange,
              fontFamily: 'Roboto_Condensed',

            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),

        ],
      ),
    );
  }
}