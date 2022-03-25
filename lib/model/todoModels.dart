import 'package:hive/hive.dart';

part 'todoModels.g.dart';

@HiveType(typeId: 0)
class Todo {
  const Todo({
    required this.titolo,
    required this.sottotitolo,
    required this.data,
    required this.completato,
    required this.id,
  });

  @HiveField(0)
  final String titolo;

  @HiveField(1)
  final String sottotitolo;

  @HiveField(2)
  final DateTime data;

  @HiveField(3)
  final bool completato;

  @HiveField(4)
  final int id;
}
