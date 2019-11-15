//
//  JPPopMenuView.h
//  JPPopMenuDemo
//
//  Created by pxzline on 16/12/30.
//  Copyright © 2016年 pxzline. All rights reserved.
//
/**
 *  自定义的一个PopView（弃用）
 *
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JPPopMenuType) {
    JPPopMenuType_default = 1 >> 0,
    JPPopMenuType_dark = 1 >> 1
};

@class JPPopMenuView;
@protocol JPPopMenuViewDelegate <NSObject>
//点击事件回调事件
- (void)popUpMenuDidSelectedAtIndex:(NSInteger)index popMenuView:(JPPopMenuView *)view;
@end

@interface JPPopMenuView : UIView

//圆角半径
@property (nonatomic, assign) CGFloat cornerRadius;
//是否显示阴影
@property (nonatomic, assign, getter=isShadowShowing) BOOL isShadowShow;
//选择菜单选项后，自动消失
@property (nonatomic, assign) BOOL dismissOnSelected;
//点击菜单外消失
@property (nonatomic, assign) BOOL dismissOnTouchOutside;
//设置字体大小
@property (nonatomic, assign) CGFloat fontSize;
//设置字体颜色
@property (nonatomic, strong) UIColor *textColor;
//设置偏移距离
@property (nonatomic, assign) CGFloat offset;
//设置显示模式
@property (nonatomic, assign) JPPopMenuType type;
//设置代理
@property (nonatomic, assign) id<JPPopMenuViewDelegate> delegate;

- (instancetype)initWithTitle:(NSArray *)titles
                        icons:(NSArray *)icons
                    menuWidth:(CGFloat)itemWidth
                     delegate:(id<JPPopMenuViewDelegate>)delegate;

+ (instancetype)showAtPoint:(CGPoint)point
                     titles:(NSArray *)titles
                      icons:(NSArray *)icons
                  menuWidth:(CGFloat)itemWidth
                   delegate:(id<JPPopMenuViewDelegate>)delegate;

+ (instancetype)showOnView:(UIView *)view
                        titles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<JPPopMenuViewDelegate>)delegate;
- (void)showAtPoint:(CGPoint)point;
- (void)showOnView:(UIView *)view;
- (void)dismiss;
@end
