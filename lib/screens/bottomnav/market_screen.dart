

import 'package:flutter/material.dart';
import 'package:heroServiceApp/models/NewsModel.dart';
import 'package:heroServiceApp/services/rest_api.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  future: CallAPI().getLastNews(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewsModel>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('มีข้อผิดพลาด ${snapshot.error.toString()}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      List<NewsModel> news = snapshot.data;
                      return _listLastViewNews(news);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              // ],
              ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
            child: Text(
              'ข่าวประกาศทั้งหมด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            child: FutureBuilder(
                future: CallAPI().getAllNews(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NewsModel>> snapshot) {
                  if (snapshot.hasError) {
                    return Text('มีข้อผิดพลาด ${snapshot.error.toString()}');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<NewsModel> news = snapshot.data;
                    return _listViewAllNews(news);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _listLastViewNews(List<NewsModel> news) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index) {
        NewsModel newsModel = news[index];
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          // height: MediaQuery.of(context).size.height * 0.3,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/newsdetail',
                  arguments: {'id': newsModel.id});
            },
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

  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: news.length,
      itemBuilder: (context, index) {
        NewsModel newsModel = news[index];
        return ListTile(
          leading: Icon(Icons.pages),
          title: Text(
            newsModel.topic,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            _launchInBrowser(newsModel.linkurl);
          },
        );
      },
    );
  }

  // ฟังก์ชันสำหรับการ Launcher Web Screen
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Could not launch $url';
    }
  }
}
