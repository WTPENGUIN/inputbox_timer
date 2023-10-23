## inputbox_timer

A custom flutter textfield widget that executes a function after a timeout.

## Getting started(TODO : publish pub.dev)

Add inputbox_timer to your pubspec.yaml file:
```yaml
dependencies:
  inputbox_timer:
```

## Usage

```dart
import 'package:inputbox_timer/inputbox_timer.dart';

TimerInputField(
  controller: controller,             // Required, TextEditingController
  excuteOnTimeOut: callFunc,          // Required, call func after time out
  timeoutSecond: 10,                  // Required, timeout seconds
  maxLength: 5,                       // Optional, TextField maxLength property
  keyboardType: TextInputType.number, // Optional, TextField TextInputType
  readOnly: isTimeOver,               // Optional, TextField readOnly property
)
```

## Additional information

TextEditingController should be placed outside the Build() function. Inside Build(), the value is lost due to re-rendering due to the setState function call.
