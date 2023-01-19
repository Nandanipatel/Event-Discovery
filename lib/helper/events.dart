import 'dart:convert';
import '../models/eventData_model.dart';
import 'package:http/http.dart' as http;

class Events {
  List<EventDataModel> event = [];

  Future<void> getEvent() async {
    var headers = {
      'Ocp-Apim-Subscription-Key': '183c372d254c411b89d581cb297d7771',
      'sortDescription': '1'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.allevents.in/events/list'));

    request.fields.addAll({
      'city': 'London',
      'state': 'EN',
      'country': 'United Kingdom',
      'shortDesc': '1',
      // 'category': 'entertainment'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var jsonData = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      jsonData["data"].forEach((element) {
        if (element["thumb_url"] != null && element["eventname"] != null) {
          EventDataModel eventDataModel = EventDataModel(
          
            eventname: element["eventname"],
            thumb_url: element["thumb_url"],
            location: element["location"],
            city: element["venue.city"],
            start_time_display: element["start_time_display"],
            end_time_display: element["end_time_display"],
            event_url: element["event_url"],
            has_tickets: element["has_tickets"],
            ticket_url: element["tickets.ticket_url"],
            // categories: element["categories"],
          );
          event.add(eventDataModel);
          // print(jsonData);
        } else {
          print(response.reasonPhrase);
        }
      });
    }
  }
}

// class CategoryEvents {
//   List<EventCategoryModel> eventCategories = [];

//   Future<void> getEventCategories(String Category) async {
//     var headers = {
//       'Ocp-Apim-Subscription-Key': '183c372d254c411b89d581cb297d7771',
//       'sortDescription': '1'
//     };
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('https://api.allevents.in/events/list'));

//     request.fields.addAll({
//       'city': 'London',
//       'state': 'EN',
//       'country': 'United Kingdom',
//       'shortDesc': '1',
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     var jsonData = jsonDecode(await response.stream.bytesToString());

//     if (response.statusCode == 200) {
//       jsonData["data"].forEach((element) {
//         if (element["thumb_url"] != null && element["eventname"] != null) {
//           EventDataModel eventDataModel = EventDataModel(
           
//             // categories: element["categories"],
//           );

//           eventCategories.add(EventCategoryModel);
//         } else {
//           print(response.reasonPhrase);
//         }
//       });
//       jsonData["categories"].forEach((element) {
//         if (element["categories"] != null) {
//           EventDataModel eventDataModel = EventDataModel(
//             categories: element["categories"],
//           );
//           eventCategories.add(EventCategoryModel);
//         } else {
//           print(response.reasonPhrase);
//         }
//       });
//       jsonData["organizer"].forEach((element) {
//         if (element["name"] != null) {
//           EventDataModel eventDataModel = EventDataModel(
//             name: element["name"],
//           );
//           eventCategories.add(EventCategoryModel);
//         } else {
//           print(response.reasonPhrase);
//         }
//       });
//     }
//   }
// }
