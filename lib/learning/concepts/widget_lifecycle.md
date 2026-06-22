# Widget Lifecycle — Interview Cheat Sheet

---

## 1. Full Order

```
createState()
initState()
didChangeDependencies()
build()
didUpdateWidget()     ← only if parent rebuilds
deactivate()          ← removal, might come back
dispose()             ← permanent death
```

---

## 2. Each Hook — One Line

```
createState()           → creates State object — called once
initState()             → setup — called once — no context for navigation
didChangeDependencies() → context ready — InheritedWidget changed
build()                 → draws UI — called many times
didUpdateWidget()       → parent rebuilt with new props — compare old vs new
deactivate()            → removed from tree — still mounted — might come back
dispose()               → permanent death — cleanup everything — mounted = false
```

---

## 3. mounted

```
mounted = true  → State attached to Element → safe to setState
mounted = false → State detached           → never call setState

deactivate() → mounted = true  still
dispose()    → mounted = false
```

---

## 4. The Most Asked Interview Question

"What happens if you call setState after dispose?"

```
Debug   → FlutterError: setState() called after dispose() — red screen
Release → silent — memory leaks, unpredictable behavior
Fix     → if (!mounted) return;
```

---

## 5. Context Safety

```
initState()    → ❌ no navigation/dialogs
               → ✅ use addPostFrameCallback instead

after await    → ❌ widget might be dead
               → ✅ always check mounted first
```

---

## 6. deactivate vs dispose

```
deactivate  → temporary — pause things   — mounted = true
dispose     → permanent — cleanup things — mounted = false
```

---

## 7. What Goes Where

```
initState()       → init variables, API calls, stream subscriptions
dispose()         → cancel timers, cancel streams, dispose controllers
build()           → UI only — never put side effects here
didUpdateWidget() → react to prop changes from parent
```

---

## 8. The Golden Pattern — Production Ready

```dart
@override
void initState() {
  super.initState();
  _loadData();
}

Future<void> _loadData() async {
  final data = await api.getData();
  if (!mounted) return;        // ✅ always
  setState(() => _data = data);
}

@override
void dispose() {
  _controller.dispose();       // ✅ controllers
  _timer?.cancel();            // ✅ timers
  _subscription?.cancel();     // ✅ streams
  super.dispose();             // ✅ always last
}
```

---

## 9. One Line Answers for Interview

```
What is mounted?
→ bool that checks if State is still attached to its Element

When is mounted false?
→ after dispose() is called

Why check mounted after await?
→ widget might be disposed during the async gap

What does deactivate mean?
→ widget removed from tree but not dead — might be reinserted

What is the difference between deactivate and dispose?
→ deactivate = temporary removal, dispose = permanent death

Where do you do cleanup?
→ always in dispose(), never in deactivate()

Is context safe in initState?
→ not for navigation — use addPostFrameCallback instead
```