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

  Future<void> add(String key, T model) async {
    final streamValues = [..._streamController.value];
    streamValues.add(model);
    _streamController.add(streamValues);
    await _box.put(key, model);
  }

  Future<void> edit(String key, T model) async {
    final streamValues = [..._streamController.value];
    var index = streamValues.indexOf(model);

    try {
      streamValues
        ..removeAt(index)
        ..insert(index, model);
      _streamController.add(streamValues);
      await _box.put(key, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String key, T model) async {
    final streamValues = [..._streamController.value];
    streamValues.remove(model);
    _streamController.add(streamValues);
    await _box.delete(key);
  }
}
