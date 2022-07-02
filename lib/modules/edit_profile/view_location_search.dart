import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';
import 'dart:convert';


import '../../utils/colors.dart';
import 'places_services.dart';

class PlacesAutoComplete extends StatefulWidget {
  const PlacesAutoComplete({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PlacesAutoCompleteState createState() => _PlacesAutoCompleteState();
}

class _PlacesAutoCompleteState extends State<PlacesAutoComplete> {
  final _controller = TextEditingController();
  final String _streetNumber = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  saveData({String? latLong, String? place}) async {
    // var data = await json.decode(instance.getString('latlong'));
    log("LatLong--->>> $latLong");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'Get Restaurant location',
          style: TextStyle(color: Colors.blue[900]),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              readOnly: true,
              onTap: () async {
                // generate a new token here
                final sessionToken = const Uuid().v4();
                final Suggestion? result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );

                log('RESULT---->>>${result!.description.toString().split(', ')[2]}');
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);

                  await saveData(
                      latLong: json.encode({
                        'lat': placeDetails['lat'],
                        'lng': placeDetails['lng']
                      }),
                      place: result.description);

                  // latlong.value =
                  //     await json.decode(await datastore.read("latlong"));
                  // print("the lat long is ${latlong.value}");
                  // print(latlong.value['lat']);

                  setState(() {
                    // datastore.write("placename", result.description);
                    // datastore.write("latlong", json.encode(placeDetails));
                  });
                }
              },
              decoration: const InputDecoration(
                icon: SizedBox(
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                hintText: "Enter your restaurant address",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
              ),
            ),
            // SizedBox(height: 20.0),
            // Text('Street Number: $_streetNumber'),
            // Text('Street: $_street'),
            // Text('City: $_city'),
            // Text('Postal Code: $_zipCode'),
          ],
        ),
      ),
    );
  }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  String? sessionToken;
  PlaceApiProvider? apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
        // close(context, Suggestion());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient!.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) => query ==
              ''
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: customThemeColor.withOpacity(0.19),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset:
                              const Offset(0, 22), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(snapshot.data![index].description),
                      onTap: () {
                        close(context, snapshot.data![index]);
                      },
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                )
              : const SizedBox(child: Text('Loading...')),
    );
  }
}
