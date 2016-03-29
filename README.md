# SKBFLoginViewController

用Swift写的一款登录界面，灵感来自于Uber老版本的登录界面。

背景图自动变换，登录、注册按钮在底部随键盘高度自动调整位置。

## 预览图

![https://github.com/talisk/SKBFLoginViewContoller/preview.gif](https://github.com/talisk/SKBFLoginViewContoller/preview.gif)

## 使用方法

1. 将Classes拖到你的项目中，替换你自己的图片。

2. `backgroundArray`和`blurEffectStyle`可在present前设置，也可不设置使用默认值。

   ``` swift
   let loginVC = SKBFLoginViewController.sharedInstance
   loginVC.blurEffectStyle = .Light
   loginVC.backgroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg"), UIImage(named: "img5.jpg")] 
   ```

3. 在需要弹出登录界面的地方调用：

   ```swift
   presentViewController(SKBFLoginViewController.sharedInstance, animated: true, completion: nil)
   ```

4. 如果有需要，可在`controlSetup()`方法中修改控件布局。

注意：`backgroundArray`本身有默认值，可不再设置，但绝不可传入空数组。

## 版权

使用MIT许可协议。转载请注明出处。talisk斯温 http://www.talisk.cn/