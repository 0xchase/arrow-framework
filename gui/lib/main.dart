import 'package:flutter/material.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/xterm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainView(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<int> selected = ValueNotifier(0);

  // late Terminal terminal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selected,
        builder: (context, value, widget) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(20, 20, 20, 1.0)
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Sidebar(selected)
              ),
              Positioned(
                left: 60,
                top: 0,
                bottom: 0,
                right: 0,
                child: selected.value == 0 ? Container() 
                : selected.value == 1 ? Container(color: Colors.red)
                : selected.value == 2 ? Container(color: Colors.blue)
                : selected.value == 3 ? Container(color: Colors.green)
                : selected.value == 4 ? Container(color: Colors.purple)
                : Container()
              ),
            ],
          );
        }
      ),
    );
  }
}

// https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Tx5tHR-jMZbvbWvedgk9ckAsGNfuYwa7wdYyGpdcd69aoQul0mp66sRh2-SSzL1dTuw&usqp=CAU

class Sidebar extends StatelessWidget {
  Sidebar(this.selected);

  ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: 60,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 1.0),
        // borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SidebarIcon(
                iconData: Icons.network_wifi, // Host graph
                selected: selected,
                index: 0,
              ),
              SidebarIcon(
                iconData: Icons.terrain,
                selected: selected,
                index: 1,
              ),
              SidebarIcon(
                iconData: Icons.light,
                selected: selected,
                index: 2,
              ),
              SidebarIcon(
                iconData: Icons.charging_station,
                selected: selected,
                index: 3,
              ),
              SidebarIcon(
                iconData: Icons.code,
                selected: selected,
                index: 4,
              ),
            ],
          ),
        ]
      )
    );
  }
}

class SidebarIcon extends StatelessWidget {
  SidebarIcon({required this.iconData, required this.selected, required this.index});

  IconData iconData;
  ValueNotifier<int> selected;
  int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selected.value == index ? Container(width: 2, height: 30, color: Colors.white) : Container(width: 2),
        Container(
          alignment: Alignment.center,
          width: 56,
          height: 60,
          child: IconButton(
            onPressed: () {
              selected.value = index;
            },
            icon: Icon(
              iconData,
              size: 24,
              color: selected.value == index ? Colors.white : const Color.fromRGBO(120, 120, 120, 1.0),
            )
          )
        )
      ]
    );
  }
}
