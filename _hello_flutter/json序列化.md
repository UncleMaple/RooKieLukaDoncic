---
title: "Json序列化"
excerpt: "官方荐用json_serializable插件,项目使用了built_value."
date: 2021-12-30 15:30:00 +0800
---

<br>
<!-- TOC -->

- [官方荐用json_serializable插件](#官方荐用json_serializable插件)
- [项目使用了built_value](#项目使用了built_value)

<!-- /TOC -->
<br>

## 官方荐用json_serializable插件
[官方文档](https://flutter.dev/docs/development/data-and-backend/json)


## 项目使用了built_value
[built_value](https://pub.dev/packages/built_value)
* 优点：
    1. 不可变值类型
    1. EnumClass, 操作类似enum
    1. json序列化

* 参考链接:
    1. [built_value官方文档](https://pub.dev/packages/built_value)
    1. [flutter - built_value自动生成模型](https://juejin.im/post/6844904101977800717)
    1. [Dart 处理json，built_value库](https://www.cnblogs.com/ajanuw/p/10484605.html)

* 自己在android studio中新建了一个live template, 输入`built_value`即可快速生成model class模版:
    ```dart
    // 模版内容
    // 配置在 perference -> Editor -> Live Templates -> flutter 新建命名为 built_value
    // Template Text 填入以下代码
    // edit variables -> CLASS_NAME_CAMELCASE对应expression为 camelCase(CLASS_NAME)
    abstract class $CLASS_NAME$ implements Built<$CLASS_NAME$, $CLASS_NAME$Builder> {
    static Serializer<$CLASS_NAME$> get serializer => _$$$CLASS_NAME_CAMELCASS$Serializer;

    String toJson() {
        return json.encode(serializers.serializeWith($CLASS_NAME$.serializer, this));
    }

    factory $CLASS_NAME$.fromJson(String jsonString) {
        return serializers.deserializeWith(
        $CLASS_NAME$.serializer,
        json.decode(jsonString),
        );
    }

    Map<String, dynamic> toMap() {
        return serializers.serializeWith($CLASS_NAME$.serializer, this);
    }

    factory $CLASS_NAME$.fromMap(Map<String, dynamic> map) {
        return serializers.deserializeWith(
        $CLASS_NAME$.serializer,
        map,
        );
    }

    $CLASS_NAME$._();
    factory $CLASS_NAME$([void Function($CLASS_NAME$Builder) updates]) = _$$$CLASS_NAME$;
    }
    ```


* 备注:
    ```dart
    @nullable // 表示该字段可空
    @BuiltValueField(wireName: 'updated_at') // 解析的json中字段对应蛇形格式，映射为驼峰
    String get updatedAt;
    ```

* model写完后生成*.g.dart的命令:
    ```dart
    flutter packages pub run build_runner build   // 执行一次build命令
    
    flutter packages pub run build_runner watch  // 文件更改自动build
    
    flutter packages pub run build_runner watch --delete-conflicting-outputs  // 删除旧文件在build
    
    ```
