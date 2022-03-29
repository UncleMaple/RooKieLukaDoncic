---
title: "《flutter实战》CH2总结"
excerpt: ""
date: 2021-12-30 15:30:00 +0800
---

<!-- TOC -->

- [CH2小结](#ch2小结)
    - [路由管理](#路由管理)
        - [示例](#示例)
        - [MaterialPageRoute](#materialpageroute)
        - [Navigator](#navigator)
        - [命名路由](#命名路由)
        - [路由钩子](#路由钩子)
    - [包管理](#包管理)
        - [包管理配置文件`pubspec.yml`](#包管理配置文件pubspecyml)
        - [下载包](#下载包)
        - [其他依赖方式](#其他依赖方式)
    - [资源管理](#资源管理)
    - [调试Flutter APP](#调试flutter-app)
    - [Dart线程模型及异常捕获](#dart线程模型及异常捕获)
        - [Dart单线程模型](#dart单线程模型)
        - [Flutter异常捕获](#flutter异常捕获)

<!-- /TOC -->

## 路由管理
### 示例
```dart
onPressed: () {
  Navigator.push(context,
    MaterialPageRoute(builder:    (context){
      return NewRoute();
    })
  );  
}
```

### MaterialPageRoute
* 继承自PageRoute，自定义路由切换需要继承自PageRoute
* 构造函数
```dart
MaterialPageRoute({
    WidgetBuilder builder, // 构建路由页面的具体内容,返回一个widget
    RouteSettings settings, // 包含路由配置信息，如路由名称
    bool maintainState = true,// 设为false，在路由没用的时候释放资源
    bool fullscreenDialog = false, // 是否全屏模态对话框，设为true，ios新页面改为从底部滑入
  })
```

### Navigator
* 路由入栈 `Future push(BuildContext context, Route route)`
* 栈顶路由出栈 `bool pop(BuildContext context, [result]` **result**为页面关闭时返回给上一个页面的数据

* 实例方法 `Navigator.push(BuildContext context, Route route)` 等价于 `Navigator.of(context).push(Route route)`

### 命名路由
* 路由表是一个哈希map `Map<String, WidgetBuilder> routes;`
* 注册路由表
```dart
initialRoute:"/", //名为"/"的路由作为应用的home(首页)

//注册路由表
routes:{
"new_page":(context) => NewRoute(),
"/":(context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
} 
```

* 通过路由名打开新路由页 `Navigator.pushNamed(context, "new_page")`

* 命名路由传递参数 (**!!!没搞懂用法，待实践**)
```dart
// 声明一个路由
routes{
    "new_page": (context) => EchoRoute()
}

// 路由定义
class EchoRoute extends Stateless {
    @override
    Widget build(BuildContext context) {
        // 获取路由参数
        var args = ModalRoute.of(context).settings.arguments;
        // 省略无关代码
    }
}

// 在打开路由页时传参“hi”
Navigator.of(context).pushNamed("new_page", arguments: "hi")

// ======================================

// 适配
MaterialApp(
  ... // 省略无关代码
  routes: {
   "tip2": (context){
     return TipRoute(text: ModalRoute.of(context).settings.arguments); // 如果TipRoute接受一个参数可以由调用页来传入
   },
 }, 
);

// 在打开路由页时传参"我是传参"
Navigator.of(context).pushNamed("tips2", arguments: "我是传参")
```

### 路由钩子
* `onGenerateRoute`在打开命名路由时，如果打开的命名路由没有在路由表中注册，则会调用；反之，不调用。由此可以**用作钩子判断登录状态**
```dart
MaterialApp(
  ... //省略无关代码
  onGenerateRoute:(RouteSettings settings){
      return MaterialPageRoute(builder: (context){
           String routeName = settings.name;
       // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
       // 引导用户登录；其它情况则正常打开路由。
     }
   );
  }
);
```
* 可以通过onGenerateRoute做一些全局的路由跳转前置处理逻辑。
* **？？？疑问：** 如何判断登录状态？ 通过哪个参数？

## 包管理

### 包管理配置文件`pubspec.yml`

### 下载包
填好配置文件后点击android studio `Packages get`按钮 或者 终端`flutter packages get`

### 其他依赖方式
1. 依赖本地包， 包名为`pkg1`
```yaml
dependecies:
  pkg1:
    path: ../../code/pkg1
```
2. 依赖git， 包名为`pkg2`
```yaml
dependecies:
  pkg2:
    git:
      # case1 假定包位于存储库根目录
      url: git://github.com/xxx/pkg2.git
      # case2 不是位于根目录
      url: git://github.com/xxx/blahblahs.git
      path: blahblahs/pkg2
```

## 资源管理
调用图片文字资源之类的，很琐碎，使用时翻阅下apidoc或者[这里](https://book.flutterchina.club/chapter2/flutter_assets_mgr.html)
## 调试Flutter APP
## Dart线程模型及异常捕获
### Dart单线程模型
![dart单线程模型](https://pcdn.flutterchina.club/imgs/2-12.png)

在事件循环中，当某个任务发生异常并没有被捕获时，程序并不会退出，而直接导致的结果是当前任务的后续代码就不会被执行了，也就是说一个任务中的异常是不会影响其它任务执行的。

### Flutter异常捕获
**??? 看的晕晕乎乎, 待实践..**
```dart
void collectLog(String line){
    ... //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details){
    ... //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
    ...// 构建错误信息
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}
```
