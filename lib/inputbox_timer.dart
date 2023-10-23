library inputbox_timer;

import 'dart:async';
import 'package:flutter/material.dart';

/// 타임 오버 후 함수 실행 기능이 들어간 입력 위젯
class TimerInputField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType         keyboardType;
  final int                   timeoutSecond;
  final Function?             excuteOnTimeOut;
  final bool?                 readOnly;
  final int?                  maxLength;

  const TimerInputField({
    required this.controller,
    required this.excuteOnTimeOut,
    required this.timeoutSecond,
    this.keyboardType = TextInputType.text,
    this.readOnly,
    this.maxLength,
    Key? key
  }) : super(key: key);

  @override
  State<TimerInputField> createState() => _InPutWidgetState();
}

class _InPutWidgetState extends State<TimerInputField> {
  late int _remainSecond;
  late Timer _timer;

  /// 남은 초 Formatting
  String formatTime(int seconds) {
    Duration dur = Duration(seconds: seconds);
    return dur.toString().split(".").first.substring(2, 7);
  }

  /// 타이머 시작
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      onTick();
    });
  }

  /// 타이머 정지
  void stopTimer() {
    _timer.cancel();
  }

  /// 1초마다 실행
  void onTick() {
    if(_remainSecond == 0) { /// 시간 제한 도달
      setState(() {
        _remainSecond = widget.timeoutSecond;
      });
      
      stopTimer(); /// 타이머 정지
      widget.excuteOnTimeOut!.call(); /// 인수로 전달 된 함수 실행
    } else {
      setState(() { /// 시간 제한에 도달하지 않음
        _remainSecond = _remainSecond - 1; // 1초 감소
      });
    }
  }

  @override
  void initState() {
    _remainSecond = widget.timeoutSecond;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: (widget.maxLength == null) ? null : widget.maxLength!,
      readOnly: (widget.readOnly == null) ? false : widget.readOnly!,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
        ),
        suffixText: formatTime(_remainSecond),
      ),
      onSubmitted: (value) {
        widget.controller.text = value;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) { onTick(); });
      },
    );
  }
}