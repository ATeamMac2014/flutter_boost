import 'package:flutter/widgets.dart';
import 'package:flutter_boost/boost_container.dart';

final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();
List<ContainerOverlayEntry> _lastEntries;

void insertEntry(BoostContainer container) {
  final OverlayState overlayState = overlayKey.currentState;
  if (overlayState == null) {
    return;
  }

  final entry = ContainerOverlayEntry(container);
  overlayState.insert(entry);
}

void refreshOverlayEntries(List<BoostContainer> containers) {
  final OverlayState overlayState = overlayKey.currentState;
  if (overlayState == null) {
    return;
  }

  if (_lastEntries != null && _lastEntries.isNotEmpty) {
    for (ContainerOverlayEntry entry in _lastEntries) {
      entry.remove();
    }
  }

  _lastEntries = containers
      .map<ContainerOverlayEntry>(
          (BoostContainer container) => ContainerOverlayEntry(container))
      .toList(growable: false);

  overlayState.insertAll(_lastEntries);
}

class ContainerOverlayEntry extends OverlayEntry {
  ContainerOverlayEntry(BoostContainer container)
      : super(
            builder: (BuildContext ctx) => container,
            opaque: true,
            maintainState: true) {

    container.attach(this);
  }
  bool _removed = false;

  @override
  void remove() {
    assert(!_removed);

    if (_removed) {
      return;
    }

    _removed = true;
    super.remove();
  }
}