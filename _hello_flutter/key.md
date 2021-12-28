---
title: "Key"
---

## 参考
[掘金 flutter key](https://juejin.im/post/6844903811870359559)

## PageStorageKey
当你有一个滑动列表，你通过某一个 Item 跳转到了一个新的页面，当你返回之前的列表页面时，你发现滑动的距离回到了顶部。这时候，给 Sliver 一个 PageStorageKey！它将能够**保持 Sliver 的滚动状态**。