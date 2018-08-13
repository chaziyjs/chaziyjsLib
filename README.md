# chaziyjsLib
框架内集成方法
Foundation 是自己工作多年积攒的框架代码.内容包含了项目中常用的对字符串的处理->包括正则过滤字符串,计算字符串所占屏幕尺寸,字符串类型,显示字符串时的行数计算.
MD5加密与常见加密算法等.
还包括了对数组的鲁棒处理,使用runtime的exchangeMethod方法避免在使用removeObjectAtIndex方法和ObjectAtIndex方法中出现越界的情况;
使用runtime方法+block实现kvo,不需要管理remove方法.自监控dealloc.
框架内也引用了FD的自动计算cell高度并缓存的代码在 category->UIView->TableView目录下;
导航栏部分引用KMNavigationBar,实现不同样式Navigationbar的显示.
总结:
架构的核心部分是通过category来完成所有算法与UI扩充部分的.第三方库管理可以使用cocoapods
如果需要使用该架构 请引用如下pod内容
pod 'AFNetworking'
pod 'YYKit'
pod 'MJRefresh'
pod 'FLAnimatedImage'
pod 'SDWebImage','4.0.0'
pod 'SDWebImage/WebP'
pod 'FMDB'
pod 'VasSonic'
pod 'TYAttributedLabel'
pod 'YogaKit'
以上是整理的项目常用的cocoapods组建分别对应网络请求数据解析刷新加载图片加载与缓存本地数据库WebView优化富文本与UI绘制。
近期更新




