import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/model/news_channel_headline_model.dart';
import 'package:my_news_app/page/category_screen.dart';
import 'package:my_news_app/page/detailsscreen.dart';
import 'package:my_news_app/view_model/news_view_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
enum FilterList{TheVerge, wired, BusinessInsider }
class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'business-insider';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryScreen()));
          },
          icon: Image.asset("asset/image/category.png",height: 25,width: 25,),
        ),
        centerTitle: true,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text("News App",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 21
        ),),
        actions: [
          PopupMenuButton<FilterList>(
            icon: Icon(CupertinoIcons.ellipsis_vertical),
            onSelected: (FilterList item){
              if( FilterList.BusinessInsider.name == item.name){
                name = ' business-insider';
              }
              if( FilterList.wired.name == item.name){
                name = ' wired';
              }
              if( FilterList.TheVerge.name == item.name){
                name = ' the-verge';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
                PopupMenuItem(
                  value: FilterList.wired!,
                  child: Text("wired"),
                ),
                PopupMenuItem(
                  value: FilterList.BusinessInsider!,
                  child: Text("BusinessInsider"),
                ),
                PopupMenuItem(
                  value: FilterList.TheVerge!,
                  child: Text("TheVerge"),
                )
              ]
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * .55,
            width: size.width,
            child: FutureBuilder<NewsChannelHeadlineModel>(
              future: newsViewModel.fetchNewsCjannelHedaline(name),
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
                    scrollDirection: Axis.horizontal,
                    itemCount:  snapshot.data!.articles!.length,
                      itemBuilder: (context,index){
                     final  dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return

                          SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailsScreen(
                                  nAuthor: snapshot.data!.articles![index].author.toString(),
                                  nContent: snapshot.data!.articles![index].content.toString(),
                                  nDate: snapshot.data!.articles![index].publishedAt.toString(),
                                  nDescription: snapshot.data!.articles![index].description.toString(),
                                  nImage: snapshot.data!.articles![index].urlToImage.toString(),
                                  nSource: snapshot.data!.articles![index].source!.name.toString(),
                                  nTitle: snapshot.data!.articles![index].title.toString(),
                                )));
                              },child:
                              Container(
                                height : size.height * 0.5,
                                width: size.width * 1,
                                padding: EdgeInsets.symmetric(horizontal: size.width* 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context ,url)=>Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url ,error)=> Text("Image not found"),

                                  ),
                                )
                              ),),
                           Positioned(
                               bottom: 23,
                               child:    Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15),
                             ),
                             child: Container(
                               height: size.height * 0.18,
                               alignment: Alignment.bottomCenter,
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [

                                   Container(
                                       width: size.width * 0.7,
                                       child: Center(
                                         child: Text(snapshot.data!.articles![index].title.toString(),style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 17,
                                             color: Colors.black45
                                         ),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           textAlign: TextAlign.center,
                                         ),
                                       )
                                   ),
                                   Spacer(),
                                   Container(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(snapshot.data!.articles![index].source!.name.toString(),style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 17,
                                             color: Colors.black45
                                         ),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           textAlign: TextAlign.center,
                                         ),
                                         SizedBox(width: 30,),
                                         Text(format.format(dateTime),style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 17,
                                             color: Colors.black45
                                         ),
                                           maxLines: 2,
                                           overflow: TextOverflow.ellipsis,
                                           textAlign: TextAlign.center,
                                         ),
                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ))
                            ],
                          ),
                        );
                      }
                  );
                }
              },

            ),

          ),

        ],
      ),
    );
  }
}
const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
