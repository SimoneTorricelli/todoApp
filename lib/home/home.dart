import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/home/add_todo.dart';
import 'package:todo/utility/widget/calendar.dart';
import 'package:todo/utility/widget/timeline.dart';

import '../model/todoModels.dart';

List<dynamic> todoList = [];
Box<dynamic> todoBox = Hive.box("Todo");

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    todoList = todoBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [Calendar(), Timeline()],
          ),
        ),
      ),
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 350),
        transitionType: ContainerTransitionType.fade,
        openBuilder: (BuildContext context, VoidCallback _) {
          return const AddTodo();
        },
        openColor: Colors.deepOrange,
        closedColor: Colors.deepOrange,
        closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            height: 50,
            width: 50,
            color: Colors.deepOrange,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
    );
  }
}
