//
//  UIViewController+PrintViewController.m
//  FZQ
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 ChenXinCun. All rights reserved.
//

#import "UIViewController+PrintViewController.h"
#import <objc/runtime.h>

#if TARGET_IPHONE_SIMULATOR
#import "Aspects.h"
#endif

@implementation UIViewController (PrintViewController)

#if DEBUG
+ (void)load{
    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    /**
     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
     */
    if (!class_addMethod([self class], @selector(swizzlingViewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
    #if TARGET_IPHONE_SIMULATOR
    [self aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id instance, NSArray *args) {
        
        NSLog(@"♦️%@控制器销毁成功♦️",instance);
        
    } error:NULL];
    #endif
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad {
    [self swizzlingViewDidLoad];
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
        
        NSLog(@"♦️%@控制器加载完毕♦️",self);
    }
}
#endif

@end

