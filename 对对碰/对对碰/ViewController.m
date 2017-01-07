//
//  ViewController.m
//  DuiDuiPeng
//
//  Created by Alan.Turing on 16/11/17.
//  Copyright (c) 2016年 Alan.Turing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void) startGame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGSize size = rect.size;
    CGFloat width = size.width;
    //CGFloat height = size.height;
    CGFloat spaceArea = 60.0;
    int rows = 8;
    int cols = 6;
    
    //NSLog(@"screen = %f", (width-spaceArea)/6 );
    
    //NSLog(@"screen width = %f", width);
    //NSLog(@"screen height = %f", height);
    
    NSMutableArray* arrImage = [[NSMutableArray alloc] init];
    
    for(int k = 0; k < rows*cols/2; k++)
    {
        int random = arc4random() % cols + 1;
        NSString* strImageName = [NSString stringWithFormat:@"%d", random];
        
        [arrImage addObject:strImageName];
        [arrImage addObject:strImageName];
    }
    
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(spaceArea/2 + (width-spaceArea)*j/cols, 30 + (width-spaceArea)*i/cols, 40, 40);
            
            int indexrandom = arc4random() % arrImage.count;
            
            UIImage* image = [UIImage imageNamed:arrImage[indexrandom]];
            //UIImage* image = [UIImage imageNamed:@"3.png"];
            
            NSInteger tag = [arrImage[indexrandom] integerValue];
             
            [arrImage removeObjectAtIndex:indexrandom];
            
            [btn setImage:image forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
            
            btn.tag = tag;
        }
    
    }
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton* btnAgain = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAgain.frame = CGRectMake(width/2-50, 60 + (width-spaceArea)*rows/cols, 100, 50);
    [btnAgain setTitle:@"again" forState:UIControlStateNormal];
    btnAgain.backgroundColor = [UIColor redColor];
    [btnAgain addTarget:self action:@selector(pressAgain) forControlEvents:UIControlEventTouchUpInside];
    btnAgain.tag = 1000;
    
    [self.view addSubview:btnAgain];
    
    
}

- (void) pressBtn:(UIButton*) btn
{
    static UIButton* firstBtn = nil;
    
    if (firstBtn == nil) {
        firstBtn = btn;
        btn.enabled = NO;
    }
    else{
        if (firstBtn.tag == btn.tag) {
            firstBtn.hidden = YES;
            btn.hidden = YES;
            firstBtn = nil;
        }
        else{
            firstBtn.enabled = YES;
            firstBtn = nil;
        }
    }
}

- (void) pressAgain
{
    for(UIView* view in [self.view subviews])
    {
        NSLog(@"%@", view);
        [view removeFromSuperview];
    }
    
    [self startGame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self startGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
