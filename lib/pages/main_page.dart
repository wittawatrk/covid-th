import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'data/stat.dart';
import 'package:hexcolor/hexcolor.dart';
import 'data/Timeline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

Future<Stat> fetchStat() async {
  final response = await http.get('https://covid19.th-stat.com/api/open/today');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final Stat data = Stat.map(jsonDecode(response.body));
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stat');
  }
}

Future<Timeline> fetchChart() async {
  final response =
      await http.get('https://covid19.th-stat.com/api/open/timeline');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final Timeline data = Timeline.fromJsonMap(jsonDecode(response.body));
    data.Data = data.Data.where((item) => item.Confirmed >= 100).toList();
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load stat');
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<Stat> futureStat;
  Future<Timeline> futureChart;
  List<Map<String, Object>> _data1 = [
    {'name': 'Please wait', 'value': 0}
  ];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

//  fetchChart() async {
//    final response =
//        await http.get('https://covid19.th-stat.com/api/open/timeline');
//    List<Map<String, Object>> dataObj;
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      // then parse the JSON.
//      final ChartTimeline data = ChartTimeline.map(jsonDecode(response.body));
////      data.Data.forEach((item) => dataObj.add(
////          {'name': item.Date.toString(), 'value': item.Confirmed.toDouble()}));
//      dataObj.add({'name': 'joke', 'value': 20});
//      dataObj.add({'name': 'janke', 'value': 25});
//      print(dataObj);
//      this.setState(() {
//        this._data1 = dataObj;
//      });
//    }
//  }

  Material myTextItems(String title, String subtitle, String add) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Hexcolor('#000000'),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                    child: Text(
                      subtitle.trim(),
                      textAlign: TextAlign.right,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                          fontSize: 48.0,
                          wordSpacing: 0.0,
                          letterSpacing: 2.0,
                          height: 1.2),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_upward,
                                color: title == 'กลับบ้านแล้ว'
                                    ? Colors.green
                                    : Colors.red,
                                size: 12.0,
                              ),
                              Text(
                                add,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: title == 'กลับบ้านแล้ว'
                                        ? Colors.green
                                        : Colors.red,
                                    height: 1.1),
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myTextBigItems(String title, String subtitle, Stat data) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Hexcolor('#000000'),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            subtitle,
                            style: TextStyle(fontSize: 48.0, height: 1.0),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                                size: 24.0,
                              ),
                              Text(
                                data.NewConfirmed.toString(),
                                style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.red,
                                    height: 1.2),
                              ),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                        width: 300, height: 250, child: Echarts(option: '''
                {
                
                        tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
    },
    legend: {
        orient: 'vertical',
        left: 10,
        data: [ 'กลับบ้านแล้ว','เสียชิวิต','อยู่ในโรงพยาบาล'],
    },
    series: [
        {
            name: 'สัดส่วนผู้ติดเชื้อ',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '24',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
            {value: ${data.Deaths}, name: 'เสียชิวิต'},
                {value: ${data.Hospitalized}, name: 'อยู่ในโรงพยาบาล'},
                {value: ${data.Recovered}, name: 'กลับบ้านแล้ว'},
                
            ]
        }
    ]}
                  
                  ''', extraScript: '''
                    chart.on('click', (params) => {
                      if(params.componentType === 'series') {
                        Messager.postMessage(JSON.stringify({
                          type: 'select',
                          payload: params.dataIndex,
                        }));
                      }
                    });
                  ''')),
                  ),
//                  Padding(
//                      padding: EdgeInsets.all(0.0),
//                      child: Column(
//                        children: <Widget>[
//                          Text(
//                            subtitle,
//                            style: TextStyle(fontSize: 48.0, height: 1.0),
//                          ),
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            children: <Widget>[
//                              Icon(
//                                Icons.arrow_upward,
//                                color: Colors.red,
//                                size: 24.0,
//                              ),
//                              Text(
//                                data.NewConfirmed.toString(),
//                                style: TextStyle(
//                                    fontSize: 24.0,
//                                    color: Colors.red,
//                                    height: 1.2),
//                              ),
//                            ],
//                          )
//                        ],
//                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myTextBigItems2(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Hexcolor('#000000'),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                        width: 300,
                        height: 250,
                        child: FutureBuilder<Timeline>(
                          future: futureChart,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Echarts(option: '''
                {
                 dataset: {
                        dimensions: ['Date','NewConfirmed','NewRecovered','NewDeaths'],
                        source: ${jsonEncode(snapshot.data.Data)},
                      },
                       legend: {
                          data: ['ผู้ติดเชื้อ', 'รักษาหาย','เสียชิวิต',],
                          show:true,
                          left: '9%',
                          right: '0%',
                          top: '0%',
                        },
                       xAxis: {
                     type: 'category',
                     show:false
                    },
                   yAxis: {
                 type: 'value',
                 min:0
                    },
                     grid: {
                        left: '0%',
                        right: '0%',
                        bottom: '5%',
                        top: '7%',
                        height: '85%',
                        containLabel: true,
                        z: 22,
                      },
              series: [
                     {
                     name:'ผู้ติดเชื้อ',
                     type: 'line',
                     smooth: 0.2,
            symbol: 'none',
                     },
                     {
                     name:'รักษาหาย',
                     type: 'line',
                    smooth: 0.2,
            symbol: 'none',
                     },
                     {
                      name:'เสียชิวิต',
                    
                     type: 'line',
                    smooth: 0.2,
            symbol: 'none',
                     }]}
                  
                  ''', extraScript: '''
                    chart.on('click', (params) => {
                      if(params.componentType === 'series') {
                        Messager.postMessage(JSON.stringify({
                          type: 'select',
                          payload: params.dataIndex,
                        }));
                      }
                    });
                  ''');
                            } else if (snapshot.hasError) {
                              throw snapshot.error;
                            } else {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    CircularProgressIndicator()
                                  ],
                                ),
                              );
                            }
                          },
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureStat = fetchStat();
    futureChart = fetchChart();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 2.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.report,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text('Covid Thailand',
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 30.0)),
              ],
            )),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return fetchStat();
          },
          child: Container(
            color: Color(0xffE5E5E5),
            child: FutureBuilder<Stat>(
              future: futureStat,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StaggeredGridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myTextBigItems("จำนวนผู้ติดเชื้อ",
                            snapshot.data.Confirmed.toString(), snapshot.data),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: myTextItems(
                            "กลับบ้านแล้ว",
                            snapshot.data.Recovered.toString(),
                            snapshot.data.NewRecovered.toString().trim()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: myTextItems(
                            "เสียชีวิต",
                            snapshot.data.Deaths.toString(),
                            snapshot.data.NewDeaths.toString().trim()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myTextBigItems2("อัตราการเพิ่ม"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,4.0),
                        child: Text("อัพเดทล่าสุด ${snapshot.data.UpdateDate.toString()}",textAlign: TextAlign.right,),
                      ),
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(4, 400.0),
                      StaggeredTile.extent(2, 120.0),
                      StaggeredTile.extent(2, 120.0),
                      StaggeredTile.extent(4, 350.0),
                      StaggeredTile.fit(4),
                    ],
                  );
                } else if (snapshot.hasError) {
                  throw snapshot.error;
                } else {
                  return Center(
                    child: Column(
                      children: <Widget>[CircularProgressIndicator()],
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
