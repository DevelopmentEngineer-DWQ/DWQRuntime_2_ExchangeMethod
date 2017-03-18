# DWQRuntime_2_ExchangeMethod
Runtime交换方法的简单实现
![DWQ-LOGO.jpeg](http://upload-images.jianshu.io/upload_images/2231137-1545493cd60adb2b.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##引述
  在通常开发过程中，我们经常会用到系统类，而它提供的方法又不能完全满足我们开发的需要，那么在此时，我们需要为系统自带的方法扩展一些功能，而且还要保证原有的功能可正常使用.假设咱们现在有这么一个需求，我们在调用系统的[UIImage imageNamed:@"runtime"];的时候，我们并不能判断有没有加载成功，所以我们想在加载图片的时候并判断是否加载成功。

##解决方案
- 1.我想多数读者首先想到的就是运用分类，添加一个自定义方法来实现这个功能。 
步骤1.创建一个UIimage的分为，在.h文件中声明一个方法,并在.m文件中实现这个方法

```objective-c
//.h文件中声明
+(UIImage *)dwq_imageNamed:(NSString *)imageName;
//.m文件中实现
+(UIImage *)dwq_imageNamed:(NSString *)imageName{

   //首先加载图片
    UIImage *image=[UIImage imageNamed:imageName];
    
   //然后实现功能【判断是否为空】
  
    if (image==nil) {
        NSLog(@"图片为空");
    }
    return image;
}


```
 步骤2.在需要使用的地方，引入分类头文件，然后调用类方法
```objective-c
#import "UIImage+DWQcategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage dwq_imageNamed:@"runtime"];
}
```
这样，我们就可以实现我们的功能需求，但是，我们最初的想法是想还是通过调用系统的方法来实现加载图片并判断是否加载成功，而且这里使用的话还要引入分类头文件。那么，接下里我们用第二种方法实现，利用Runtime交换方法来实现
- 2.Runtime交换方法，我们想通过调用系统的imageNamed方法的时候本质是调用dwq_imageNamed就可以了。
  步骤1.在分类加载的时候+（void）load；交换方法的实现
  步骤2.方法交换之前首先获取方法，因为交换方法的两个参数就是方法

```objective-c
//获取类方法：class_getClassMethod
   //获取实力方法：class_getInstanceMethod
    //IMP:方法的实现
    //1.首先获取方法
    /*参数说明*/
    // Class :哪个类的方法
    // SEL ：获取方法编号
    Method imageNameMethod=   class_getInstanceMethod([UIImage class], @selector(imageNamed:));
    Method dwq_imageNameMethod=   class_getClassMethod([UIImage class], @selector(dwq_imageNamed:));

```
  步骤3.交换方法

```objective-c
 //方法的交换
    method_exchangeImplementations(imageNameMethod, dwq_imageNameMethod);
```
  步骤4.如果此时你认为完事了，调用系统的imageNamed方法，会造成死循环。因为我们在自定义的方法中加载图片调用的就是系统的imageNamed的方法，此时应该修改代码如下：

![防止死循环.png](http://upload-images.jianshu.io/upload_images/2231137-085931c57fb1da3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)
##Runtime交换方法效果

![交换方法.png](http://upload-images.jianshu.io/upload_images/2231137-4d33d41e5c07b416.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)
