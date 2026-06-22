# ملف المراجعة — Event Loop في Dart

---

## 1. ما هو الـ Event Loop؟

لغة Dart هي لغة "single-threaded"، يعني كل الكود يعمل على خيط واحد فقط. لكن رغم ذلك، التطبيق يستجيب للمستخدم ويجلب البيانات ويستمع للأحداث، وكل ذلك يتم عبر ما يُسمى بالـ "Event Loop".

الـ "Event Loop" يدير ثلاثة أشياء بالترتيب:

```
① Call Stack        ← الكود المتزامن، ينفذ أولاً
② Microtask Queue   ← مهام عاجلة، تنفذ ثانياً
③ Event Queue       ← أحداث خارجية، تنفذ أخيراً
```

القاعدة الذهبية: الـ "Event Loop" لا يتحرك إلا إذا كان الـ "Call Stack" فارغاً.

---

## 2. الـ Call Stack

الـ "Call Stack" هي برج من الدوال، كل مرة تستدعي دالة تُضاف فوق البرج، وعند انتهائها تُرفع منه. لغة Dart تعمل دائماً على القمة فقط.

---

## 3. الـ Microtask Queue

يحتوي على مهام يجب تنفيذها قبل أي حدث خارجي. الـ "Future" داخلياً يستخدمه، وكل ما يأتي بعد الكلمة المحجوزة "await" يُوضع فيه.

---

## 4. الـ Event Queue

يحتوي على:
- استجابات الـ HTTP requests
- أحداث الـ Timer
- أحداث المستخدم (ضغط زر، scroll)
- رسائل الـ Stream

---

## 5. الفرق بين Future.value و Future العادي

| | Future.value | Future(() => ...) |
|---|---|---|
| حالته | مكتمل فوراً | غير مكتمل |
| يمر بالـ Event Queue؟ | لا | نعم |
| ما بعد await يذهب لـ | Microtask Queue | Microtask Queue (لكن بعد Event Queue) |

---

## 6. أمثلة مرتبة من السهل للصعب

---

### مثال 1 — سهل جداً (كود متزامن فقط)

```dart
void main() {
  print('A');
  print('B');
  print('C');
}
```

**الخرج:**
```
A
B
C
```

**الشرح:** كل شيء ينفذ في الـ "Call Stack" بالترتيب، لا queues هنا.

---

### مثال 2 — سهل (scheduleMicrotask)

```dart
import 'dart:async';

void main() {
  print('1');
  scheduleMicrotask(() => print('2'));
  print('3');
}
```

**الخرج:**
```
1
3
2
```

**الشرح:** السطر "scheduleMicrotask" نفسه ينفذ في الـ "Call Stack"، لكنه فقط يضع الـ "callback" في الـ "Microtask Queue". الـ "callback" لا ينفذ إلا بعد أن يفرغ الـ "Call Stack".

---

### مثال 3 — متوسط (await مع Future.value)

```dart
void main() async {
  print('A');
  await Future.value(42);
  print('B');
  print('C');
}
```

**الخرج:**
```
A
B
C
```

**الشرح:** الكلمة المحجوزة "await" تُعلّق الدالة وتضع كل ما بعدها في الـ "Microtask Queue". الـ "Future.value" مكتمل فوراً ولا يمر بالـ "Event Queue".

---

### مثال 4 — متوسط (await مع Future عادي)

```dart
void main() async {
  print('A');
  await Future(() => print('X'));
  print('B');
  print('C');
}
```

**الخرج:**
```
A
X
B
C
```

**الشرح:** الـ "Future" العادي يضع الـ "callback" في الـ "Event Queue" أولاً. بعد تنفيذه يكتمل الـ "Future"، ثم تضع الكلمة المحجوزة "await" ما بعدها في الـ "Microtask Queue".

---

### مثال 5 — متوسط (Microtask vs Event)

```dart
import 'dart:async';

void main() {
  print('1');
  Future(() => print('2 - Event'));
  scheduleMicrotask(() => print('3 - Microtask'));
  print('4');
}
```

**الخرج:**
```
1
4
3 - Microtask
2 - Event
```

**الشرح:** الترتيب دائماً — الكود المتزامن أولاً، ثم الـ "Microtask Queue"، ثم الـ "Event Queue".

---

### مثال 6 — صعب (مزيج من الكل)

```dart
import 'dart:async';

void main() async {
  print('1');

  Future(() => print('2 - Event'));

  Future.microtask(() => print('3 - Microtask'));

  await Future.value(null);

  print('4');
}
```

**الخرج:**
```
1
3 - Microtask
4
2 - Event
```

**الشرح:**
- الرقم "1" ينفذ في الـ "Call Stack"
- الـ "Future" العادي يضع الرقم "2" في الـ "Event Queue"
- الـ "Future.microtask" يضع الرقم "3" في الـ "Microtask Queue"
- الكلمة المحجوزة "await" تضع الرقم "4" في الـ "Microtask Queue" أيضاً
- الـ "Event Loop" يُفرغ الـ "Microtask Queue" أولاً: "3" ثم "4"
- ثم يأخذ من الـ "Event Queue": "2"

