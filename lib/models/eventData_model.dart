import 'package:event_discovery/helper/events.dart';

class EventDataModel {
  String eventname;
  String location;
  String has_tickets;
  String ticket_url;
  String event_url;
  String city;
  String thumb_url;
  String start_time_display;
  String end_time_display;
  String full_address;
  String name;
  List<EventCategoryModel>categories;

  EventDataModel({
    this.eventname,
    this.location,
    this.city,
    this.end_time_display,
    this.event_url,
    this.has_tickets,
    this.start_time_display,
    this.thumb_url,
    this.ticket_url,
    this.full_address,
    this.categories,
    this.name,
  });
}

class EventCategoryModel {
  String categories;
  EventCategoryModel({this.categories});
}