import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/utility/widget/timeline.dart';

import '../../home/home.dart';

DateTime selectedDate = DateTime.now(); // TO tracking date

class Calendar extends StatefulWidget {
  const Calendar();

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  List<String> listOfMonths = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  Widget build(BuildContext context) {
    ReadData readData = Provider.of<ReadData>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 0),
            child: Text(
              "${listOfMonths[selectedDate.month - 1]} ${selectedDate.day}, ${selectedDate.year}",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  fontSize: 17),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 34, vertical: 2),
            child: Text(
              "Today",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                        height: 85,
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 10);
                          },
                          itemCount: listOfDays.length,
                          //controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              key: const Key('setData'),
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.deepOrange.withOpacity(0),
                              highlightColor: Colors.deepOrange.withOpacity(0),
                              onTap: () {
                                setState(() {
                                  selectedDate =
                                      DateTime.now().add(Duration(days: index));
                                });

                                readData.setData();
                                if (currentDateSelectedIndex != index) {
                                  setState(() {
                                    currentDateSelectedIndex = index;
                                  });
                                }
                              },
                              child: Container(
                                width: 65,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      listOfDays[index].toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              currentDateSelectedIndex == index
                                                  ? Colors.deepOrange
                                                  : Colors.black45),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateTime.now()
                                          .add(Duration(days: index))
                                          .day
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              currentDateSelectedIndex == index
                                                  ? Colors.deepOrange
                                                  : Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    if (currentDateSelectedIndex == index)
                                      AnimatedContainer(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrange,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        duration:
                                            const Duration(milliseconds: 800),
                                        curve: Curves.bounceIn,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReadData with ChangeNotifier, DiagnosticableTreeMixin {
  List<dynamic> _listToday = [];

  List<dynamic>? get listToday => _listToday;

  void setData() {
    _listToday = todoList
        .where((element) =>
            element.data.toString().substring(0, 10) ==
            selectedDate.toString().substring(0, 10))
        .toList();
    notifyListeners();
  }

  List<dynamic> getData() {
    return _listToday;
  }
}
