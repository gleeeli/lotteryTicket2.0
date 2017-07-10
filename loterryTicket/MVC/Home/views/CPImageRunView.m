//
//  CPImageRunView.m
//  runrool
//
//  Created by peng on 16/6/11.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "CPImageRunView.h"
#import "UIImageView+WebCache.h"

typedef enum : NSUInteger {
    DirectionNone,
    DirectionLeft,
    DirectionRight,
} ScrollDirection;


@interface CPImageRunView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageViewRight;
@property (nonatomic,strong) UIImageView *imageViewLeft;
@property (nonatomic,strong) UIView *maskView;


@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,assign) CGFloat initialX;
@property (nonatomic,assign) BOOL isEndScroll;
@property (nonatomic,assign) BOOL isScrolling;


@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) ScrollDirection direction;

@property (nonatomic,strong) NSTimer *runTimer;

@end

@implementation CPImageRunView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initViews:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        

        [self initViews:frame];
    }
    return self;
}

- (void)initViews:(CGRect)frame{
    
    _scrollView=[[UIScrollView alloc] initWithFrame:frame];
    _scrollView.delegate=self;
    _scrollView.pagingEnabled=YES;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [_scrollView setContentSize:CGSizeMake(frame.size.width*2, frame.size.height)];
    
    [self addSubview:_scrollView];
    
    
    _imageViewLeft=[[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    _imageViewLeft.layer.shadowOffset = CGSizeMake(0, 1);
    _imageViewLeft.layer.shadowOpacity = 0.50;
    _imageViewLeft.contentMode = UIViewContentModeScaleAspectFill;
    
    UITapGestureRecognizer *viewTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewTap:)];
    _imageViewLeft.userInteractionEnabled=YES;
    [_imageViewLeft addGestureRecognizer:viewTap];
    
    _imageViewRight=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.origin.y, frame.size.width, frame.size.height)];
    _imageViewRight.layer.shadowOffset = CGSizeMake(0, 1);
    _imageViewRight.layer.shadowOpacity = 0.50;
    _imageViewRight.contentMode = UIViewContentModeScaleAspectFill;
    
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _maskView.backgroundColor=[UIColor whiteColor];
    _maskView.alpha=0.5;
    [_imageViewRight addSubview:_maskView];
    
    
    [_scrollView addSubview:_imageViewRight];
    [_scrollView addSubview:_imageViewLeft];
    
    
    
    _pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
    _pageControl.center=CGPointMake(frame.size.width/2, frame.size.height-15);
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.tintColor = [UIColor whiteColor];
    
    [self addSubview:_pageControl];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage=placeholderImage;
    _imageViewLeft.image=_placeholderImage;
    _imageViewRight.image=_placeholderImage;
}

- (void)setSize:(CGSize)size{
    
    CGRect frame=CGRectMake(0, 0,size.width,size.height);
    
    self.frame=frame;
    self.scrollView.frame=CGRectMake(0, 0, size.width, size.height);
    [self.scrollView setContentSize:CGSizeMake(size.width*2, size.height)];
    
    self.imageViewLeft.frame=CGRectMake(0, 0, size.width, size.height);
    self.imageViewRight.frame=CGRectMake(size.width/2, 0, size.width, size.height);
    self.pageControl.frame=CGRectMake(0, size.height-25, size.width, 20);
}

- (void)setImages:(NSArray *)images{
    if (images.count>0) {
        _images=images;
        _pageControl.numberOfPages=images.count;
        self.currentPage=0;
        self.pageControl.currentPage=0;
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{
    
    _currentPage=currentPage;
    if (_currentPage==_images.count) {
        _currentPage=0;
    }
    
    if (_currentPage<0) {
        
        _currentPage=0;
        
        [_imageViewLeft sd_setImageWithURL:[NSURL URLWithString:_images[_images.count-1]] placeholderImage:_placeholderImage];
        [_imageViewRight sd_setImageWithURL:[NSURL URLWithString:_images[_currentPage]] placeholderImage:_placeholderImage];
//        _imageViewLeft.image=_images[_images.count-1];
//        _imageViewRight.image=_images[_currentPage];
        _currentPage=_images.count-1;
        
    }else if (_currentPage==_images.count-1) {
        
        [_imageViewLeft sd_setImageWithURL:[NSURL URLWithString:_images[_currentPage]] placeholderImage:_placeholderImage];
        [_imageViewRight sd_setImageWithURL:[NSURL URLWithString:_images[0]] placeholderImage:_placeholderImage];
//        _imageViewLeft.image=_images[_currentPage];
//        _imageViewRight.image=_images[0];
        
    }else{
        
        [_imageViewLeft sd_setImageWithURL:[NSURL URLWithString:_images[_currentPage]] placeholderImage:_placeholderImage];
        [_imageViewRight sd_setImageWithURL:[NSURL URLWithString:_images[_currentPage+1]] placeholderImage:_placeholderImage];
//        _imageViewLeft.image=_images[_currentPage];
//        _imageViewRight.image=_images[_currentPage+1];
    }
    
    
}

- (void)handleViewTap:(UITapGestureRecognizer *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageRunView:didSelectedIndex:)]) {
        [self.delegate imageRunView:self didSelectedIndex:self.currentPage];
    }
}

- (void)run{
    
    if (!_runTimer) {
        _runTimer=[NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_runTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)handleTimer{
    
    [UIView animateWithDuration:0.8f animations:^{
        
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    } completion:^(BOOL finished) {
        
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        _imageViewRight.transform=CGAffineTransformIdentity;
        
        self.isEndScroll=NO;
        self.isScrolling=NO;
        self.currentPage++;
        self.pageControl.currentPage=_currentPage;
        self.initialX=0;
    }];
    
}

- (void)stop{
    
    if (_runTimer) {
        if ([_runTimer isValid]) {
            [_runTimer invalidate];
            _runTimer=nil;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%f",scrollView.contentOffset.x);
    
    self.isScrolling=YES;
    
    CGFloat newX=scrollView.contentOffset.x;
    if (newX!=self.initialX) {
        if (newX<self.initialX) {
            //NSLog(@"left");
            self.direction=DirectionLeft;
            
            if (!self.isEndScroll) {
                self.currentPage--;
                [_scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
                self.initialX=scrollView.contentOffset.x;
                self.isEndScroll=YES;
            }
            
        }else{
            self.direction=DirectionRight;
            //NSLog(@"right");
        }
    }
    //NSLog(@"%f",1-scrollView.contentOffset.x/_maskView.frame.size.width);
    _maskView.alpha=1-scrollView.contentOffset.x/_maskView.frame.size.width;
    _imageViewRight.transform=CGAffineTransformMakeTranslation(scrollView.contentOffset.x/2, 0);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stop];
    
    //NSLog(@"scrollViewWillBeginDragging");
    
    
    if (!self.isScrolling) {
        
        self.initialX=scrollView.contentOffset.x;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    //NSLog(@"scrollViewDidEndDecelerating");
    
    
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    _imageViewRight.transform=CGAffineTransformIdentity;
    
    self.isEndScroll=NO;
    self.isScrolling=NO;
    self.initialX=0;
    
    
    if (self.direction==DirectionLeft && index==1) {
        
        self.currentPage++;
        
    }else if (self.direction==DirectionRight && index==1){
        
        self.currentPage++;
    }
    
    _pageControl.currentPage=_currentPage;
    
    [self run];
}


@end
