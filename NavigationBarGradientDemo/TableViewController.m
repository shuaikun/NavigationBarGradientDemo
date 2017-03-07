//
//  TableViewController.m
//  NavigationBarGradientDemo
//
//  Created by caoshuaikun on 2017/3/3.
//  Copyright © 2017年 useeinfo. All rights reserved.
//

#import "TableViewController.h"

#define Screen_bounds [UIScreen mainScreen].bounds
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height  [UIScreen mainScreen].bounds.size.height
#define pictureHeight 100 //照片高度

@interface TableViewController ()

@property (nonatomic, assign) CGFloat alpha;//导航栏透明度
@property (nonatomic, strong) UIView *header;//tableViewheader
@property (nonatomic, strong) UIImageView * barImageView;//导航栏的默认背后图片
@property (nonatomic, strong) UIImageView *pictureImageView;//需要放大的图片

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//创建导航栏的ImageView的东西
- (void)creatBarImageView {
    
    self.barImageView = [UIImageView new];
    self.barImageView = self.navigationController.navigationBar.subviews.firstObject;
    self.barImageView.backgroundColor = [UIColor redColor];
}

//改变tableViewHeader
- (void)creatHeaderImageView {

    // 添加头视图 在头视图上添加ImageView
    NSString * path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, pictureHeight)];
    self.pictureImageView = [[UIImageView alloc] initWithFrame:_header.bounds];
    self.pictureImageView.image = [UIImage imageWithContentsOfFile:path];
 
    /*
     * 这个属性的值决定了 当视图的几何形状变化时如何复用它的内容 这里用
     * UIViewContentModeScaleAspectFill 意思是保持内容高宽比 缩放内容
     * 超出视图的部分内容会被裁减 填充UIView
     */
    self.pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    /*
     * 这个属性决定了子视图的显示范围 取值为YES时，剪裁超出父视图范围的子视图部分.
     * 这里就是裁剪了pictureImageView超出header范围的部分.
     */
    self.pictureImageView.clipsToBounds = YES;
    [self.header addSubview:self.pictureImageView];
    self.tableView.tableHeaderView = self.header;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat Offset_y = scrollView.contentOffset.y;//tableView的scrollview偏移量
    
    NSLog(@"%f",Offset_y);
    
    //计算透明度
    CGFloat minAlphaOffset = - 64;//最小偏移量
    CGFloat maxAlphaOffset = 200;//最大的偏移量
    CGFloat alpha = (Offset_y - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.barImageView.alpha = alpha;//透明度
    
    /*
     * 获取到tableView偏移量
     * 这里的偏移量是纵向从contentInset算起 则一开始偏移就是0 向下为负 上为正 下拉
     */
    if ( Offset_y < 0) {
        
        CGFloat totalOffset = pictureHeight - Offset_y;// 拉伸后图片的高度
        CGFloat scale = totalOffset / pictureHeight;// 图片放大比例
        CGFloat width = Screen_Width;
        self.pictureImageView.frame = CGRectMake( - (width * scale - width) / 2, Offset_y, width * scale, totalOffset);// 拉伸后图片位置
    }
    
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"demo";
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self creatBarImageView];
    [self creatHeaderImageView];
}






@end
