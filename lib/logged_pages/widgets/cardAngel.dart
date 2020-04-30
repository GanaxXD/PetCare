import 'package:flutter/material.dart';

class CardAngel extends StatelessWidget {

  String angel, objective, place, medicine;
  CardAngel({this.angel, this.objective, this.place, this.medicine});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 150,
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          borderOnForeground: true,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.favorite, color: Colors.orange, size: 40,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top:0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(this.angel.length > 20 ? this.angel.substring(0,20) + "..." : this.angel,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 22,
                        fontWeight: FontWeight.w600
                      ), overflow: TextOverflow.ellipsis,),

                    Text(this.objective.length > 30 ? this.objective.substring(0,30) + "...": this.objective,
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 16,
                      ), overflow: TextOverflow.ellipsis, maxLines: 1,),

                    Text(this.medicine.length>30? this.medicine.substring(0,30) + "..." : this.medicine, style: TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                    ), overflow: TextOverflow.ellipsis, maxLines: 1,),

                   Text(this.place.length>30? this.place.substring(0, 30)+"...": this.place, style: TextStyle(
                            color: Colors.black26,
                            fontSize: 16,
                          ),
                            overflow: TextOverflow.ellipsis, maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
