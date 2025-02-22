//
//  TileViewModel.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//

#import "TileViewModel.h"

static CGFloat widthBorder = 30;

@implementation TileViewModel

- (instancetype)initWithModel:(TileModel *)model {
    self = [super init];
    if (self) {
        _tileModel = model;
        _firstTap = -1;
        _secondTap = -1;
        _firstRectangle = CGRectZero;
        _secondRectangle = CGRectZero;
        _firstTile = [[UIView alloc] initWithFrame:CGRectZero];
        _secondTile = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (UIView *)createTileViewWithNumber:(NSNumber *)number rect:(CGRect)rect
                               withX:(CGFloat)x withY:(CGFloat)y
{
    UIView *tileView = [[UIView alloc] init];
    tileView.frame = CGRectMake(x, y, rect.size.width, rect.size.height);

    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:tileView.bounds];
    tileView.backgroundColor = [UIColor systemIndigoColor];
    tileView.layer.cornerRadius = 20;
    tileView.layer.shadowColor = [UIColor blackColor].CGColor;
    tileView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    tileView.layer.shadowOpacity = 0.5f;
    tileView.layer.shadowPath = shadowPath.CGPath;
    tileView.layer.borderColor = [UIColor whiteColor].CGColor;
    tileView.layer.borderWidth = 2;
    tileView.layer.masksToBounds = NO;
    tileView.tag = [number integerValue];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, (rect.size.height / 2) / 2, rect.size.width, rect.size.height / 2);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:60];
    label.textAlignment = 1;
    [tileView addSubview:label];
    label.text = [number stringValue];;
    return tileView;
}

- (void)logicForRemovingTiles:(UIView *)tileView touchView:(UIView *)touchView
{
    CGRect zeroRect = CGRectMake(0, 0, 0, 0);
    if (CGRectEqualToRect(self.firstRectangle, zeroRect)) {
        self.firstRectangle = tileView.frame;
    } else if (CGRectEqualToRect(self.firstRectangle, tileView.frame)) {
        self.firstRectangle = tileView.frame;
        return;
    } else {
        self.firstRectangle = tileView.frame;
    }

    NSString *tag = [NSString stringWithFormat:@"%li", (long)tileView.tag];

    if (self.firstTile == nil && self.secondTile == nil) {
        self.firstTap = [tag integerValue];
        self.firstTile = tileView;
    } else if (self.firstTile != nil && self.firstTap != [tag integerValue]) {
        self.firstTap = [tag integerValue];
        self.firstTile = tileView;
    } else if (self.firstTile != nil && self.firstTap == [tag integerValue]) {
        self.secondTap = [tag integerValue];
        self.secondTile = tileView;
    }

    if (self.firstTap == self.secondTap) {
        [self.firstTile removeFromSuperview];
        [self.secondTile removeFromSuperview];
        self.firstRectangle = CGRectMake(0, 0, 0, 0);
        [self resetTaps];
//        self.firstTile = nil;
//        self.secondTile = nil;
        touchView = nil;
    } else if (self.secondTile != nil) {
        self.firstTap = [tag integerValue];
//        self.secondTile = nil;
        self.secondTap = 0;
    }
}

- (void)resetTaps
{
    self.firstTap = 10000;
    self.secondTap = 10000;
}

- (CGRect)calculateFrameForTile:(CGRect)frameView
{
    return CGRectMake(widthBorder, widthBorder, [self calculateWidthForFrame:frameView], [self calculateHeightForFrame:frameView]);
}

- (CGFloat)calculateWidthForFrame:(CGRect)frameView
{
    return (frameView.size.width - [self retreatFromFrame]) / 4;
}

- (CGFloat)calculateHeightForFrame:(CGRect)frameView
{
    return (frameView.size.height - [self retreatFromFrame]) / 5;
}

- (CGFloat)retreatFromFrame
{
    return widthBorder * 2;
}

- (void)resetGame {
    [self.tileModel resetGame];
    self.firstTap = -1;
    self.secondTap = -1;
}

@end
