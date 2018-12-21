# chaziyjsLib
<h1>近期更新:2018年12月21日</h1>
<p>1.添加对于WebView封装处理的PAWebView,更新了iOS12系统之后,苹果决定启动原来的UIWebView,但并不是UIWebView不可以使用.为了迎合系统的更新,决定统一使用WKWebView来作为web容器.PAWebView主要做的就是对于WKWebView中cookie与js交互等问题的处理,考虑的比较完善,所以决定引用,当然也做了适当修改.根据项目情况,将PAWebView做成可继承的Controller使用,提供新的代理方法增加其可复用性与可修改性<a hrep="https://blog.csdn.net/llyouss/article/details/79019104">原文地址</a></p>
<p>对DIYSegmentView进行修改,处理发现的bug,并增加新的样式,根据字符串长度改变按钮大小</p>
<p>封装了一个控件CustomInputView,可以自定义标题的TextField控件,类似于<达达教育>登录页面->账号输入页面</p>
<p>封装了CustomDatePikerView(时间选择器)</p>
<p>封装了CustomTextView,主要用于增加对当前文字字数显示与限制.placehold设置.</p>
<p>增加宏定义中的内容补充,增加对新手机型号的判断</p>

<h1>框架内集成方法 </h1>
<p>Foundation 是自己工作多年积攒的框架代码.内容包含了项目中常用的对字符串的处理->包括正则过滤字符串,计算字符串所占屏幕尺寸,字符串类型,显示字符串时的行数计算.</p>
<p>MD5加密与常见加密算法等.</p>
<p>还包括了对数组的鲁棒处理,使用runtime的exchangeMethod方法避免在使用removeObjectAtIndex方法和ObjectAtIndex方法中出现越界的情况;</p>
<p>使用runtime方法+block实现kvo,不需要管理remove方法.自监控dealloc.</p>
<p>框架内也引用了FD的自动计算cell高度并缓存的代码在 category->UIView->TableView目录下;</p>
<p>导航栏部分引用KMNavigationBar,实现不同样式Navigationbar的显示.</p>
<p>总结: </p>
<p>架构的核心部分是通过category来完成所有算法与UI扩充部分的.第三方库管理可以使用cocoapods</p>

<h2>如果需要使用该架构 请引用如下pod内容</h2>
<p>pod 'AFNetworking'</p>
<p>pod 'YYKit'</p>
<p>pod 'MJRefresh'</p>
<p>pod 'FLAnimatedImage'</p>
<p>pod 'SDWebImage','4.0.0'</p>
<p>pod 'SDWebImage/WebP'</p>
<p>pod 'FMDB'</p>
<p>pod 'VasSonic'</p>
<p>pod 'TYAttributedLabel'</p>
<p>pod 'YogaKit'</p>
<p>以上是整理的项目常用的cocoapods组建 分别对应网络请求 数据解析 刷新加载 图片加载与缓存 本地数据库 WebView优化 富文本与UI绘制.</p>
<h3>近期更新:</h3>
<p>1、AF网络请求的封装，增加Cache功能。Socket请求封装（封装内容基于项目需求）。</p>
<p>2、自定义SegmentView，动态修改选中按钮的相对位置。</p>
<p>3、Google令牌算法封装。由于项目中增使用动态令牌功能。所以专门查看了Google令牌的后台功能，从而根据绝密方式反向推测加密方式。是一种令牌算法的思路，可借鉴。</p>
<p>4、事件处理器。用于存储与查看需要执行的事件，在运行过程中，当我们可能同时获取到多个事件需要处理但又只能顺序或者插叙执行时使用该方法。</p>
<p>5、Base32与HMACSH1加密方法，用于Google令牌的加密算法中使用。</p>
