/// Institution model
class Node {
  double rain;
  double moisture;
  double x;
  double y;
  double z;
  String color;
  DateTime lastSeen;

  Node({
    required this.rain,
    required this.moisture,
    required this.x,
    required this.y,
    required this.z,
    required this.color,
    required this.lastSeen,
  });

  factory Node.fromMap(Map data) {
    return Node(
      rain: data['r'] ?? '',
      moisture: data['m'] ?? '',
      x: data['x'] ?? '',
      y: data['y'] ?? '',
      z: data['z'] ?? '',
      color: data['color'] ?? '',
      lastSeen: DateTime.fromMillisecondsSinceEpoch(data['time'] * 1000),
    );
  }
}
