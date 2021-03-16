### 私有库的内容结构
私有组件库，目前主要存放四个模块代码：
- Base：基类，桥接文件
- Extension：项目中使用到的分类
- UIComponents：封装UI组件库，常用的父类等
- VenderLib：第三方库，如：加密解密签名验签的库
- Tools：工具库，如：数据缓存处理、文件操作等


### 怎么使用私有库？
由于需要快速更新和迭代这个私有库，避免长时间的去pod校验，暂时做本地依赖

    ```Ruby
    pod 'QNNLib'
    ```

![](http://wx2.sinaimg.cn/mw690/0060lm7Tly1fzs76e5muqj30l407mq4l.jpg)



### 怎么更新私有库？
本地依赖的时候，如给一个UIView添加分类，可直接在`Development Pods`文件中编辑，找到`UIView+Extension.swift`文件，添加如下代码，
```swift
extension QNN where Base : UIView {
    
    public func testView() {
        debugPrint("testView")
    }
    
    public func testView1() {
        debugPrint("testView")
    }
}
```
*cmd+r编译*，然后直接调用，也可以看到代码提示
```swift
let v = UIView()
v.qnn.testView()
```


![](http://wx2.sinaimg.cn/mw690/0060lm7Tly1fzs77kyhpgj30vo0g1akc.jpg)


> 关于`extension QNN where Base : UIView`的实现，[看这里](https://github.com/wangdongyang/QNNLib/master/QNNLib/Classes/Base/QNN.swift)




### 其它相关命令
本地校验私有库


    pod lib lint --sources='https://github.com/CocoaPods/Specs.git,https://github.com/wangdongyang/QNNLib.git'  --allow-warnings --verbose


安装打包插件
    
    sudo gem install cocoapods-packager

打包为.framework文件

    pod package QNNLib.podspec --force --spec-sources=https://github.com/wangdongyang/QNNLib.git,https://github.com/CocoaPods/Specs.Github

打包为.a文件

    pod package QNNLib.podspec --library --force --spec-sources=https://github.com/wangdongyang/QNNLib.git,https://github.com/CocoaPods/Specs.Github



### 为什么建这个私有库？
- 模块化代码，与业务代码分离，让项目结构更清晰，
- 单独测试和版本迭代，
- 后期做成静态库，减少包体积，加快编译速度



### 时间线

| tag | time | desc |
| --- | --- | --- |
| 0.1.2 | 2019年02月02日 | 新增NotificationCenter，发送和接受通知更安全；添加Reusable，更方便的注册和重用cell，Example搭建基本结构，编写测试代码|
| 0.1.1 | 2019年01月07日 | 添加Base模块，新增分类的写法，文档添加怎么更新私有库等功能 |
| 0.1.0 | 2018年12月29日 | 私有库初始化，搭建私有库结构 |
