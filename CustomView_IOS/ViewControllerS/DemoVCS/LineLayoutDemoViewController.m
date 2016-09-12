//
//  LineLayoutDemoViewController.m
//  CustomView_IOS
//
//  Created by 恒善信诚科技有限公司 on 16/9/12.
//
//

#import "LineLayoutDemoViewController.h"

#import "JWScrollView.h"

@interface LineLayoutDemoViewController ()
@property (nonatomic,strong) JWScrollView * scrollView;
@end

@implementation LineLayoutDemoViewController

-(JWScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[JWScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _scrollView.alwaysBounceVertical = true;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
    
    UIView * view =[self.view.subviews firstObject];
    
    //需要设置线性布局控件集合的第一个控件的y轴，之后排列的控件不需要设置y轴 会自动向下排列
    UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), kScreenWidth, 20)];
    labe.text = @"testlabel1";
    labe.backgroundColor = [UIColor redColor];
    
    UILabel * labe1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    labe1.text = @"testlabel2";
    labe1.backgroundColor = [UIColor blueColor];
    
    UILabel * labe2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    labe2.text = @"testlabel3";
    labe2.backgroundColor = [UIColor grayColor];
    
    JWTextField *
    text1 = [[JWTextField alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,50)];
    text1.placeholder = @"数字输入";
    text1.textAlignment = 0;
    text1.font = [UIFont systemFontOfSize:18];
    text1.importStyle = TextFieldImportStyleNumber; //设置输入限制的类型
    text1.keyboardType = UIKeyboardTypeNumberPad;
    text1.tag = 9999;
    text1.importBackString = ^(NSString * money){

    };
    
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:10];
    
    arr  = @[labe,labe1,labe2,text1].mutableCopy;
    
    for (int i = 0; i<20; i++) {
        UILabel * la = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        la.text = [NSString stringWithFormat:@"testlabel%d",i];
        la.backgroundColor = [UIColor grayColor];
        [arr addObject:la];
    }

    [self.scrollView setScrollviewSubViewsArr:arr];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.scrollView removeViewWithTag:9999];
        
    });
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.scrollView setScrollviewSubViewsArr:@[labe,labe2,text1].mutableCopy];
        
    });
    
    

    
    NSLog(@"subViewS:%@,\nsubViewSCount:%lu",self.scrollView.subviews,self.scrollView.subviews.count);
}

- (void)dealloc {
    [self clearNotificationAndGesture];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
