# Flutter Keys — Interview Cheat Sheet

---

## 1. What is a Key?

```
Without Key → Flutter identifies widgets by TYPE + POSITION
With Key    → Flutter identifies widgets by IDENTITY

Key tells Flutter: "don't track this widget by position,
                    track it by ME"
```

---

## 2. Why Do We Need Keys?

```
Same type + same level + has State + reorder/remove = USE A KEY

Without keys → Flutter reuses State by position → wrong State on wrong widget
With keys    → Flutter reuses State by identity  → correct State always
```

---

## 3. All Key Types — One Line Each

```
ValueKey(id)                   → identity by primitive value — '1' == '1'
ObjectKey(object)              → identity by object reference — same memory address
UniqueKey()                    → always unique — never equal to anything
GlobalKey<T>()                 → access State from anywhere outside widget tree
GlobalKey<ScaffoldState>()     → control Scaffold — openDrawer()
GlobalKey<NavigatorState>()    → navigate without context — from services/interceptors
GlobalKey<FormState>()         → validate and save forms
```

---

## 4. ValueKey vs ObjectKey

```
ValueKey  → compares by VALUE
            ValueKey('1') == ValueKey('1') ✅ true

ObjectKey → compares by REFERENCE (memory address)
            ObjectKey(user1) == ObjectKey(user2) ❌ false
            even if user1 and user2 have identical data

Rule:
  Have a unique ID?       → ValueKey(item.id)   ✅ always preferred
  No unique ID?           → ObjectKey(item)      ✅ use object reference
  Object comes from API?  → ValueKey(item.id)   ✅ safer — API returns new
                                                    object every call
```

---

## 5. UniqueKey

```
// force rebuild — reset State completely
Key _key = UniqueKey();

void reset() {
  setState(() => _key = UniqueKey()); // new key = Flutter destroys old State
}

MyWidget(key: _key)

⚠️ NEVER put UniqueKey() inside build() directly
   new key on every build = State destroyed every rebuild = bad performance
```

---

## 6. GlobalKey — Three Common Uses

```dart
// 1. Form validation
final _formKey = GlobalKey<FormState>();
Form(key: _formKey, child: ...)
_formKey.currentState!.validate();
_formKey.currentState!.save();

// 2. Open drawer programmatically
final _scaffoldKey = GlobalKey<ScaffoldState>();
Scaffold(key: _scaffoldKey, drawer: MyDrawer(), ...)
_scaffoldKey.currentState!.openDrawer();

// 3. Navigate without context — from services, interceptors, BLoC
final navigatorKey = GlobalKey<NavigatorState>();
MaterialApp(navigatorKey: navigatorKey, ...)
navigatorKey.currentState!.pushNamed('/login');
navigatorKey.currentState!.pushNamedAndRemoveUntil('/login', (r) => false);
```

---

## 7. GlobalKey — What It Gives You

```dart
_globalKey.currentState    // direct access to State object
_globalKey.currentContext  // direct access to BuildContext
_globalKey.currentWidget   // direct access to Widget
```

---

## 8. Scaffold Key vs Navigator Key

```
GlobalKey<ScaffoldState>   → controls Scaffold  → openDrawer(), openEndDrawer()
GlobalKey<NavigatorState>  → controls Navigator → push(), pop(), pushNamed()
GlobalKey<FormState>       → controls Form      → validate(), save(), reset()
```

---

## 9. Old Way vs New Way — SnackBar

```dart
// ❌ old — before Flutter 2.0
_scaffoldKey.currentState!.showSnackBar(SnackBar(...));

// ✅ new — Flutter 2.0+
ScaffoldMessenger.of(context).showSnackBar(SnackBar(...));
```

---

## 10. When to Use Each Key

```
ValueKey    → lists with unique IDs — reorder, add, remove items
ObjectKey   → no unique ID available — use object reference
UniqueKey   → force full widget reset — forms, animations
GlobalKey<ScaffoldState>  → openDrawer() from deep in tree
GlobalKey<NavigatorState> → navigate from service/interceptor/BLoC
GlobalKey<FormState>      → form validate() and save()
```

---

## 11. GlobalKey Real World — Navigator in Dio Interceptor

```dart
// auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // no context here — plain Dart class
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
    handler.next(err);
  }
}
```

---

## 12. One Line Answers for Interview

```
What is a Key in Flutter?
→ identity tag that helps Flutter match widgets to their State correctly

When do you need a Key?
→ same type, same level, has State, can be reordered or removed

Difference between ValueKey and ObjectKey?
→ ValueKey compares by value, ObjectKey compares by memory reference

When to use UniqueKey?
→ when you want to force a widget to fully reset its State

What is GlobalKey?
→ a key that gives direct access to State, context, and widget from anywhere

What replaced GlobalKey<ScaffoldState> for SnackBars?
→ ScaffoldMessenger.of(context).showSnackBar()

When do you use GlobalKey<NavigatorState>?
→ when you need to navigate without context — from services or interceptors

What does GlobalKey.currentState give you?
→ direct reference to the State object of the attached widget
```