import 'dart:async';

import 'package:flutter/material.dart';

import 'websocket_service.dart';

class ConnectionStatus extends StatefulWidget {
  final ChatWebSocketService webSocketService;

  const ConnectionStatus({
    super.key,
    required this.webSocketService,
  });

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  late final StreamSubscription<WebSocketStatus> _wsStatusSubscription;
  WebSocketStatus _wsStatus = WebSocketStatus.disconnected;

  @override
  void initState() {
    super.initState();
    _wsStatusSubscription = widget.webSocketService.status.listen((status) {
      setState(() {
        _wsStatus = status;
      });
    });
  }

  @override
  void dispose() {
    _wsStatusSubscription.cancel();
    super.dispose();
  }

  Color _getStatusColor() {
    switch (_wsStatus) {
      case WebSocketStatus.disconnected:
        return Colors.red;
      case WebSocketStatus.connecting:
      case WebSocketStatus.reconnecting:
        return Colors.orange;
      case WebSocketStatus.connected:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getStatusColor(),
      ),
    );
  }
}
