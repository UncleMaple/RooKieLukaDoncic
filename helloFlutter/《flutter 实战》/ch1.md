# CH1总结

<!-- TOC -->

- [CH1总结](#ch1总结)
    - [升级Flutter SDK和依赖包](#升级flutter-sdk和依赖包)
    - [连接ios模拟器](#连接ios模拟器)
    - [ios配置Xcode签名](#ios配置xcode签名)
    - [Dart](#dart)
        - [const vs final vs static](#const-vs-final-vs-static)
        - [async/await](#asyncawait)
        - [Stream](#stream)

<!-- /TOC -->

## 升级Flutter SDK和依赖包
1. `flutter upgrade` 升级sdk
1. `flutter packages get` 获取项目所有依赖包
1. `flutter packages upgrade` 获取项目所有依赖包的最新版本

## 连接ios模拟器
`open -a Simulator` 打开一个ios模拟器

## ios配置Xcode签名
1. `open ios/Runner.xcwordspace`
1. 点`Runner`
1. **General > Signing > Team** 下选择你的开发团队

## Dart
### const vs final vs static
const 比 final 更严格，修饰对象必须是编译时常量,static只用于修饰类成员变量
1. [Dart：修饰符 static final const](https://www.jianshu.com/p/91c2511d104f)
1. [Dart 中 final 和 const 区别](https://blog.csdn.net/wcy23580/article/details/96195503)

### async/await
```dart
task() async {
   try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作   
   } catch(e){
    //错误处理   
    print(e);   
   }  
}
```
1. async用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数。

1. await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；await必须出现在 async 函数内部。

### Stream
Stream 也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果（成功或失败）。 也就是说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。 Stream 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。举个例子：
```dart
Stream.fromFutures([
  // 1秒后返回结果
  Future.delayed(new Duration(seconds: 1), () {
    return "hello 1";
  }),
  // 抛出一个异常
  Future.delayed(new Duration(seconds: 2),(){
    throw AssertionError("Error");
  }),
  // 3秒后返回结果
  Future.delayed(new Duration(seconds: 3), () {
    return "hello 3";
  })
]).listen((data){
   print(data);
}, onError: (e){
   print(e.message);
},onDone: (){

});

// output:

// I/flutter (17666): hello 1
// I/flutter (17666): Error
// I/flutter (17666): hello 3
```