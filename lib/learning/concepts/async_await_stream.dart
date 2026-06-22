     
  /*
  Q. the correct work of async keyword

  Future<void> myFunction() async {
  print('1. Start');
  final data = await fetchData();
  print('2. Got data');
}

// ✅ Case 1 — main is normal void, no await allowed
void main() {
  myFunction();            // no await, just fire and forget
  print('App is alive!'); // runs immediately
}

// ✅ Case 2 — main is async, await is allowed
Future<void> main() async {
  await myFunction();      // now main itself waits
  print('After done');     // runs AFTER myFunction fully finishes
}

==========> output here 

Case 1 — void main() without await
1. Start
App is alive!       👈 runs before myFunction finishes
2. Got data

Case 2 — Future<void> main() async with await
1. Start
2. Got data
App is alive!       👈 runs AFTER myFunction fully finishes
   */

 // ================================================================================================

  /*
  Q. what does  WidgetsFlutterBinding.ensureInitialized()  do
One Line Summary
WidgetsFlutterBinding.ensureInitialized() = "Hey Flutter, wake up and get ready — I need to do some setup before the UI starts."
Without it, you're trying to use a phone before turning it on.
   */


  // ================================================================================================
  /*
   Q. about stream & yield
  Stream<int> countDown() async* {
  for (int i = 5; i >= 0; i--) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // sends value, stays alive
  }
} 
   */











  