---

### مثال 7 — صعب جداً (fire and forget + dispose)

```dart
class _MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    super.initState();
    loadData(); // fire-and-forget ⚠️
  }

  Future<void> loadData() async {
    final data = await repository.fetch();

    // ⚠️ الـ widget ربما تم dispose قبل أن نصل هنا
    setState(() => this.data = data);
  }
}
```

**المشكلة:** بين لحظة الكلمة المحجوزة "await" ولحظة العودة، يمكن للمستخدم إغلاق الشاشة. الـ "widget" يُدمَّر لكن الـ "Future" لا يزال في الـ "Queue".

**الحل:**
```dart
Future<void> loadData() async {
  final data = await repository.fetch();

  if (!mounted) return; // ✅ تحقق أن الـ widget لا يزال حياً

  setState(() => this.data = data);
}
```

---

## 7. أسئلة الـ Interview

---

### أسئلة مفاهيمية

**سؤال 1:** ما الفرق بين الـ Microtask Queue والـ Event Queue؟

**الإجابة:** الـ "Microtask Queue" للمهام العاجلة التي يجب تنفيذها قبل أي حدث خارجي، والـ "Event Loop" يُفرغها بالكامل قبل أن ينتقل لأي عنصر في الـ "Event Queue". الـ "Event Queue" للأحداث الخارجية مثل "HTTP responses" والـ "Timer" وأحداث المستخدم.

---

**سؤال 2:** هل الكلمة المحجوزة "await" تُجمّد الـ thread؟

**الإجابة:** لا أبداً. الكلمة المحجوزة "await" تُعلّق الدالة الحالية فقط وتُعيد التحكم للـ "Event Loop"، بينما الـ "thread" يظل حراً لتنفيذ مهام أخرى.

---

**سؤال 3:** ما الفرق بين "Future.value" و "Future(() => ...)"؟

**الإجابة:** الـ "Future.value" ينشئ "Future" مكتملاً فوراً ولا يمر بالـ "Event Queue"، بينما الـ "Future" العادي ينشئ "Future" غير مكتمل ويضع الـ "callback" في الـ "Event Queue" أولاً.

---

**سؤال 4:** لماذا نتحقق من "mounted" بعد الـ await؟

**الإجابة:** لأن الكلمة المحجوزة "await" تُعلّق الدالة وتُعيد التحكم للـ "Event Loop"، وفي هذه الفترة قد يُغلق المستخدم الشاشة ويتم "dispose" للـ "widget". عند استئناف الدالة من الـ "Queue"، الـ "widget" قد لا يكون موجوداً، فنتحقق من الخاصية "mounted" قبل استدعاء "setState".

---

**سؤال 5:** ما هو الـ Isolate وكيف يختلف عن الـ async/await؟

**الإجابة:** الـ "async/await" لا يُنشئ خيطاً جديداً، كل شيء يعمل على نفس الـ "thread" عبر الـ "Event Loop". الـ "Isolate" هو خيط منفصل تماماً بذاكرة مستقلة، ويتواصل مع الـ "Isolate" الرئيسي فقط عبر الرسائل باستخدام "SendPort" و"ReceivePort". يُستخدم للعمليات الثقيلة مثل معالجة الصور أو تحليل ملفات "JSON" الضخمة.

---

### أسئلة تخمين الخرج

**سؤال أ:** ما خرج هذا الكود؟

```dart
void main() {
  print('1');
  Future(() => print('2'));
  print('3');
}
```

**الإجابة:**
```
1
3
2
```

---

**سؤال ب:** ما خرج هذا الكود؟

```dart
import 'dart:async';

void main() async {
  print('A');
  scheduleMicrotask(() => print('B'));
  await Future(() => print('C'));
  print('D');
}
```

**الإجابة:**
```
A
B
C
D
```

**الشرح:** الحرف "B" في الـ "Microtask Queue" ينفذ قبل الحرف "C" الذي في الـ "Event Queue". بعد اكتمال "C" تضع الكلمة المحجوزة "await" الحرف "D" في الـ "Microtask Queue".

---

**سؤال ج:** ما خرج هذا الكود؟

```dart
import 'dart:async';

void main() async {
  print('1');
  await Future.value(null);
  print('2');
  scheduleMicrotask(() => print('3'));
  await Future(() => print('4'));
  print('5');
}
```

**الإجابة:**
```
1
2
3
4
5
```

---

## 8. ملخص القواعد الذهبية

| القاعدة | التفاصيل |
|---------|---------|
| الأولوية | Call Stack ← Microtask Queue ← Event Queue |
| الـ await | تُعلّق الدالة، لا تُجمّد الـ thread |
| Future.value | مكتمل فوراً، يتخطى الـ Event Queue |
| Future عادي | يمر بالـ Event Queue أولاً |
| mounted | تحقق منه دائماً بعد await في StatefulWidget |
| Isolate | الطريقة الوحيدة للتوازي الحقيقي في Dart |

---

*ملف مراجعة — Dart Event Loop Interview Prep*