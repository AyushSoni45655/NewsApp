import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../model/news_channel_headline_model.dart';
import '../view_model/news_view_model.dart';
import 'homepage.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd,');
  String categoryName = 'general';
  List<String> categoriesList = [
    "General",
    "Health",
    "Comedy",
    "Sports",
    "Entertainment",
    "Business",
    "Technology"
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading:  InkWell( onTap:(){
            Navigator.pop(context);
          },child:Icon(CupertinoIcons.arrow_left)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      // ignore: avoid_unnecessary_containers
                      return InkWell(
                        onTap: (){
                          categoryName = categoriesList[index];
                          setState(() {
                            
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: categoryName == categoriesList[index] ? Colors.blue: Colors.grey
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child:  Center(
                                    child: Text(categoriesList[index].toString(),style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),),),
                                )
                            )),
                      );
                    }),
              ),
              Expanded(
                child:FutureBuilder<NewsChannelHeadlineModel>(
                future: newsViewModel.fetchNewsCjannelHedaline(categoryName),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:  snapshot.data!.articles!.length,
                        itemBuilder: (context,index){
                          final  dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return  Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(

                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),height: size.height * .3,width: size.width *.4,
                                  fit: BoxFit.cover,
                                  placeholder: (context ,url)=>Container(
                                    child: spinkit2,
                                  ),
                                  errorWidget: (context, url ,error)=> Center(child:Text("Image not found")),


                                ),) 
                              ),
                            Expanded(
                                child:
                            Column(
                              children: [
                                Text(snapshot.data!.articles![index].title.toString(),style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),),
                                SizedBox(height: size.height / 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(snapshot.data!.articles![index].source!.name.toString(),style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black45
                                    ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 30,),
                                    Text(format.format(dateTime),style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black45
                                    ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              ],
                            ))
                            
                          ],
                        );
                        }
                    );
                  }
                },

              ),
              )
            ],
          ),
        ));
  }
}
