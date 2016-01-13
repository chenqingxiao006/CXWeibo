//
//  ZXImgPickViewController.m
//  CXWeibo
//
//  Created by 鑫 赵 on 16/1/12.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "ZXImgPickViewController.h"
@interface ZXImgPickShowInfo:NSObject
@end

@interface ZXImgPickShowInfo()
@property (nonatomic) NSInteger CurIndex;
@property (nonatomic) NSInteger CurCount;
@property (nonatomic) NSInteger ItemTop;
@property (nonatomic) NSInteger ItemHeight;
@property (nonatomic) NSInteger ItemLeft;
@property (nonatomic) NSInteger ItemWidth;
@property (nonatomic) NSInteger OrgPosY;
@property (nonatomic) NSInteger LastIndex;
@end
@implementation ZXImgPickShowInfo
@end
@import AssetsLibrary;
@interface ZXImgPickViewController ()
@property (strong,nonatomic) NSMutableArray * imgAssetsList;
@property (strong,nonatomic) NSMutableArray * imgViewList;
@property(strong,nonatomic ) UIScrollView * scrollView;
@property (strong,nonatomic) ZXImgPickShowInfo *showInfo;
@end

@implementation ZXImgPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect  rect=CGRectMake(0, 0, 100, 100);
    CGRect rectmain= [[UIScreen mainScreen] bounds];
    
    self.showInfo.LastIndex=-1;
    self.showInfo=[[ZXImgPickShowInfo alloc] init];
    self.showInfo.CurCount=0;
    self.showInfo.CurIndex=0;
    self.imgAssetsList=[NSMutableArray array];
    self.imgViewList =[NSMutableArray array];
    self.showInfo.ItemTop=2;
    self.showInfo.ItemHeight=(rectmain.size.width-self.showInfo.ItemTop*4)/3;
    self.showInfo.ItemLeft=2;
    self.showInfo.ItemWidth=self.showInfo.ItemHeight;
    // Do any additional setup after loading the view.

    
    self.scrollView=[[UIScrollView alloc] init];
    self.scrollView.contentSize=CGSizeMake(rectmain.size.width, rectmain.size.height);
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.delegate=self;
    
    self.scrollView.frame=rectmain;
    UIButton * btn=[[UIButton alloc ] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barbtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems=@[barbtn];
    
    self.title=@"选择照片";
    [self.view addSubview:  self.scrollView];
    //[self getAllImagesGroup];
   
}
-(void) btnClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) loadInitialView
{
    CGRect rectmain= [[UIScreen mainScreen] bounds];
    CGFloat width=rectmain.size.width-10*2-20*2;
    CGFloat height=rectmain.size.height-10*2-20*2;
    int i=0;
    for(;i<9;i++){
        if(self.imgAssetsList.count>=(i+1)){
            CGFloat left= (width+20)*i;
            CGFloat top=(height+20)*i;
            UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, width, height)];
            imgView.image=[UIImage imageWithCGImage:((ALAsset*)self.imgAssetsList[i]).thumbnail];
            [self.scrollView addSubview:imgView];
        }
    }
}

-(void) addImgToView:(NSInteger) i  result:(ALAsset *) asset{
    int indexy= i/3;
    int indexx= i%3;
    NSInteger left= (self.showInfo.ItemLeft+self.showInfo.ItemWidth)*indexx+self.showInfo.ItemLeft;
    NSInteger top=(self.showInfo.ItemTop+self.showInfo.ItemHeight)*indexy+self.showInfo.ItemTop;
    UIImageView * imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, self.showInfo.ItemWidth,self.showInfo.ItemHeight)];
    //imgView.image=[UIImage imageWithCGImage:asset.thumbnail];
    imgView.image=self.imgAssetsList[i];
    [self.imgViewList addObject:imgView];
    [self.scrollView addSubview:imgView];
}
// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

// 滑动到顶部时调用该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
}

// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rectmain= [[UIScreen mainScreen] bounds];
    NSInteger width=self.showInfo.ItemHeight+self.showInfo.ItemTop;
    if(self.imgAssetsList.count==0)
        return;
    int height=scrollView.frame.size.height;
    int curViewHeight=(int)(height+scrollView.bounds.origin.y+self.showInfo.OrgPosY);
    int curViewTop=curViewHeight-height;
    int count=((curViewHeight/width)+1);
    int topIndex=((curViewTop/width)+1);
//    NSLog(@"Cur Index %d las indx %d ",topIndex,self.showInfo.LastIndex);
//    if(self.showInfo.LastIndex!=topIndex){
//        
//        int i=0;
//        int temp=1;
//        if (self.showInfo.LastIndex>topIndex)
//        {
//             i=topIndex*3-1;
//        }
//        else
//        {
//            i=(topIndex-1)*3-1;
//        }
//        while (temp<=3)
//        {
//            NSLog(@"%d index %d last index %d",i,topIndex,self.showInfo.LastIndex);
//            if (self.showInfo.LastIndex>topIndex) {
//               
//                if(self.imgViewList.count>=i&&i>=0)
//                {
//                    [self.scrollView addSubview:self.imgViewList[i]];
//                }
//            }
//            else
//            {
//                if(self.imgViewList.count>=i&&i>=0){
//                    [(UIView*)self.imgViewList[i] removeFromSuperview];
//                }
//            }
//            
//            i--;
//            temp++;
//        }
//        self.showInfo.LastIndex=topIndex;
//    }
    if(count>self.showInfo.CurIndex){
        
        if((self.imgAssetsList.count/3)>=count-1){
            self.showInfo.CurIndex=count;
            for (int i=self.showInfo.CurCount; i<count*3; i++)
            {
                if (self.imgAssetsList.count>i) {
                    [self addImgToView:i result:self.imgAssetsList[i]];
                    self.showInfo.CurCount++;
                }
            }
            if (self.showInfo.CurIndex*width>scrollView.contentSize.height)
            {
                CGSize size=scrollView.contentSize;
                scrollView.contentSize=CGSizeMake(size.width, self.showInfo.CurIndex*width);
            }
        }
    }
}

// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.showInfo.OrgPosY=abs(scrollView.bounds.origin.y);
    
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

// scrollView 开始减速（以下两个方法注意与以上两个方法加以区别）
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

// scrollview 减速停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

-(void) getAllImagesGroup
{
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *groupArray;
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    groupArray=[[NSMutableArray alloc] initWithCapacity:1];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group ) {
            [groupArray addObject:group];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result){
                    //[self.imgAssetsList addObject:result];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    [self.imgAssetsList addObject: [UIImage imageWithCGImage:result.thumbnail]];
                    //[self addImgToView:index result:result];
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Group not found!\n");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
