import 'package:flutter/material.dart';

class CustomFilterDropdown<T> extends StatefulWidget {
  final T value;
  final List<CustomDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String hint;

  const CustomFilterDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint = '',
  });

  @override
  State<CustomFilterDropdown<T>> createState() => _CustomFilterDropdownState<T>();
}

class _CustomFilterDropdownState<T> extends State<CustomFilterDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeDropdown,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 0),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: size.width,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0B0B0B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.70),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _closeDropdown,
                        child: Container(
                          width: size.width,
                          height: 41,
                          margin: const EdgeInsets.all(1),
                          decoration: const ShapeDecoration(
                            color: Color(0xFF276EFB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 11),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _getSelectedLabel(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Be Vietnam Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...widget.items.where((item) => item.value != widget.value).map((item) {
                                return GestureDetector(
                                  onTap: () {
                                    widget.onChanged(item.value);
                                    _closeDropdown();
                                  },
                                  child: Container(
                                    width: size.width,
                                    height: 40,
                                    padding: const EdgeInsets.only(left: 11),
                                    alignment: Alignment.centerLeft,
                                    color: Colors.transparent,
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Be Vietnam Pro',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSelectedLabel() {
    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => widget.items.first,
    );
    return selectedItem.label;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          height: 41,
          padding: const EdgeInsets.all(1), // Độ dày viền
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.6),
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.7),
              ],
              stops: const [0.0, 0.12, 0.88, 1.0],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getSelectedLabel(),
                    style: const TextStyle(
                      color: Color(0xFF686868),
                      fontSize: 14,
                      fontFamily: 'Be Vietnam Pro',
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF686868), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdownItem<T> {
  final T value;
  final String label;

  CustomDropdownItem({required this.value, required this.label});
}
