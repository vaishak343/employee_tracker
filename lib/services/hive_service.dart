import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class HiveService<T> {
  HiveService({required Box<T> box}) : _box = box {
    _init();
  }

  final Box<T> _box;

  final _streamController = BehaviorSubject<List<T>>.seeded(const []);

  void _init() async {
    final dataList = getAll();
    if (dataList != null) {
      _streamController.add(dataList);
    } else {
      _streamController.add(const []);
    }
  }

  Stream<List<T>> getAsStream() => _streamController.asBroadcastStream();

  List<T>? getAll() {
    if (_box.values.isEmpty) return null;
    return _box.values.toList();
  }

  Future<void> add(T model) async {
    final streamValues = [..._streamController.value];
    streamValues.add(model);
    _streamController.add(streamValues);
    await _box.add(model);
  }

  Future<void> edit(T key, T model) async {
    final streamValues = [..._streamController.value];
    var index = streamValues.indexOf(key);

    try {
      streamValues
        ..removeAt(index)
        ..insert(index, model);
      _streamController.add(streamValues);
      await _box.putAt(index, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(T model) async {
    final streamValues = [..._streamController.value];
    streamValues.remove(model);
    _streamController.add(streamValues);
    await _box.delete(model);
  }
}
