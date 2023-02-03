/// Provides a widget and an associated controller for simple painting using touch.
library painter;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;

/// A very simple widget that supports drawing using touch.
/// タッチによる描画をサポートする、非常にシンプルなウィジェットです。
class Painter extends StatefulWidget {
  final PainterController painterController;
  final VoidCallback? onPanStart;

  /// Creates an instance of this widget that operates on top of the supplied [PainterController].
  /// 指定した [PainterController] の上に動作するこのウィジェットのインスタンスを作成します。
  Painter(PainterController painterController, VoidCallback? onPanStart)
      : this.painterController = painterController,
        this.onPanStart = onPanStart,
        super(key: new ValueKey<PainterController>(painterController));

  //final String test;

  @override
  _PainterState createState() => new _PainterState();
}

class _PainterState extends State<Painter> {
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    widget.painterController._widgetFinish = _finish;
  }

  Size _finish() {
    setState(() {
      _finished = true;
    });
    return context.size ?? const Size(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = new CustomPaint(
      willChange: true,
      painter: new _PainterPainter(widget.painterController._pathHistory,
          repaint: widget.painterController),
    );
    child = new ClipRect(child: child);
    if (!_finished) {
      child = new GestureDetector(
        child: child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      );
    }
    return new Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController._pathHistory.add(pos);
    widget.painterController._notifyListeners();
    //chatに発火
    widget.onPanStart!();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController._pathHistory.updateCurrent(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController._pathHistory.endCurrent();
    widget.painterController._notifyListeners();
  }
}

class _PainterPainter extends CustomPainter {
  final _PathHistory _path;

  _PainterPainter(this._path, {Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_PainterPainter oldDelegate) {
    return true;
  }
}

class _PathHistory {
  List<MapEntry<Path, Paint>> _paths;
  List<MapEntry<Path, Paint>> undoPaths = <MapEntry<Path, Paint>>[];

  Paint currentPaint;
  Paint _backgroundPaint;
  bool _inDrag;

  bool get isEmpty => _paths.isEmpty;

  bool get isUndoPathEmpty => undoPaths.isEmpty;

  _PathHistory()
      : _paths = <MapEntry<Path, Paint>>[],
        _inDrag = false,
        _backgroundPaint = new Paint()..blendMode = BlendMode.dstOver,
        currentPaint = new Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    if (!_inDrag && _paths.length > 0) {
      //paths.last
      undoPaths.add(_paths.last);
      _paths.removeLast();
    }
  }

  void redo() {
    if (!_inDrag && undoPaths.length > 0) {
      _paths.add(undoPaths.last);
      undoPaths.removeLast();
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
      undoPaths.clear();
    }
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = new Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(new MapEntry<Path, Paint>(path, currentPaint));
      //点の描画
      path.addOval(Rect.fromCircle(
          center: Offset(startPoint.dx, startPoint.dy), radius: 1));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      Path path = _paths.last.key;
      //print('path : $_paths.last.key');
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
    //print(_paths);
  }

  void draw(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (MapEntry<Path, Paint> path in _paths) {
      Paint p = path.value;
      canvas.drawPath(path.key, p);
      //print('aaaa');
    }
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    canvas.restore();
  }
}

/// Container that holds the size of a finished drawing and the drawed data as [Picture].
class PictureDetails {
  /// The drawings data as [Picture].
  final Picture picture;

  /// The width of the drawing.
  final int width;

  /// The height of the drawing.
  final int height;

  /// Creates an immutable instance with the given drawing information.
  const PictureDetails(this.picture, this.width, this.height);

  /// Converts the [picture] to an [Image].
  Future<Image> toImage() => picture.toImage(width, height);

  /// Converts the [picture] to a PNG and returns the bytes of the PNG.
  ///
  /// This might throw a [FlutterError], if flutter is not able to convert
  /// the intermediate [Image] to a PNG.
  Future<Uint8List> toPNG() async {
    Image image = await toImage();
    ByteData? data = await image.toByteData(format: ImageByteFormat.png);
    if (data != null) {
      return data.buffer.asUint8List();
    } else {
      throw new FlutterError('Flutter failed to convert an Image to bytes!');
    }
  }
}

/// [Painter]ウィジェットで使用し、描画をコントロールする。
class PainterController extends ChangeNotifier {
  Color _drawColor = new Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = new Color.fromARGB(255, 255, 255, 255);
  bool _eraseMode = false;
  bool _isEmpty = true;
  bool _isUndoPathEmpty = true;

  double _thickness = 1.0;
  PictureDetails? _cached;
  _PathHistory _pathHistory;
  ValueGetter<Size>? _widgetFinish;

  /// [Painter] ウィジェットで使用するために新しいインスタンスを作成する。
  PainterController() : _pathHistory = new _PathHistory();

  /// まだ何も描画されていない場合、true を返す。
  bool get isEmpty => _pathHistory.isEmpty;

  bool get isUndoPathEmpty => _pathHistory.isUndoPathEmpty;

  set isEmpty(bool enabled) {
    _isEmpty = enabled;
  }

  set isUndoPathEmpty(bool enabled) {
    _isUndoPathEmpty = enabled;
  }

  /// [PainterController] が現在消去モードである場合に true を返します。
  /// それ以外の場合は false を返します。
  bool get eraseMode => _eraseMode;

  /// true に設定すると、false で再度呼び出されるまで、消去モードが有効になります。
  set eraseMode(bool enabled) {
    _eraseMode = enabled;

    _updatePaint();
  }

  // set isEmpty(bool enabled) {
  //   _pathHistory.isEmpty = enabled;
  //   _updatePaint();
  // }

  /// 現在の描画色を取得する。
  Color get drawColor => _drawColor;

  /// 描画色を設定します。
  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  /// 現在の背景色を取得する。
  Color get backgroundColor => _backgroundColor;

  /// 背景色を更新する。
  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  /// 描画に使用される現在の厚さを返します。
  double get thickness => _thickness;

  /// 描画の太さを設定します。
  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = new Paint();
    if (_eraseMode) {
      paint.blendMode = BlendMode.clear;
      paint.color = Color.fromARGB(0, 255, 0, 0);
    } else {
      paint.color = drawColor;
      paint.blendMode = BlendMode.srcOver;
    }
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    _pathHistory.currentPaint = paint;
    _pathHistory.setBackgroundColor(backgroundColor);
    notifyListeners();
  }

  /// 最後の描画動作を元に戻す（ただし、背景色の変更は不可）。
  /// 画像がすでに完成している場合は、この操作は無効で何も行いません。
  void undo() {
    if (!isFinished()) {
      _pathHistory.undo();
      notifyListeners();
    }
  }

  void redo() {
    if (!isFinished()) {
      _pathHistory.redo();
      notifyListeners();
    }
  }

  void _notifyListeners() {
    notifyListeners();
  }

  /// すべての描画アクションを削除しますが、背景には影響を与えません。
  /// 画像がすでに完成している場合は、この操作は無効で何も行いません。
  void clear() {
    if (!isFinished()) {
      _pathHistory.clear();
      notifyListeners();
    }
  }

  /// 描画を終了し、描画された[PictureDetails]を返します。
  /// 描画はキャッシュされ、以後このメソッドを呼び出すと、キャッシュされた
  /// 描画が返されます。
  ///
  /// This might throw a [StateError] if this PainterController is not attached
  /// to a widget, or the associated widget's [Size.isEmpty].
  /// この PainterController がウィジェットに接続されていない場合、[StateError] が
  /// スローされることがあります。がウィジェットに接続されていない場合、
  /// または関連するウィジェットの [Size.isEmpty] の場合、[State Error] をスローします。
  PictureDetails finish() {
    if (!isFinished()) {
      if (_widgetFinish != null) {
        _cached = _render(_widgetFinish!());
      } else {
        throw new StateError(
            'Called finish on a PainterController that was not connected to a widget yet!');
      }
    }
    return _cached!;
  }

  PictureDetails _render(Size size) {
    if (size.isEmpty) {
      throw new StateError('Tried to render a picture with an invalid size!');
    } else {
      PictureRecorder recorder = new PictureRecorder();
      Canvas canvas = new Canvas(recorder);
      _pathHistory.draw(canvas, size);
      return new PictureDetails(
          recorder.endRecording(), size.width.floor(), size.height.floor());
    }
  }

  /// この描画が終了した場合、true を返す。
  ///
  /// Trying to modify a finished drawing is a no-op.
  bool isFinished() {
    return _cached != null;
  }
}
