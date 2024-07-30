import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
class DetailsScreen extends StatefulWidget {
   DetailsScreen({
    required this.nAuthor,
    required this.nContent,
    required this.nDate,
    required this.nDescription,
    required this.nImage,
    required this.nSource,
    required this.nTitle
});
  String nTitle,nDescription,nImage,nAuthor,nContent,nSource,nDate;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final format = DateFormat('MMMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final  dateTime = DateTime.parse(widget.nDate);
    return Scaffold(
     
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child:Icon(CupertinoIcons.arrow_left,size: 30,color: Colors.black,)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:
              Container(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * .5,
                      width: size.width,
                      decoration: BoxDecoration(
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.nImage,
                          fit: BoxFit.cover,
                          placeholder: (context ,url)=>Container(
                            child: SpinKitCircle(
                              color: Colors.blue,
                            ),
                          ),
                          errorWidget: (context, url ,error)=> Text("Image not found"),

                        ),
                      ),
                    ),
                    Positioned(
                        top: size.height *0.4,
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0)
                            ),
                              color: Colors.grey
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 20),
                            child: Column(
                              children: [
                                Text(widget.nTitle,style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),
                                  textAlign: TextAlign.justify,
                                ),
                                Divider(endIndent: 20,indent: 20,color: Colors.blue,thickness: 2,height: 50,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.nSource,style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                    ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(format.format(dateTime),style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                    ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  widget.nContent,style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                ),
                                SizedBox(height: 20,),
                                Center(child: Text(widget.nAuthor,style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),),)
                              ],
                            ),
                          )
                        ))
                  ],
                ),
              )


        ),
      ),
    );
  }
}
