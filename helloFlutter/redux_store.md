# Dart's Redux 

## demo

```dart
import 'package:redux/redux.dart';

// Create typed actions. You will dispatch these in order to
// update the state of your application.
enum Actions {
  increment,
  decrement,
}

// Create a Reducer. A reducer is a pure function that takes the 
// current State (int) and the Action that was dispatched. It should
// combine the two into a new state without mutating the state passed
// in! After the state is updated, the store will emit the update to 
// the `onChange` stream.
// 
// Because reducers are pure functions, they should not perform any 
// side-effects, such as making an HTTP request or logging messages
// to a console. For that, use Middleware.
int counterReducer(int state, action) {
  if (action == Actions.increment) {
    return state + 1;
  } else if (action == Actions.decrement) {
    return state - 1;
  }
  
  return state;
}

// A piece of middleware that will log all actions with a timestamp
// to your console!
// 
// Note, this is just an example of how to write your own Middleware.
// See the redux_logging package on pub for a pre-built logging 
// middleware.
loggingMiddleware(Store<int> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');

  next(action);
}

main() {
  // Create the store with our Reducer and Middleware
  final store = new Store<int>(
    counterReducer, 
    initialState: 0, 
    middleware: [loggingMiddleware],
  );

  // Render our State right away
  render(store.state);
  
  // Listen to store changes, and re-render when the state is updated
  store.onChange.listen(render);

  // Attach a click handler to a button. When clicked, the `INCREMENT` action
  // will be dispatched. It will then run through the reducer, updating the 
  // state.
  //
  // After the state changes, the html will be re-rendered by our `onChange`
  // listener above. 
  querySelector('#increment').onClick.listen((_) {
    store.dispatch(Actions.increment);
  });
}

render(int state) {
  querySelector('#value').innerHtml = '${state}';
}
```

## 参考
[redux pub官网](https://pub.dev/packages/redux)

[Beltran的博客](https://beltran.work/blog/building-a-messaging-app-in-flutter-part-iii-redux/)

## The Basics of Redux
A typical Redux solution is structured in four parts:

1. The application state or AppState. It stores the global state in a single place and it is located in what is called the Store.

2. A set of Actions. They define what you can do and which parameters you need to pass. For example, SendMessage. Actions trigger Reducers and Middleware functions.

3. A set of Reducers: These are functions that change the AppState.

4. A set of Middleware functions: These are functions that run “side effects” like updating a database or send data online.

## 我的理解
* store 在最上层存储应用的一些状态信息。
* reducer方法 改变应用状态信息,比如有个计数为1，可以通过调用reducer实现该计数+1。
* middleware 属于中间件，可以操控上例中的计数是否存入数据库之类的。
* store在被使用之前需要初始化, 需要三个参数：reducer, 初始化数据, middleware。
