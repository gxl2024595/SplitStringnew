//
//  ViewController.m
//  SplitString
//
//  Created by 龚晓龙 on 16/5/11.
//  Copyright © 2016年 龚晓龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *stringText;
@property (weak, nonatomic) IBOutlet UITextField *division;
@property (weak, nonatomic) IBOutlet UITextView *splitedStringText;
@end

@implementation ViewController

//点击事件
- (IBAction)clickToSplit:(id)sender {
    NSArray *splitTextArr = [self splitString:self.stringText.text withSymbol:self.division.text];
    [self displayStringArray:splitTextArr];
}


//分割的方法实现
- (NSArray *)splitString: (NSString *)str withSymbol: (NSString *)symbol {
    NSMutableArray *mutableArr = [NSMutableArray new];
    //增加了判断，实现空字符串或者空分隔符也可输出文本
    if (symbol.length == 0 || str.length == 0) {
        [mutableArr addObject:str];
        return  [mutableArr copy];
    }
    
    for (int flaghead = 0, flagtemp = 0;flagtemp<=str.length-symbol.length; flagtemp++) {
        NSString *tempStr = [str substringWithRange:NSMakeRange(flagtemp, symbol.length)];
        if ( [tempStr isEqualToString:symbol] ) {
            NSString *splitStr = [str substringWithRange:NSMakeRange(flaghead, flagtemp-flaghead)];
            [mutableArr addObject:splitStr];
            flaghead = flagtemp + (int)symbol.length;
            flagtemp = flaghead-1;
        }
        if (flagtemp >= str.length - symbol.length) {
            NSString *splitStr = [str substringWithRange:NSMakeRange(flaghead, str.length-flaghead)];
            [mutableArr addObject:splitStr];
        }
    }
    //改进了输出文本框可能出现空行的情况
    [mutableArr removeObject:@""];
    return [mutableArr copy];
}


//对文本框进行换行赋值
- (void)displayStringArray:(NSArray *)splitArr {
    NSMutableString *text = [NSMutableString new];
    for (NSString *str in splitArr) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\n",str];
        [text appendString:tempStr];
    }
    self.splitedStringText.text = text;
}


//重写, 用户触摸self.view时触发
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//键盘点击Done后收起键盘
- (void)hideKeyboard:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.stringText addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.division addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

@end
