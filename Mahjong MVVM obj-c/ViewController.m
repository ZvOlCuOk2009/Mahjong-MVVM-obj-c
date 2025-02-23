//
//  ViewController.m
//  Mahjong MVVM obj-c
//
//  Created by Aleksandr Tsvihun on 21.02.2025.
//
#import "ViewController.h"
#import "TileModel.h"
#import "TileViewModel.h"
#import "TileLayout.h"

//static CGFloat widthBorder = 30;

@interface ViewController () <TileViewModelDelegate>

@property (nonatomic, strong) TileViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray <UIView *> *tiles;
@property (strong, nonatomic) UIView *touchView;

- (IBAction)testButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupTiles];
    TileModel *model = [[TileModel alloc] init];
    self.viewModel = [[TileViewModel alloc] initWithModel:model];
    self.tiles = [NSMutableArray new];
    self.viewModel.delegate = self;

    [self.viewModel.tileModel generateRandomNumbers];
    [self addTilesToScene];
}

//- (void)setupTiles {
//    NSArray<TilePosition *> *arr = [TileLayout generateTowerLayout];
//    self.viewModel = [[TileViewModel alloc] initWithLayout:arr];
//    for (TilePosition *position in self.viewModel.tiles) {
//        UIView *tileView = [[UIView alloc] initWithFrame:CGRectMake(position.x * 50, position.y * 50, 50, 50)];
////        if (position.layer == 0) {
////                tileView.backgroundColor = [UIColor systemBlueColor];
////            } else if (position.layer == 1) {
////                tileView.backgroundColor = [UIColor systemRedColor];  // Наприклад, червоний колір для layer == 1
////            }
//        switch (position.layer) {
//            case 0:
//                tileView.backgroundColor = [UIColor systemBlueColor];
//            case 1:
//                tileView.backgroundColor = [UIColor systemRedColor];
//            case 2:
//                tileView.backgroundColor = [UIColor systemYellowColor];
//            case 3:
//                tileView.backgroundColor = [UIColor systemGreenColor];
//            case 4:
//                tileView.backgroundColor = [UIColor systemBrownColor];
//            case 5:
//                tileView.backgroundColor = [UIColor systemGrayColor];
//            default:
//                break;
//        }
//
//        [self.view addSubview:tileView];
//    }
//}


- (void)addTilesToScene {
    CGRect rectView = [self.viewModel calculateFrameForTile:self.view.frame];
    CGFloat x = 0.0;
    CGFloat y = 0.0;

    for (int i = 0; i < self.viewModel.tileModel.randomNumbers.count; i++) {
        if ((i % 4) == 0) { x = rectView.origin.x; }
        else { x = x + rectView.size.width; }
        if (i < 4) { y = rectView.origin.y; }
        else if ((i % 4) == 0) { y = y + rectView.size.height; }

        UIView *tileView = [self.viewModel createTileViewWithNumber:[self.viewModel.tileModel.randomNumbers objectAtIndex:i]
                                                               rect:rectView
                                                              withX:x withY:y];
        [self configTileView:tileView];
        [self.tiles addObject:tileView];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureTap:)];
        [tileView addGestureRecognizer:tapGestureRecognizer];
        [self.view addSubview:tileView];
    }
}

- (void)tapGestureTap:(UITapGestureRecognizer *)gestureTap {
    UIView *tileView = gestureTap.view;
    self.touchView = tileView;
    tileView.backgroundColor = [UIColor grayColor];
    [self performSelector:@selector(returnColor)
               withObject:nil
               afterDelay:0.1];
    
    TileData *tileData = [[TileData alloc] initWithTag:tileView.tag frame:tileView.frame];
    [self.viewModel logicForRemovingTiles:tileData];
}

- (void)returnColor {
    self.touchView.backgroundColor = [UIColor systemIndigoColor];
}

- (void)configTileView:(UIView *)tileView
{
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
}

#pragma mark delegate

- (void)didSelectTileAtPosition:(NSInteger)firstTag secongData:(NSInteger)secondTag
{
    [self.touchView removeFromSuperview];
    
    NSMutableArray *tilesToRemove = [NSMutableArray array];
    
    for (UIView *tile in self.tiles) {
        if (tile.tag == firstTag || tile.tag == secondTag) {
            [tilesToRemove addObject:tile];
        }
    }
    
    for (UIView *tile in tilesToRemove) {
        [tile removeFromSuperview];
        [self.tiles removeObject:tile];
    }
}

- (IBAction)testButton:(id)sender {
    [self.viewModel resetGame];
    [self addTilesToScene];
}

@end
