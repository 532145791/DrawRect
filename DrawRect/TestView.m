//
//  TestView.m
//  DrawRect
//
//  Created by 超冷 on 16/6/29.
//  Copyright © 2016年 超冷. All rights reserved.
//

#import "TestView.h"

@interface TestView ()

{
    CGContextRef _context;
    CGFloat orign_x;//坐标原点 横坐标
    CGFloat orign_y;//坐标原点 竖坐标
    CGFloat x_space;//两条竖线之间的宽度
    CGFloat y_space;//两条横线之间的高度
    CGFloat coordinateH; //自定义坐标系每小格的高度(与定义的点有关)
}

@end

@implementation TestView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        orign_x = 27;
        orign_y = self.frame.size.height - 31;
        x_space = 77/2;
        y_space = 10;
        coordinateH = 2;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    _context = UIGraphicsGetCurrentContext();
    
    CGFloat y_height = self.frame.size.height - 30 - 31;//y轴高度
    CGFloat x_width = self.frame.size.width - orign_x - 12;//x轴宽度
    //绘制x轴
    CGContextSetLineWidth(_context, 2.0);//线的宽度
    CGContextMoveToPoint(_context, orign_x, orign_y);
    CGContextAddLineToPoint(_context, x_width, orign_y);
    CGContextSetFillColorWithColor(_context, [UIColor blackColor].CGColor);
    CGContextStrokePath(_context);
    
    //绘制y轴
    CGContextSetLineWidth(_context, 2.0);//线的宽度
    CGContextMoveToPoint(_context, orign_x, orign_y);
    CGContextAddLineToPoint(_context, orign_x, self.frame.size.height - 31 - y_height);
    CGContextSetFillColorWithColor(_context, [UIColor blackColor].CGColor);
    CGContextStrokePath(_context);
    
    //绘制水平虚线
    for (NSInteger i = 0; i < 10; i ++) {
        CGFloat dashLine_Y = self.frame.size.height - (31 + y_space* (i + 1));
        CGFloat lengths[] = {1,1};
        CGContextSetLineDash(_context, orign_x, lengths,2);
        CGContextSetLineWidth(_context, 1.0);//线的宽度
        CGContextMoveToPoint(_context, orign_x, dashLine_Y);
        CGContextAddLineToPoint(_context, x_width, dashLine_Y);
        CGContextSetFillColorWithColor(_context, [UIColor lightGrayColor].CGColor);
        CGContextStrokePath(_context);
    }
    
    //绘制 x轴 title
    CGFloat x_title_width = 48/2;//title的宽度
    CGFloat x_title_height = 8;//title的高度
    CGFloat title_Y = self.frame.size.height - 26;//title的y坐标
    NSArray *x_data = [NSArray arrayWithObjects:@"",@"02.07",@"02.13",@"02.19",@"02.25",@"03.02", nil];
    for (NSInteger i = 0; i < x_data.count ; i ++) {
        if (i == 0) {
            
        }else{
            CGFloat x = i * x_space - x_title_width/2 + orign_x;
            [x_data[i] drawInRect:CGRectMake(x, title_Y, x_title_width, x_title_height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        }
    }
    
    //绘制 y轴 title
    CGFloat y_title_height = 6;//y轴title的高度
    CGFloat y_title_width = 18;//y轴title的宽度
    NSArray *y_data = [NSArray arrayWithObjects:@"",@"18",@"20",@"22",@"24",@"26", nil];
    for (NSInteger i = 0; i < y_data.count ; i ++) {
        if (i == 0) {
            
        }else{
            CGFloat y = orign_y - i * y_space - y_title_height/2;
            [y_data[i] drawInRect:CGRectMake(8, y, y_title_width, y_title_height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:6.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
        }
    }
    
    //绘制 数据圆 和 所对应的竖直虚线
    NSArray *dataArr = [NSArray arrayWithObjects:@{@"02.07":@(18)},@{@"02.13":@(21)}, @{@"02.19":@(23)},@{@"02.25":@(19)},@{@"03.02":@(26)},nil];
    for (NSInteger i = 0; i < dataArr.count ; i ++) {
        NSDictionary *dic = dataArr[i];
        NSString *xTitle = dic.allKeys[0];
        NSInteger yTitle = [dic[xTitle] integerValue];
        CGFloat currentData_x = [x_data indexOfObject:xTitle] * x_space + orign_x;//点的x坐标计算
        CGFloat currentData_y = orign_y - ((yTitle - 18) * 10 /2 + 10);//点的y坐标计算
        //画圆
        CGContextSetRGBStrokeColor(_context,1,1,1,1.0);//画笔线的颜色
        CGContextSetLineWidth(_context, 1.0);//线的宽度
        CGContextAddArc(_context, currentData_x, currentData_y, 4, 0, M_PI*2, 0); //添加一个圆
        CGContextDrawPath(_context, kCGPathStroke);
        
        //画竖直虚线
        CGFloat lengths[] = {1,1};
        CGContextSetLineDash(_context, currentData_x, lengths,2);
        CGContextSetLineWidth(_context, 1.0);//线的宽度
        CGContextMoveToPoint(_context, currentData_x, orign_y);
        CGContextAddLineToPoint(_context, currentData_x, currentData_y + 4);
        CGContextSetFillColorWithColor(_context, [UIColor redColor].CGColor);
        CGContextStrokePath(_context);
    }
}

@end
