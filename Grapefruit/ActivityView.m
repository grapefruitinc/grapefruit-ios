//
//  ActivityView.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

// TODO: Add a label which shows a random cute phrase below the spinner.

#import "ActivityView.h"

@interface ActivityView ()

@property (nonatomic) BOOL isSpinning;
@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation ActivityView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.animationImageView = [UIImageView new];
        
        NSMutableArray *animationImages = [NSMutableArray new];
        UIImage *animationImage;
        for (unsigned i = 0; i < 16; i++)
        {
            animationImage = [UIImage imageNamed:[NSString stringWithFormat:@"Logo-%u", i]];
            [animationImages addObject:animationImage];
        }
        self.animationImageView.animationImages = animationImages;
        self.animationImageView.animationDuration = 2.0;
        
        CGRect animationImageViewFrame = CGRectMake(
            self.frame.size.width/2.0 - animationImage.size.width/2.0,
            self.frame.size.height/2.0 - animationImage.size.height/2.0,
            animationImage.size.width,
            animationImage.size.height);
        self.animationImageView.frame = animationImageViewFrame;
        [self addSubview:self.animationImageView];
        
        self.isSpinning = NO;
    }
    return self;
}

#pragma mark - Public Methods

- (void)startSpinning
{
    if (!self.isSpinning)
    {
        self.isSpinning = YES;
        [self.animationImageView startAnimating];
    }
}

-(void)stopSpinning
{
    if (self.isSpinning)
    {
        self.isSpinning = NO;
        [self.animationImageView stopAnimating];
    }
}

@end
