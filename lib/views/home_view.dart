import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hotels/views/more.page.dart';

import '../models/hotel.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Dio _dio = Dio();

  bool isLoading = false;
  List<HotelPreview> objectData;
  bool listView = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final responce = await _dio
          .get('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301');
      objectData = responce.data
          .map<HotelPreview>((object) => HotelPreview.fromJson(object))
          .toList();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  listView = true;
                });
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                setState(() {
                  listView = false;
                });
              },
              icon: Icon(Icons.grid_view)),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : listView
              ? ListView.builder(
                  itemCount: objectData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3.0,
                      color: Colors.white,
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 190.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/${objectData[index].poster}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${objectData[index].name}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                ElevatedButton(
                                  onPressed: () {

                                    Navigator.pushNamed(
                                      context,
                                      '/more',
                                      arguments: {
                                        'uuid': objectData[index].uuid,
                                        'name': objectData[index].name,
                                      },
                                    );
                                  },
                                  child: Text('Подробнее'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6),
                      itemCount: objectData.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.maxFinite,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/${objectData[index].poster}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  '${objectData[index].name}',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Подробнее"),
                                  style: ElevatedButton.styleFrom(
                                    // primary: Colors.pink,
                                    fixedSize: const Size(300, 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
    );
  }
}
