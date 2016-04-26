//
//  ViewController.m
//  xxx
//
//  Created by iMac5K on 2016. 4. 26..
//  Copyright © 2016년 Shock. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGRect sourceFrame;
}
@property (strong, nonatomic) UIView *vwMaker;
@property (strong, nonatomic) UITapGestureRecognizer *tapSingleGesture;

@property (strong, nonatomic) IBOutlet UIScrollView *vwScroll;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    sourceFrame = CGRectMake(0, 0, 1680, 1050);
    _vwMaker = [[UIView alloc] initWithFrame:sourceFrame];
    _vwMaker.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tile"]];
    _vwMaker.contentMode = UIViewContentModeCenter;
    [_vwScroll addSubview:_vwMaker];

    
    _tapSingleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap)];
    _tapSingleGesture.delegate = self;
    _tapSingleGesture.numberOfTapsRequired = 1;
    _tapSingleGesture.cancelsTouchesInView = NO;
    [_vwScroll addGestureRecognizer:_tapSingleGesture];

    // Set Zoom
    CGSize scrollViewSize = _vwScroll.frame.size;
    CGFloat xMinZoomScale = scrollViewSize.width/sourceFrame.size.width;
    CGFloat yMinZoomScale = scrollViewSize.height/sourceFrame.size.height;
    CGFloat minimumZoomScale = MIN(xMinZoomScale, yMinZoomScale);
    _vwScroll.minimumZoomScale = minimumZoomScale;
    _vwScroll.maximumZoomScale = minimumZoomScale * 10.0;
    
    // Fit on screen
    [_vwScroll setZoomScale:minimumZoomScale animated:animated];
    
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _vwMaker;
}

- (void)onSingleTap {
    _toolbar.hidden = !_toolbar.hidden;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize contentSize = _vwMaker.frame.size;
    CGSize scrollViewSize = _vwScroll.frame.size;
    
    CGFloat xInset = MAX((scrollViewSize.width - contentSize.width)/2.0, 0);
    CGFloat yInset = MAX((scrollViewSize.height - contentSize.height)/2.0, 0);
    
    _vwScroll.contentInset = UIEdgeInsetsMake(yInset, xInset, yInset, xInset);
}



/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDragging");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    NSLog(@"scrollViewWillEndDragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_vwScroll setZoomScale:_vwScroll.zoomScale*1.001];
    NSLog(@"scrollViewDidEndDragging : %f", _vwScroll.zoomScale);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    NSLog(@"%f x %f : %f", self.view.frame.size.width, self.view.frame.size.height, scale);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"xxx : %@", [gestureRecognizer class]);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer==_vwScroll.panGestureRecognizer) {
        NSLog(@"%d", (int)touch.tapCount);
    }
    
    return YES;
}
*/
@end
