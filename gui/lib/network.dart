import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

import 'main.dart';
import 'types.dart';

class NetworkView extends StatefulWidget {
  @override
  _NetworkView createState() => _NetworkView();
}

class _NetworkView extends State<NetworkView> {

  ValueNotifier<int> selectedId = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(50),
      minScale: 0.0001,
      maxScale: 2,
      child: CustomPaint(
        painter: GridPainter(),
        child: GestureDetector(
          onTap: () {
            selectedId.value = -1;
          },
          child: ValueListenableBuilder<List<Host>>(
            valueListenable: hosts,
            builder: (context, hostsValue, widget) {
              Graph graph = Graph();
              Algorithm builder = FruchtermanReingoldAlgorithm(iterations: 1000);

              for (Host host in hostsValue) {
                graph.addNode(Node.Id(host.id));
              }

              for (Host source in hostsValue) {
                for (Connection connection in source.connections) {
                  for (Host dest in hostsValue) {
                    if (dest.ip == connection.ip) {
                      graph.addEdge(
                        Node.Id(source.id), Node.Id(dest.id),
                        paint: Paint()..color = Colors.grey
                      );
                    }
                  }
                }
              }

              return GraphView(
                graph: graph,
                algorithm: builder,
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 5
                  ..style = PaintingStyle.fill,
                builder: (Node node) {
                  for (Host host in hostsValue) {
                    if (host.id == node.key!.value) {
                      return HostNode(
                        host: host,
                        selectedId: selectedId,
                      );
                    }
                  }

                  print("Couldn't find node " + node.key!.value.toString());
                  return Container();
                }
              );
            }
          ),
        )
      )
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromRGBO(30, 30, 30, 1.0)
      ..strokeWidth = 1.0;

    for (double x = 0.0; x < size.width; x += 20) {
      canvas.drawLine(
        Offset(x, 0), 
        Offset(x, size.height),
        paint
      );
    }

    for (double y = 0.0; y < size.height; y += 20) {
      canvas.drawLine(
        Offset(0, y), 
        Offset(size.width, y),
        paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HostNode extends StatefulWidget {
  HostNode({required this.host, required this.selectedId});

  Host host;
  ValueNotifier<int> selectedId;

  @override
  _HostNode createState() => _HostNode();
}

class _HostNode extends State<HostNode> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.selectedId,
      builder: (context, value, w) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromRGBO(60, 60, 60, 1.0),
            border: value == widget.host.id ? 
              Border.all(
                color: Colors.grey,
                width: 2
              ) : null,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 70,
                  height: 24,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(5),
                  // color: const Color.fromRGBO(40, 40, 40, 1.0),
                  /*child: Text(
                    widget.host.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),*/
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  widget.host.hardware == Hardware.Computer ? Icons.computer
                  : widget.host.hardware == Hardware.Router ? Icons.router
                  : widget.host.hardware == Hardware.Phone ? Icons.mobile_friendly
                  : Icons.device_unknown,
                  color: widget.host.access == Access.User ? Colors.yellow
                        : widget.host.access == Access.System ? Colors.red
                        : Colors.blue,
                ),
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: NodeTooltip(widget.host)
              ),
              SizedBox(
                width: 70,
                height: 70,
                child: GestureDetector(
                  onTap: () {
                    if (widget.selectedId.value == widget.host.id) {
                      widget.selectedId.value = -1;
                    } else {
                      widget.selectedId.value = widget.host.id;
                    }
                  },
                ),
              ),
            ]
          ),
        );
      }
    );
  }
}

class NodeTooltip extends StatelessWidget {
  NodeTooltip(this.host);

  Host host;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Name:     " + host.name.toString() + "\n"
        + "Address:  " + host.ip.toString(),
      // child: Text('Hover over the text to show a tooltip.'),
      textStyle: const TextStyle(
        fontFamily: "RobotoMono",
        fontSize: 10,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(80, 80, 80, 0.7),
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}