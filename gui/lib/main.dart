import 'package:flutter/material.dart';
// import 'package:xterm/flutter.dart';
// import 'package:xterm/xterm.dart';

import 'types.dart';
import 'network.dart';
import 'cli.dart';

ValueNotifier<List<Host>> hosts = ValueNotifier([]);

void main() {
  Host host1 = Host()
    ..ip = "192.168.1.1"
    ..name = "Host 1"
    ..access = Access.System
    ..os = OS.Linux;

  Host host2 = Host()
    ..ip = "192.168.1.2"
    ..name = "Host 2"
    ..access = Access.User
    ..os = OS.Mac;

  Host host3 = Host()
    ..ip = "192.168.1.3"
    ..name = "Host 3"
    ..access = Access.None
    ..hardware = Hardware.Computer
    ..os = OS.Windows;

  Host host4 = Host()
    ..ip = "192.168.1.4"
    ..name = "Host 4"
    ..access = Access.None
    ..hardware = Hardware.Router
    ..os = OS.Linux;

  Host host5 = Host()
    ..ip = "192.168.1.5"
    ..name = "Host 5"
    ..access = Access.User
    ..hardware = Hardware.Computer
    ..os = OS.Linux;

  Host host6 = Host()
    ..ip = "192.168.1.6"
    ..name = "Host 6"
    ..access = Access.None
    ..hardware = Hardware.Phone
    ..os = OS.Linux;

  Host host7 = Host()
    ..ip = "192.168.1.7"
    ..name = "Host 7"
    ..access = Access.None
    ..hardware = Hardware.Computer
    ..os = OS.Linux;
  
  /* Create host tree */

  host1.connections.add(Connection(host2.ip!, ConnectionType.Scan));
  host1.connections.add(Connection(host3.ip!, ConnectionType.Scan));
  host1.connections.add(Connection(host4.ip!, ConnectionType.Scan));

  host4.connections.add(Connection(host5.ip!, ConnectionType.Scan));
  host4.connections.add(Connection(host6.ip!, ConnectionType.Scan));
  host4.connections.add(Connection(host7.ip!, ConnectionType.Scan));

  hosts.value.add(host1);
  hosts.value.add(host2);
  hosts.value.add(host3);
  hosts.value.add(host4);
  hosts.value.add(host5);
  hosts.value.add(host6);
  hosts.value.add(host7);

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
                left: 60,
                top: 0,
                bottom: 24,
                right: 0,
                child: Stack(
                  children: [
                    Visibility(
                      visible: selected.value == 0,
                      maintainState: true,
                      child: NetworkView(),
                    ),
                    Visibility(
                      visible: selected.value == 1,
                      maintainState: true,
                      child: Container(color: Colors.blue),
                    ),
                    Visibility(
                      visible: selected.value == 2,
                      maintainState: true,
                      child: Container(color: Colors.red),
                    ),
                    Visibility(
                      visible: selected.value == 3,
                      maintainState: true,
                      child: Container(color: Colors.green),
                    ),
                    Visibility(
                      visible: selected.value == 4,
                      maintainState: true,
                      child: Container(color: Colors.purple),
                    ),
                  ],
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
                right: 0,
                bottom: 0,
                child: CliView(),
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
