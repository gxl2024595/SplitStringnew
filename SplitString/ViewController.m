//
//  ViewController.m
//  SplitString
//
//  Created by 龚晓龙 on 16/5/11.
//  Copyright © 2016年 龚晓龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stringText;
@property (weak, nonatomic) IBOutlet UITextField *split;
@property (weak, nonatomic) IBOutlet UITextView *splitedText;

@end

@implementation ViewController
//点击事件
- (IBAction)clickToSplit:(id)sender {
    if (_split.text.length == 0 || _stringText.text.length == 0) {
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误!" message:@"字符串或者分隔符不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alertView show];
        return;
    }else{
  NSArray *splitTextArr = [self splitString:_stringText.text withSymbol:_split.text];
        NSLog(@"%@",splitTextArr[0]);
    [self viewTheSplitedString:splitTextArr];
    }
}

//分割的方法实现
-(NSArray *)splitString:(NSString *)str withSymbol:(NSString *)symbol{
    NSMutableArray *mutableArr = [NSMutableArray new];
    for (int flaghead = 0, flagtemp = 0;flagtemp<=str.length-symbol.length; flagtemp++) {
        NSString *tempStr = [str substringWithRange:NSMakeRange(flagtemp, symbol.length)];
        if ([tempStr isEqualToString:symbol]) {
            NSString *splitStr = [str substringWithRange:NSMakeRange(flaghead, flagtemp-flaghead)];
            [mutableArr addObject:splitStr];
            flaghead = flagtemp + (int)symbol.length;
        }
        if (flagtemp == str.length - symbol.length) {
            NSString *splitStr = [str substringWithRange:NSMakeRange(flaghead, flagtemp-flaghead+symbol.length)];
            [mutableArr addObject:splitStr];
        }
    }
 return [mutableArr copy];
}

//对文本框进行换行赋值
- (void)viewTheSplitedString:(NSArray *)spliteArr{
NSMutableString *text = [NSMutableString new];
for (NSString *str in spliteArr) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\n",str];
        [text appendString:tempStr];
        _splitedText.text = text;
    }
}

//重写, 用户触摸self.view时触发
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//键盘点击Done后收起键盘
- (void)hideKeyboard:(UITextField *)sender{
       [sender resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.stringText addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.split addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
