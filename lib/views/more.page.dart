import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/hotel.dart';
import 'img.widget.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool isLoading = false;
  Dio _dio = Dio();
  List<HotelPreview> objectData;
  CarouselController buttonCarouselController = CarouselController();

  Future<Map<String, dynamic>> getMore(String uuid) async {
    setState(() {
      isLoading = true;
    });
    try {
      final responce = await _dio.get('https://run.mocky.io/v3/$uuid');
      return responce.data;
    } catch (e) {
      return e;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <dynamic, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(title: Text('${arguments['name']}')),
      body: FutureBuilder<dynamic>(
          future: getMore(arguments['uuid']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<dynamic> imageList = snapshot.data['photos'];
              final List<dynamic> freeList = snapshot.data['services']['free'];
              final List<dynamic> paidList = snapshot.data['services']['paid'];
              return Column(
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                      ),
                      items: imageList.map((item) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          child: Image.asset('assets/images/$item',
                              fit: BoxFit.cover, width: 1000.0),
                        );
                      }).toList()),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Страна: '),
                            Text(
                              '${snapshot.data['address']['country']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Город: '),
                            Text(
                              '${snapshot.data['address']['city']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Улица: '),
                            Text(
                              '${snapshot.data['address']['street']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('Рейтинг: '),
                            Text(
                              '${snapshot.data['rating']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сервисы',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Платные',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Бесплатные',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: paidList.length,
                                itemBuilder: (context, i) {
                                  return Text(paidList[i].toString());
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: freeList.length,
                                itemBuilder: (context, i) {
                                  return Text(freeList[i].toString());
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Контент временно недоступен'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
