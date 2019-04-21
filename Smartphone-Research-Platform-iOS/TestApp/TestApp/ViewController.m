//
//  ViewController.m
//  TestApp
//
//  Created by Abhishek Sehgal on 3/15/17.
//  Copyright © 2017 default. All rights reserved.
//

#import "ViewController.h"
#import "Algorithm.h"

@interface ViewController ()
@property UILabel *label;
@property UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 30)];
    _label.text = @"Hello World!";
    [self.view addSubview:_label];
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame = CGRectMake(10, 50, 300, 30);
    [_button setTitle:@"Button" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)buttonPress:(id)sender {
    _label.text = [NSString stringWithUTF8String:HelloWorld()];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
