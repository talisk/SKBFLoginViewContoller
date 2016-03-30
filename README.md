# SKBFLoginViewController

用Swift写的一款登录界面，灵感来自于Uber老版本的登录界面。

背景图自动变换，登录、注册按钮在底部随键盘高度自动调整位置。

## 预览图

![https://github.com/talisk/SKBFLoginViewContoller/blob/master/preview.gif](https://github.com/talisk/SKBFLoginViewContoller/blob/master/preview.gif)

## 使用方法

1. 将Classes拖到你的项目中，替换你自己的图片。

2. `backgroundArray`和`blurEffectStyle`可在present前设置，也可不设置使用默认值。

   ``` swift
   let loginVC = SKBFLoginViewController.sharedInstance
   loginVC.blurEffectStyle = .Light
   loginVC.backgroundArray = 
   	[UIImage.init(contentsOfFile: NSBundle.mainBundle().pathForResource("img1", ofType: "jpg")!)!,
   	 UIImage.init(contentsOfFile: NSBundle.mainBundle().pathForResource("img2", ofType: "jpg")!)!,
   	 UIImage.init(contentsOfFile: NSBundle.mainBundle().pathForResource("img3", ofType: "jpg")!)!,
   	 UIImage.init(contentsOfFile: NSBundle.mainBundle().pathForResource("img4", ofType: "jpg")!)!,
   	 UIImage.init(contentsOfFile: NSBundle.mainBundle().pathForResource("img5", ofType: "jpg")!)!]
   ```

3. 在需要弹出登录界面的地方调用：

   ```swift
   presentViewController(SKBFLoginViewController.sharedInstance, animated: true, completion: nil)
   ```

4. 如果有需要，可在`controlSetup()`方法中修改控件布局。

注意：`backgroundArray`本身有默认值，可不再设置，但绝不可传入空数组。

## 注意

关于单例模式的视图控制器可能会长期消耗内存：

已经更新对该视图控制器dismiss后的内存管理做了优化，详见[iOS单例ViewController与UIImage对象内存优化](http://blog.talisk.cn/blog/2016/03/30/iOS-Singleton-ViewController-Performance-optimization/)。但您在使用时**请注意，设置背景图数组时请使用`UIImage.init(contentsOfFile:)`初始化方法构造图片对象**。

## 版权

使用MIT许可协议。转载请注明出处。talisk斯温 http://www.talisk.cn/