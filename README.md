# DSHPopupContainer

```
iOS客户端弹层容器  
主要是为了将弹层的自定义样式和动画效果与容器分离出来  
实际开发过程中可以专心考虑弹层的自定义样式和动画效果，使用这个工具用来进行弹出操作
```
#### 使用
* 创建一个自定义弹层，实现 DSHCustomPopupView 协议
```
@interface CustomView : UIView <DSHCustomPopupView>
@end

@implementation CustomView

// 自定义样式
- (id)init {
    ...
}

// 动画效果
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(288, 333);
    frame.origin.x = (container.frame.size.width - frame.size.width) * .5;
    frame.origin.y = (container.frame.size.height - frame.size.height) * .5;
    self.frame = frame;
}
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}

@end
```
* 在需要弹出的位置创建弹层容器
```
CustomView *customView = [[CustomView alloc] init];
DSHPopupContainer *container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
[container show];
```
* Demo 效果图  
  
![image](https://github.com/568071718/DSHPopupContainer/blob/master/Resources/s.gif)
