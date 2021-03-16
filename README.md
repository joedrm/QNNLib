### 私有库的内容结构
私有组件库，目前主要存放四个模块代码：
- Base：基类，桥接文件
- Extension：项目中使用到的分类
- UIComponents：封装UI组件库，常用的父类等
- VenderLib：第三方库，如：加密解密签名验签的库
- Tools：工具库，如：数据缓存处理、文件操作等


### 使用？

```Ruby
pod 'QNNLib'
```

![](http://wx2.sinaimg.cn/mw690/0060lm7Tly1fzs76e5muqj30l407mq4l.jpg)


### 时间线

| tag | time | desc |
| --- | --- | --- |
| 0.1.2 | 2019年02月02日 | 新增NotificationCenter，发送和接受通知更安全；添加Reusable，更方便的注册和重用cell，Example搭建基本结构，编写测试代码|
| 0.1.1 | 2019年01月07日 | 添加Base模块，新增分类的写法，文档添加怎么更新私有库等功能 |
| 0.1.0 | 2018年12月29日 | 私有库初始化，搭建私有库结构 |
