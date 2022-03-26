import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/home.dart';
import 'package:todo/utility/widget/calendar.dart';

import '../../model/todoModels.dart';
import 'calendar.dart';

int currentSelectedIndex = 0;
List<dynamic> todoOfToday = todoList;

class Timeline extends StatefulWidget {
  Timeline();

  static State<StatefulWidget>? of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  _TimelineState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ReadData readData = Provider.of<ReadData>(context);
    List<dynamic> listOfToday = readData.listToday!;
    return Container(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListView.separated(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 0);
                    },
                    itemCount: listOfToday.length,
                    //controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          TimeLineGrafic(index, listOfToday.elementAt(index)),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 20),
                            child: ContainerTodo(
                                listOfToday.elementAt(index), index, () {
                              setState(() {
                                currentSelectedIndex = index;
                              });
                            }),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeLineGrafic extends StatelessWidget {
  final index;
  final todo;
  const TimeLineGrafic(this.index, this.todo);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == currentSelectedIndex)
          Stack(
            children: [
              AnimatedContainer(
                height: 21,
                width: 21,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50)),
                duration: const Duration(milliseconds: 800),
                curve: Curves.bounceIn,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.bounceIn,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(50)),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.bounceIn,
                  ),
                ),
              ),
            ],
          )
        else
          Stack(
            children: [
              AnimatedContainer(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50)),
                duration: const Duration(milliseconds: 800),
                curve: Curves.bounceIn,
              ),
              Positioned(
                left: 2.5,
                top: 2.5,
                child: AnimatedContainer(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.bounceIn,
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          height: todo.sottotitolo.length / 2 + 90.0,
          width: 3,
          decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(50)),
          duration: const Duration(milliseconds: 800),
          curve: Curves.bounceIn,
        ),
        const SizedBox(
          height: 10,
        ),
        if (index == todoList.length - 1)
          Stack(
            children: [
              AnimatedContainer(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50)),
                duration: const Duration(milliseconds: 800),
                curve: Curves.bounceIn,
              ),
              Positioned(
                left: 2.5,
                top: 2.5,
                child: AnimatedContainer(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.bounceIn,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class ContainerTodo extends StatefulWidget {
  final todo;
  final index;
  Function() onTap;
  ContainerTodo(this.todo, this.index, this.onTap);

  @override
  State<ContainerTodo> createState() =>
      _ContainerTodoState(this.todo, this.index, this.onTap);
}

class _ContainerTodoState extends State<ContainerTodo>
    with TickerProviderStateMixin {
  final todo;
  final index;
  Function() onTap;

  _ContainerTodoState(this.todo, this.index, this.onTap);

  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
    );

    final CurvedAnimation curve =
        CurvedAnimation(parent: controller!, curve: Curves.easeOut);

    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller?.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ReadData readData = Provider.of<ReadData>(context);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: currentSelectedIndex == index
                ? Colors.deepOrange[400]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(12, 26),
                                blurRadius: 50,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.25)),
                          ]),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          widget.todo.completato == false
                              ? Icons.check
                              : Icons.close,
                          size: 15,
                          color: Colors.deepOrangeAccent,
                        ),
                        onPressed: () {
                          var todonew = Todo(
                            titolo: widget.todo.titolo,
                            sottotitolo: widget.todo.sottotitolo,
                            id: widget.todo.id,
                            completato: !widget.todo.completato,
                            data: widget.todo.data,
                          );
                          controller?.forward(from: 0.0);
                          todoBox.putAt(widget.todo.id - 1, todonew);
                          todoList = todoBox.values.toList();
                          readData.addTodo();
                          log(widget.todo.completato.toString());
                        },
                      )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 230,
                            child: Text(
                              widget.todo.titolo,
                              style: TextStyle(
                                  color: currentSelectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          Container(
                            transform: Matrix4.identity()
                              ..scale(animation?.value, 1.0),
                            width: 230,
                            child: Text(
                              widget.todo.titolo,
                              style: TextStyle(
                                  decorationColor: currentSelectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  decorationStyle: TextDecorationStyle.solid,
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                  decoration: widget.todo.completato
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.todo.data.hour} : ${widget.todo.data.minute}",
                            style: TextStyle(
                                color: currentSelectedIndex == index
                                    ? Colors.white70
                                    : Colors.black54,
                                fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Container(
                        child: Text(
                          widget.todo.sottotitolo,
                          style: TextStyle(
                              color: currentSelectedIndex == index
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        transform: Matrix4.identity()
                          ..scale(animation?.value, 1.0),
                        child: Text(
                          widget.todo.sottotitolo,
                          style: TextStyle(
                              decorationColor: currentSelectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              decorationStyle: TextDecorationStyle.solid,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                              decoration: widget.todo.completato
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
