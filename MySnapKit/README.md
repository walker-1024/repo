### 看了看SnapKit的源码，被绕得迷迷糊糊的，大概按照源码的思路，按自己的方式实现了几个功能：

#### 操作对象有：

* leading
* trailing
* top
* bottom
* width
* height
* centerX
* centerY

#### 操作方式有：

* equalToSuperview() 让其attribute等于其父视图相应的attribute
* equalTo(**_** constant: CGFloat) 让其attribute在父视图相应attribute的基础上增加constant（width、height除外，此二者是设置值为constant）

* equalTo(**_** viewB: UIView) 让其attribute等于viewB相应的attribute