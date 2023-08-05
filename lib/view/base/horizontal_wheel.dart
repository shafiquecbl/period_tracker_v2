import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/controller/intro_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class HorizontalWheelWidget extends StatefulWidget {
  final List<int> list;
  final Function(int)? onSelectedItemChanged;
  const HorizontalWheelWidget(
      {required this.list, required this.onSelectedItemChanged, super.key});

  @override
  State<HorizontalWheelWidget> createState() => _HorizontalWheelWidgetState();
}

class _HorizontalWheelWidgetState extends State<HorizontalWheelWidget> {
  int _selectedIndex = 3;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =
        FixedExtentScrollController(initialItem: _selectedIndex);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroController>(builder: (con) {
      return SizedBox(
        height: 330.h,
        child: ListWheelScrollView(
          controller: _scrollController,
          physics: const FixedExtentScrollPhysics(),
          itemExtent: 70.w,
          onSelectedItemChanged: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
            widget.onSelectedItemChanged!(widget.list[newIndex]);
          },
          children: List.generate(
            widget.list.length,
            (index) => AnimatedContainer(
              margin: const EdgeInsets.symmetric(vertical: 5),
              duration: const Duration(milliseconds: 400),
              width: 70.w,
              height: index == _selectedIndex ? 70.w : 60.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: index == _selectedIndex
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          purpleColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                    offset: Offset(-5, -5),
                  ),
                ],
              ),
              child: Text(
                '${widget.list[index]}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color:
                          index == _selectedIndex ? Colors.white : Colors.black,
                    ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _onScroll() {
    final index = _scrollController.selectedItem;
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onSelectedItemChanged!(widget.list[index]);
    }
  }
}
