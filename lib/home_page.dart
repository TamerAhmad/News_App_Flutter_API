import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'news.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color mainColor = Color(0xff192028);
  Color secondColor = Color(0xff272d39);
  bool loading;
  var newsList;

  void getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      loading = false;
      newsList = news.news;
    });
  }

  @override
  void initState() {
    loading = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: secondColor,
          leading: Icon(Icons.menu),
          title: Text('News App Audioable'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: loading
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    width: 200.0,
                    height: 200.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Loading News")
                      ],
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Top Headlines",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: ListView.builder(
                          itemCount: newsList.take(10).length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 220,
                                      decoration: BoxDecoration(

                                        image: DecorationImage(
                                            image: NetworkImage(
                                                newsList[index].urlToImage),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 220.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        gradient: LinearGradient(
                                            colors: [
                                              mainColor.withOpacity(1.0),
                                              mainColor.withOpacity(0.0),
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            stops: [0.0, 0.9]),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                DateFormat.yMMMMd("en_US")
                                                    .format(newsList[index]
                                                        .publishedAt),
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              Text(
                                                newsList[index].title,
                                                style: TextStyle(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
