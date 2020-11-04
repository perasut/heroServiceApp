import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heroServiceApp/models/NewsModel.dart';
import 'package:heroServiceApp/services/rest_api.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({Key key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
            child: Text(
              'ข่าวประกาศล่าสุด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: FutureBuilder(
                  future: CallAPI().getAllNews(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewsModel>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('มีข้อผิดพลาด ${snapshot.error.toString()}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      List<NewsModel> news = snapshot.data;
                      return _listViewNews(news);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              // ],
              ),
        ],
      ),
    );
  }

  Widget _listViewNews(List<NewsModel> news) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index) {
        NewsModel newsModel = news[index];
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          // height: MediaQuery.of(context).size.height * 0.3,
          child: InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 125.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(newsModel.imageurl),
                              fit: BoxFit.fitHeight,
                              alignment: Alignment.topCenter)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            newsModel.topic,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            newsModel.detail,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _listViewNews(List<NewsModel> news) {
  //   return   Int32x4.xxxx;
  // }
}
