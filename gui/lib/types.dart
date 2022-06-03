enum OS {
  Linux,
  Windows,
  Mac,
}

enum Hardware {
  Unknown,
  Computer,
  Phone,
  Router
}

enum Access {
  None,
  User,
  System
}

class Connection {
  Connection(this.ip, this.type);

  String ip;
  ConnectionType type;
}

enum ConnectionType {
  Scan,
  Session
}

int maxHostId = 0;

class Host {
  int id = maxHostId++;
  String? name;
  String? ip;
  OS? os;
  Access access = Access.None;
  List<Connection> connections = [];
  Hardware hardware = Hardware.Unknown;
}