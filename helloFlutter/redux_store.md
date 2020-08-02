# redux 

## 我的理解
* store 在最上层存储应用的一些状态信息
* reducer方法 改变应用状态信息,比如有个计数为1，可以通过调用reducer实现该计数+1。
* middleware 属于中间件，可以操控上例中的计数是否存入数据库之类的。
* store在被使用之前需要初始化, 需要三个参数：reducer, 初始化数据, middleware。
