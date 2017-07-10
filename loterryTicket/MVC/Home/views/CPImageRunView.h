//
//  CPImageRunView.h
//  runrool
//
//  Created by peng on 16/6/11.
//  Copyright © 2016年 peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPImageRunView;
@protocol CPImageRunViewDelegate <NSObject>

- (void)imageRunView:(CPImageRunView*)view didSelectedIndex:(NSInteger)index;

@end

@interface CPImageRunView : UIView

@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) UIImage *placeholderImage;
@property (nonatomic,assign) CGSize size;

@property (nonatomic,weak) id<CPImageRunViewDelegate> delegate;

- (void)run;

- (void)stop;

@end
