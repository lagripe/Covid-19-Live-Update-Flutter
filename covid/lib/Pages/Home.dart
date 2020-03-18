import 'package:covid/Components/InfoCard.dart';
import 'package:covid/Config/Classes.dart';
import 'package:covid/Config/Manager.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  SortType _type = SortType.country;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController
        .addListener(() => setState(() => _index = _tabController.index));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text('Covid-19 Live Update'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Container(),
      ),
      body: _index == 0 ? globalStream() : countryFuture(context),
      bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.red[700],
          indicatorColor: Colors.transparent,
          controller: _tabController,
          tabs: [
            Tab(
              text: "GLOBAL",
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "COUNTRIES",
              icon: Icon(Icons.flag),
            )
          ]),
    );
  }

  globalList(Global info) => ListView(
        children: <Widget>[
          InfoCard(
            header: "CASES",
            stat: info.cases.toString(),
            color: Colors.grey[400],
          ),
          InfoCard(
            header: "DEATHS",
            stat: info.deaths.toString(),
            color: Colors.red[800],
          ),
          InfoCard(
            header: "RECOVERED",
            stat: info.recovered.toString(),
            color: Colors.green[400],
          ),
        ],
      );

  globalStream() => StreamBuilder(
        stream: Stream.periodic(
          Duration(seconds: 1),
        ).asyncMap((i) => Manager.getGlobal()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: globalList(snapshot.data as Global),
            );
          } else {
            if (snapshot.hasError)
              return Container();
            else
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[900]),
                    ),
                    SizedBox(height: 8),
                    Text("Loading...", style: TextStyle(color: Colors.red[900]))
                  ],
                ),
              );
          }
        },
      );
  countriesList(List<Country> countries, BuildContext context) =>
      SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 70,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Sort",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Proxima",
                        fontSize: 18),
                  ),
                ),
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: SortType.values.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: InkWell(
                        onTap: () =>
                            setState(() => _type = SortType.values[index]),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(10)),
                          width: 120,
                          child: Center(
                              child: Text(
                                  SortType.values[index]
                                      .toString()
                                      .split('.')[1],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Proxima",
                                      fontSize: 18))),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (context, index) => ExpansionTile(
                backgroundColor: Colors.grey[400],
                title: Text(
                  countries[index].country,
                  style: TextStyle(color: Colors.white, fontFamily: "Proxima"),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: getExpansionTileRows(
                          countries[index].getDumpedInfo()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ));

  countryFuture(BuildContext context) => FutureBuilder(
        future: Manager.getCountries(_type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: countriesList(snapshot.data as List<Country>, context),
            );
          } else {
            if (snapshot.hasError)
              return Container();
            else
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.red[900]),
                    ),
                    SizedBox(height: 8),
                    Text("Loading...", style: TextStyle(color: Colors.red[900]))
                  ],
                ),
              );
          }
        },
      );

  getExpansionTileRows(Map<String, dynamic> data) {
    List<TableRow> rows = [];
    data.keys.forEach((e) => rows.add(TableRow(children: [
          Text(
            e,
            style: TextStyle(
                color: Colors.black, fontFamily: "Proxima", fontSize: 16),
          ),
          Text(
            data[e].toString(),
            style: TextStyle(
                color: Colors.black, fontFamily: "Proxima", fontSize: 16),
          ),
        ])));
    return rows;
  }
}
