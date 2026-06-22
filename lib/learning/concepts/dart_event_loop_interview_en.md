# Dart Event Loop — Interview Prep File

---

## 1. What is the Event Loop?

Dart is a **single-threaded** language — all code runs on one thread only. Yet the app still responds to the user, fetches data, and listens to events. This is all made possible by the **Event Loop**.

The Event Loop manages three things in order:

```
① Call Stack        ← synchronous code, runs first (only synchronous code, print(), math, variable assignments etc.)
② Microtask Queue   ← urgent tasks, runs second ( callbacks that are ready but must waitFuture.value().then(),scheduleMicrotask(),)
③ Event Queue       ← external events, runs last ( Button press  وcallbacks that had real async workFuture(() => ...).then(),Timer, I/O, HTTP etc,)
```

**Golden rule:** The Event Loop never moves forward unless the Call Stack is empty.

---

## 2. The Call Stack

The Call Stack is a tower of function calls. Every time you call a function it gets pushed on top of the tower, and when it finishes it gets popped off. Dart always executes whatever is on top.

---

## 3. The Microtask Queue

Contains tasks that must run before any external event. The Future class uses it internally, and everything that comes after an `await` gets placed here.

---

## 4. The Event Queue

Contains:
- HTTP responses
- Timer events
- User events (button press, scroll)
- Stream messages

---

## 5. Future.value vs Regular Future

| | `Future.value` | `Future(() => ...)` |
|---|---|---|
| State | Completed immediately | Not yet completed |
| Goes through Event Queue? | No | Yes |
| What comes after `await` goes to | Microtask Queue | Microtask Queue (but after Event Queue) |

---

## 6. Examples — Easy to Hard

---

### Example 1 — Very Easy (synchronous only)

```dart
void main() {
  print('A');
  print('B');
  print('C');
}
```

**Output:**
```
A
B
C
```

**Explanation:** Everything runs directly in the Call Stack in order. No queues involved.

---

### Example 2 — Easy (scheduleMicrotask)

```dart
import 'dart:async';

void main() {
  print('1');
  scheduleMicrotask(() => print('2'));
  print('3');
}
```

**Output:**
```
1
3
2
```

**Explanation:** The `scheduleMicrotask` line itself runs in the Call Stack, but it only places the callback into the Microtask Queue. The callback doesn't execute until the Call Stack is empty.

---

### Example 3 — Medium (await with Future.value)

```dart
void main() async {
  print('A');
  await Future.value(42); // this will excuted befor print('B'); and print('C');
  print('B');
  print('C');
}
```

**Output:**
```
A
B
C
```

**Explanation:** `await` suspends the function and places everything after it into the Microtask Queue. `Future.value` completes immediately and never touches the Event Queue.

---

### Example 4 — Medium (await with regular Future)

```dart
void main() async {
  print('A');
  await Future(() => print('X'));
  print('B');
  print('C');
}
```

**Output:**
```
A
X
B
C
```

**Explanation:** The regular Future places its callback in the Event Queue first. Once it completes, `await` places what comes after it into the Microtask Queue.

---

### Example 5 — Medium (Microtask vs Event)

```dart
import 'dart:async';

void main() {
  print('1');
  Future(() => print('2 - Event'));
  scheduleMicrotask(() => print('3 - Microtask'));
  print('4'); // this will not go to microtask queue , because there is no wait keyword befor it
}
```

**Output:**
```
1
4
3 - Microtask
2 - Event
```

**Explanation:** The order is always — synchronous code first, then Microtask Queue, then Event Queue.

---

### Example 6 — Hard (mix of everything)

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

**Output:**
```
1
3 - Microtask
4
2 - Event
```

**Explanation:**
- `1` runs in the Call Stack
- The regular Future places `2` in the Event Queue
- `Future.microtask` places `3` in the Microtask Queue
- `await` places `4` in the Microtask Queue as well
- The Event Loop drains the Microtask Queue first: `3` then `4`
- Then picks from the Event Queue: `2`

---

### Example 7 — Very Hard (fire and forget + dispose)

```dart
class _MyWidgetState extends State<MyWidget> {

  @override
  void initState() {
    super.initState();
    loadData(); // fire-and-forget ⚠️
  }

  Future<void> loadData() async {
    final data = await repository.fetch();

    // ⚠️ the widget may have been disposed by the time we reach here
    setState(() => this.data = data);
  }
}
```

**The problem:** Between the `await` and the resumption, the user may close the screen. The widget gets destroyed but the Future is still sitting in the Queue.

**The fix:**
```dart
Future<void> loadData() async {
  final data = await repository.fetch();

  if (!mounted) return; // ✅ check the widget is still alive

  setState(() => this.data = data);
}
```

---

## 7. Interview Questions

---

### Conceptual Questions

**Q1:** What is the difference between the Microtask Queue and the Event Queue?

**Answer:** The Microtask Queue holds urgent tasks that must run before any external event. The Event Loop drains it completely before picking a single item from the Event Queue. The Event Queue holds external events like HTTP responses, Timers, and user interactions.

---

**Q2:** Does `await` freeze the thread?

**Answer:** No. `await` only suspends the current function and hands control back to the Event Loop. The thread remains free to process other tasks.

---

**Q3:** What is the difference between `Future.value` and `Future(() => ...)`?

**Answer:** `Future.value` creates an already-completed Future and skips the Event Queue entirely. A regular `Future(() => ...)` creates an incomplete Future and places its callback in the Event Queue first.

---

**Q4:** Why do we check `mounted` after `await`?

**Answer:** Because `await` suspends the function and returns control to the Event Loop. During that gap, the user may close the screen and the widget gets disposed. When the function resumes from the Queue, the widget may no longer exist — so we check `mounted` before calling `setState`.

---

**Q5:** What is an Isolate and how does it differ from async/await?

**Answer:** `async/await` doesn't create a new thread — everything still runs on the same thread via the Event Loop. An Isolate is a completely separate thread with its own memory. It communicates with the main Isolate only through messages using `SendPort` and `ReceivePort`. It's used for heavy operations like image processing or parsing large JSON files.

---

### Guess the Output Questions

**Q A:** What is the output?

```dart
void main() {
  print('1');
  Future(() => print('2'));
  print('3');
}
```

**Answer:**
```
1
3
2
```

---

**Q B:** What is the output?

```dart
import 'dart:async';

void main() async {
  print('A');
  scheduleMicrotask(() => print('B'));
  await Future(() => print('C'));
  print('D');
}
```

**Answer:**
```
A
B
C
D
```

**Explanation:** `B` is in the Microtask Queue and runs before `C` which is in the Event Queue. After `C` completes, `await` places `D` into the Microtask Queue.

---

**Q C:** What is the output?

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

**Answer:**
```
1
2
3
4
5
```

---

## 8. Golden Rules Summary

| Rule | Detail |
|------|--------|
| Priority order | Call Stack → Microtask Queue → Event Queue |
| `await` | Suspends the function, does NOT freeze the thread |
| `Future.value` | Completes immediately, skips the Event Queue |
| Regular `Future` | Goes through the Event Queue first |
| `mounted` | Always check after `await` inside a StatefulWidget |
| `Isolate` | The only way to achieve true parallelism in Dart |

---

---

Q: Can I use await in initState? Why or why not?

A:
No, you cannot use await directly inside initState because initState must be synchronous (void method).
Flutter lifecycle requires initState to complete immediately so the widget can continue building and rendering.

but you can use this inside initstate : 

WidgetsBinding.instance.addPostFrameCallback((_) async {
  await loadData();
});

---

*Interview Prep File — Dart Event Loop*
