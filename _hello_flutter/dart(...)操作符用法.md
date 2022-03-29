---
title: "Dart三个点(...)操作符用法"
excerpt: ""
date: 2021-12-30 15:30:00 +0800
---

考虑下面一种情况,现在有三个Text Widgets List:
```dart
List<Widget> northAmericanCountries = [
  Text('USA'),
  Text('Canada'),
];

List<Widget> asianCountries = [
  Text('India'),
  Text('China'),
];

List<Widget> europeanCountries = [
  Text('France'),
  Text('Germany'),
  Text('Italy'),
];
```

如果我们把三个List添加到一个Row Widget里，通常需要这么做：

```dart
Row(
  children: northAmericanCountries
            ..addAll(asianCountries)
            ..addAll(europeanCountries),
)
```

现在有个需求是要把asianCountries放在northAmericanCountries前面, 你需要这么去改：

```dart
Row(
  children: asianCountries
            ..addAll(northAmericanCountries)
            ..addAll(europeanCountries),
)
```

你需要重新排列addAll方法的顺序，这非常不方便。

那么，我们的...操作符来了！通过它你可以轻松实现以上操作:
```dart
Row(
  children: [
              ...northAmericanCountries,
              ...asianCountries,
              ...europeanCountries
            ],
)
```

重新排序需要做的操作：
```dart
Row(
  children: [
              ...asianCountries,
              ...northAmericanCountries,
              ...europeanCountries
            ],
)
```
