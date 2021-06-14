import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../boxes/boxes.dart';
import 'package:flutter/material.dart';

import '../model/country_model.dart';

class ListComponent extends StatefulWidget {
  final CountryModel country;

  const ListComponent({Key? key, required this.country}) : super(key: key);

  @override
  _ListComponentState createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  String getStates() {
    if (widget.country.states != null) {
      return widget.country.states!.length.toString();
    } else {
      return 0.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var getCountry = widget.country;
    return Card(
      child: ExpansionTile(
        // initiallyExpanded: true,
        leading: Text(
          getCountry.emoji.toString(),
          style: TextStyle(fontSize: 30),
        ),
        title: Text(
          getCountry.code.toString(),
        ),
        subtitle: Text("Currency : " + getCountry.currency.toString(),
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        children: <Widget>[
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(height: 1.0),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Number of States : " + getStates()),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (Boxes.getFavourites()
                            .containsKey(getCountry.code)) {
                          Boxes.getFavourites().delete(getCountry.code);
                        } else {
                          Boxes.getFavourites()
                              .put(getCountry.code, getCountry);
                        }
                      });
                    },
                    child: Boxes.getFavourites().containsKey(getCountry.code)
                        ? Icon(
                            FontAwesomeIcons.solidStar,
                            color: Color(0xFFFB6F3D),
                          )
                        : Icon(FontAwesomeIcons.star, color: Color(0xFFFB6F3D)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (Boxes.getVisited().containsKey(getCountry.code)) {
                          Boxes.getVisited().delete(getCountry.code);
                        } else {
                          Boxes.getVisited().put(getCountry.code, getCountry);
                        }
                      });
                    },
                    child: Boxes.getVisited().containsKey(getCountry.code)
                        ? Icon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Color(0xFFFB6F3D),
                          )
                        : Icon(FontAwesomeIcons.paperPlane,
                            color: Color(0xFFFB6F3D)),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 15.0),
          // SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
