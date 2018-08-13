# chaziyjsLib
框架内集成方法 \n
Foundation 是自己工作多年积攒的框架代码.内容包含了项目中常用的对字符串的处理->包括正则过滤字符串,计算字符串所占屏幕尺寸,字符串类型,显示字符串时的行数计算.\n
MD5加密与常见加密算法等.\n
还包括了对数组的鲁棒处理,使用runtime的exchangeMethod方法避免在使用removeObjectAtIndex方法和ObjectAtIndex方法中出现越界的情况;\n
使用runtime方法+block实现kvo,不需要管理remove方法.自监控dealloc.\n
框架内也引用了FD的自动计算cell高度并缓存的代码在 category->UIView->TableView目录下;\n
导航栏部分引用KMNavigationBar,实现不同样式Navigationbar的显示.\n
总结: \n
架构的核心部分是通过category来完成所有算法与UI扩充部分的.第三方库管理可以使用cocoapods
如果需要使用该架构 请引用如下pod内容\n
pod 'AFNetworking'\n
pod 'YYKit'\n
pod 'MJRefresh'\n
pod 'FLAnimatedImage'\n
pod 'SDWebImage','4.0.0'\n
pod 'SDWebImage/WebP'\n
pod 'FMDB'\n
pod 'VasSonic'\n
pod 'TYAttributedLabel'\n
pod 'YogaKit'\n
以上是整理的项目常用的cocoapods组建 分别对应网络请求 数据解析 刷新加载 图片加载与缓存 本地数据库 WebView优化 富文本与UI绘制.\n
近期更新:\n
1、AF网络请求的封装，增加Cache功能。Socket请求封装（封装内容基于项目需求）。
2、自定义SegmentView，动态修改选中按钮的相对位置。
3、Google令牌算法封装。由于项目中增使用动态令牌功能。所以专门查看了Google令牌的后台功能，从而根据绝密方式反向推测加密方式。是一种令牌算法的思路，可借鉴。
4、事件处理器。用于存储与查看需要执行的事件，在运行过程中，当我们可能同时获取到多个事件需要处理但又只能顺序或者插叙执行时使用该方法。
5、Base32与HMACSH1加密方法，用于Google令牌的加密算法中使用。
