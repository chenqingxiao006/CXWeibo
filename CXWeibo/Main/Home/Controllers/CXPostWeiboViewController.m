//
//  CXPostWeiboViewController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/11.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXPostWeiboViewController.h"
#import "CXAccountTool.h"
#import "CXNetManager.h"
#import "CXProgressHUD.h"
#import "CXHomeViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface CXPostWeiboViewController ()<UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic) NSMutableArray* imgSelected;
/** 发送按钮 */
@property (strong, nonatomic) UIButton *postBtn;

/** 内容框 */
@property (strong, nonatomic) UITextView *textView;

/** 下方工具条 */
@property (strong, nonatomic) UIView *toolBarView;

/** 相机按钮 */
@property (strong, nonatomic) UIButton *cameraBtn;

/** 相册按钮 */
@property (strong, nonatomic) UIButton *albumBtn;

@property(strong,nonatomic) UIView* imgView;
@end

@implementation CXPostWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgSelected= [NSMutableArray array];
    self.title = @"发布微博";
    [self creatUI];
}
//test comit
- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn sizeToFit];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(dismissPostWeiboViewController) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItems = @[cancelItem];

    
    // 发布按钮
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.userInteractionEnabled = NO;
    
    [postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    self.postBtn = postBtn;
    [postBtn setTitle:@"发布" forState:(UIControlStateNormal)];
    [postBtn sizeToFit];
    [postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [postBtn addTarget:self action:@selector(postWeibo) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItems = @[postItem];
    
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.toolBarView];
    //居左 10 居工具栏上10 高度40 宽度200
    CGRect rect=CGRectMake(10, self.toolBarView.frame.origin.y-50, 200, 40);
    self.imgView=[[UIView alloc] initWithFrame:rect];
    self.imgView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.imgView];
    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

}


#pragma mark - event

- (void)postWeibo{
    if (self.textView.text.length > 0) {
        [self postWeiboWithText:self.textView.text];
    }
}

- (void)postWeiboWithPics{
    
    
    // 判断是否能访问相册
//    if ([self isSourceTypeAvailable]) {
//        
//    }
    
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * img=info[@"UIImagePickerControllerOriginalImage"];
  
    UIImageView * imgv= [[UIImageView alloc] initWithImage:img];
    imgv.frame=CGRectMake([self.imgSelected count]*50, 0, 40, 40);
    [self.imgView addSubview:imgv];
    [self.imgSelected addObject:img];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"fuck ");
    }];
}
- (void)postWeiboWithText:(NSString *)text{
    
    if (text.length > 0) {
        CXAccount *account = [CXAccountTool shareAccountTool].account;
        NSDictionary *params = @{
                                 @"access_token" : account.access_token,
                                 @"uid" :account.uid,
                                 @"feature":@1,
                                 @"status":text
                                 };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // 让AFN支持@"text/plain" 和 application/json
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        //搞不定 zx
//        [manager
//         POST:@"https://api.weibo.com/2/statuses/update.json"
//         parameters:params
//         constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
//        {
//            [formData  appendPartWithFormData:UIImageJPEGRepresentation((UIImage*)self.imgSelected[0], 0.001)  name:@"pic"];
//        }
//         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
//        {
//            NSLog(@" ok ");
//        }
//         failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
//        {
//            NSLog(@"error %@",error);
//        }];
        
        [CXNetManager postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id responseObject) {

            NSLog(@"%@",responseObject);
            [CXProgressHUD showMessage:@"发送成功" durationTime:1.2 completionBlock:^{
                [self dismissPostWeiboViewController];
                
                if (self.refreshHomeBlock) {
                    self.refreshHomeBlock();
                }
                
            } inView:self.view];
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [CXProgressHUD showMessage:@"发送失败" durationTime:1.2 completionBlock:^{
                
            } inView:self.view];
        }];
    }else{
        [CXProgressHUD showMessage:@"文字不能为空" durationTime:1.2 completionBlock:^{
            
        } inView:self.view];
    }
}

- (void)dismissPostWeiboViewController{
    [self.textView endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 键盘相关

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolBarView.y = self.view.height - self.toolBarView.height;//这里的<span style="background-color: rgb(240, 240, 240);">self.toolbar就是我的输入框。</span>
            
        } else {
            self.toolBarView.y = keyboardF.origin.y - self.toolBarView.height;
        }
        //调整图片选择区域的位置
        CGRect rect=CGRectMake(10, self.toolBarView.frame.origin.y-50, 200, 40);
        self.imgView.frame=rect;
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0 && textView.text.length < 140) {
        self.postBtn.userInteractionEnabled = YES;
        [self.postBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

    }else{
        self.postBtn.userInteractionEnabled = NO;
        [self.postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];

    }
}

#pragma mark - getter and setter

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49);
        
        self.automaticallyAdjustsScrollViewInsets = NO;// 光标位于左上角
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        
    }
    return _textView;
}

- (UIView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] init];
        _toolBarView.frame = CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49);
        _toolBarView.backgroundColor = [UIColor yellowColor];
        [_toolBarView addSubview:self.cameraBtn];
        [_toolBarView addSubview:self.albumBtn];
    }
    return _toolBarView;
}

- (UIButton *)cameraBtn{
    if(!_cameraBtn){
        
    }
    return _cameraBtn;
}

- (UIButton *)albumBtn{
    if(!_albumBtn){
        _albumBtn = [[UIButton alloc] init];
        [_albumBtn setImage:[UIImage imageNamed:@"cx_add_picture"] forState:(UIControlStateNormal)];
        [_albumBtn sizeToFit];
        [_albumBtn addTarget:self action:@selector(postWeiboWithPics) forControlEvents:(UIControlEventTouchUpInside)];
        _albumBtn.origin = CGPointMake(13.5, 13.5);
    }
    return _albumBtn;
}

@end
