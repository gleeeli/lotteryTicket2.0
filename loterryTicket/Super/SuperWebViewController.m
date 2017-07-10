//
//  SuperWebViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "SuperWebViewController.h"
#import <WebKit/WebKit.h>
#import "ViewCode.h"

@interface SuperWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView *wkWebView;
@end

@implementation SuperWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initWkwebView];
}

- (void)initWkwebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, VC_WIDTH, 0) configuration:configuration];
    self.wkWebView.backgroundColor = [UIColor whiteColor];
    self.wkWebView.scrollView.scrollEnabled = YES;
    self.wkWebView.scrollView.bounces = NO;
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    [self.wkWebView setUserInteractionEnabled:YES];
    [self.wkWebView setOpaque:NO];
    
    self.wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.wkWebView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_wkWebView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_wkWebView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_wkWebView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_wkWebView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    [self.wkWebView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.webURL != nil)
    {
        [self loadCurURL];
    }
}

- (void)loadLocalURL:(NSString *)locaUrl
{
    //NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:locaUrl];
    self.webURL = url;
    [self loadCurURL];
}

- (void)loadServiceURL:(NSString *)serviceUrl
{
    NSURL *url = [NSURL URLWithString:serviceUrl];
    self.webURL = url;
    [self loadCurURL];
}

- (void)loadCurURL
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:self.webURL]];
}

#pragma mark UIDelegate WkWebView的代理方法
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    //会拦截到window.open()事件.
    //只需要我们在在方法内进行处理
    if (!navigationAction.targetFrame.isMainFrame)
    {
        NSLog(@"拦截到window.open()事件,__blank");
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}



#pragma mark WKNavigationDelegate WkWebView的代理方法
/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
    NSLog(@"页面开始加载时调用：%s\n%@", __FUNCTION__,webView.URL.absoluteString);
}


/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"当内容开始返回时调用：%s\n%@", __FUNCTION__,webView.URL.absoluteString);
    
}


/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //self.isPageLoadTimeOut = NO;
    NSString *nowUrl = webView.URL.absoluteString;
    NSLog(@"页面加载完成之后调用：%s\n%@", __FUNCTION__,nowUrl);
}


- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"didFailNavigation：%s\n%@", __FUNCTION__,webView.URL.absoluteString);
    if(error.code == -999)//有遇到该情况
    {

    }
    else
    {
        [ViewCode showMessageWithTitle:nil message:@"网络出错"];
    }
}


/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
    NSLog(@"加载失败时调用：%s\n%@\nerror:%@", __FUNCTION__,webView.URL.absoluteString,error);
    //-1001 网络超时
    //-1002 unsupported URL
    //-999 中途被跳转
    //Code=102 "帧框加载已中断"
    
    if(error.code == -1002 || error.code == -999 || error.code == 102)
    {
        
    }
    else
    {
        [ViewCode showMessageWithTitle:nil message:@"网络出错"];
    }
}


/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
    NSLog(@"接收到服务器跳转请求之后调用：%s\n%@", __FUNCTION__,webView.URL.absoluteString);
}


#pragma mark 决定是否跳转
/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"在发送请求之前，决定是否跳转：%s\n%@,\nnavigation:%@", __FUNCTION__,webView.URL.absoluteString,navigationAction.request.URL.absoluteString);
    NSLog(@"允许跳转");
    decisionHandler(WKNavigationActionPolicyAllow);
}


/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"在收到响应后，决定是否跳转：%s\n%@", __FUNCTION__,navigationResponse.response.URL.absoluteString);
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    NSURLCredential *cred = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
    NSLog(@"didReceiveAuthenticationChallenge：%s\n%@", __FUNCTION__,webView.URL.absoluteString);
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action)
                                {
                                    completionHandler();
                                }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

#pragma mark - 监听WkWebView加载进度事件 KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self deallocWkwebView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
*  处理wkwebview释放
*/
- (void)deallocWkwebView
    {
        [self.wkWebView removeObserver:self forKeyPath:@"loading"];
        [self.wkWebView removeObserver:self forKeyPath:@"title"];
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
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
