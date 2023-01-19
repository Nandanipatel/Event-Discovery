import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_discovery/helper/data.dart';
import 'package:event_discovery/helper/events.dart';
import 'package:event_discovery/models/category_model.dart';
import 'package:event_discovery/models/eventData_model.dart';
import 'package:event_discovery/views/category.dart';
import 'package:event_discovery/views/detail_view.dart';
import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<EventDataModel> events = new List<EventDataModel>();
  List<EventCategoryModel> eventCategories = new List<EventCategoryModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getEvents();
  }

  getEvents() async {
    Events eventsClass = Events();
    await eventsClass.getEvent();
    events = eventsClass.event;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("All", style: TextStyle(color: Colors.white)),
                Text(
                  "Events.in",
                  style: TextStyle(color: Colors.white),
                )
              ]),
          centerTitle: true,
          elevation: 0.0,
        ),
        body:
            //  loading shows while fetching data
            _loading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                :

                // main body of application
                SingleChildScrollView(
                    child: Container(
                      child: Column(children: <Widget>[
                        // categories
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: EdgeInsets.only(top: 16),
                          height: 70,
                          child: ListView.builder(
                              itemCount: categories.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CategorieTile(
                                  imageUrl: categories[index].imageUrl,
                                  CategoryName: categories[index].categoryName,
                                );
                              }),
                        ),

                        // events
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          margin: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                              itemCount: events.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              // scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 236, 234, 234),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: EventTile(
                                    imageUrl: events[index].thumb_url,
                                    title: events[index].eventname,
                                    location: events[index].location,
                                    start_time_display:
                                        events[index].start_time_display,
                                    end_time_display:
                                        events[index].end_time_display,
                                    full_address: events[index].full_address,
                                    event_url: events[index].event_url,
                                    name: events[index].name,
                                    city: events[index].city,
                                  ),
                                );
                              }),
                          // child: FlatList(
                          //   data: [events],
                          //   buildItem: (item, index) {
                          //     var imageUrl = events[index].thumb_url;
                          //     var title = events[index].eventname;
                          //     var location = events[index].location;
                          //     var start_time_display =
                          //         events[index].start_time_display;
                          //     var end_time_display =
                          //         events[index].end_time_display;
                          //     var full_address = events[index].full_address;
                          //     var event_url = events[index].event_url;
                          //     var name = events[index].name;
                          //     var city = events[index].city;
                          //     return Container(
                          //       margin: EdgeInsets.only(
                          //           left: 16, right: 16, bottom: 16),
                          //       decoration: BoxDecoration(
                          //         color: Color.fromARGB(255, 236, 234, 234),
                          //         borderRadius: BorderRadius.circular(6),
                          //       ),
                          //       child: EventTile(
                          //         imageUrl: imageUrl,
                          //         title: title,
                          //         location: location,
                          //         start_time_display: start_time_display,
                          //         end_time_display: end_time_display,
                          //         full_address: full_address,
                          //         event_url: event_url,
                          //         name: name,
                          //         city: city,
                          //       ),
                          //     );
                          //   },
                          // )
                        ),
                      ]),
                    ),
                  ));
  }
}

// catgory section
class CategorieTile extends StatelessWidget {
  final imageUrl, CategoryName;
  const CategorieTile({this.imageUrl, this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                CategoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// event section
class EventTile extends StatelessWidget {
  final String imageUrl,
      title,
      location,
      start_time_display,
      end_time_display,
      event_url,
      categories,
      full_address,
      city,
      name;

  const EventTile({
    @required this.imageUrl,
    @required this.title,
    @required this.location,
    @required this.end_time_display,
    @required this.full_address,
    @required this.start_time_display,
    @required this.event_url,
    @required this.categories,
    @required this.name,
    @required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailView(
                      event_url: event_url,
                    )));
      },
    
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 350,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(title ?? 'default value',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 6,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Location: ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(221, 31, 30, 30),
                            fontWeight: FontWeight.w500)),
                    Text(location ?? 'default value',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(221, 78, 74, 74),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Starting at: ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(221, 31, 30, 30),
                            fontWeight: FontWeight.w500)),
                    Text(start_time_display ?? 'default value',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(221, 78, 74, 74),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ending at: ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(221, 45, 46, 47),
                            fontWeight: FontWeight.w500)),
                    Text(end_time_display ?? 'default value',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(221, 78, 74, 74),
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          Text(full_address ?? ''),
        ]),
      ),
    );
  }
}
