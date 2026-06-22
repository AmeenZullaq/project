/*
🧠 What is BuildContext?
In Flutter, BuildContext is a handle to the location of a widget in the widget tree.
It's how Flutter knows where in the widget tree something is, and what widgets are above or below it.


📦 When You Do:
Theme.of(context).primaryColor
You're asking Flutter:
"Hey Flutter, starting from this widget's location (context), go up the widget tree and find the nearest Theme widget — then give me its primaryColor."
 

 1 What Happens Under the Hood?
Theme.of(context) is a static method.

It uses context.dependOnInheritedWidgetOfExactType<Theme>().

This walks up the tree from context, looking for a Theme widget (which is an InheritedWidget).

Once it finds it, it returns the data inside — like primaryColor.

Same thing happens for MediaQuery.of(context) — it grabs the nearest MediaQuery widget.
 
 
 🔄 Why is This Powerful?
Because any widget above you in the tree can provide values to widgets below, without having to pass them manually — thanks to InheritedWidget and BuildContext.


🧱 Visual Example
dart
Copy
Edit
MaterialApp(
  theme: ThemeData(primaryColor: Colors.blue),
  home: Builder(
    builder: (context) {
      final color = Theme.of(context).primaryColor; // 🟦 blue!
      final size = MediaQuery.of(context).size;     // 📐 Screen size

      return Container(color: color, width: size.width);
    },
  ),
)
context in the Builder is used to access the theme and screen size above it.
 */
