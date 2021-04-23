# Uncomment the next line to define a global platform for your project
plugin "cocoapods-mPaaS", :show_all_specs => true
mPaaS_baseline '10.1.68'  # 请将 x.x.x 替换成真实基线版本
platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/wittech/libqimkit-ios-cook.git'
source "https://code.aliyun.com/mpaas-public/podspecs.git"

target 'QIMUIKit' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
	
  # Pods for QIMUIKit
    #移除mpaas依赖的SDWebImage
    remove_pod "mPaaS_SDWebImage"
    remove_pod "mPaaS_AMap"
    
    mPaaS_pod "mPaaS_MBProgressHud"
    mPaaS_pod "mPaaS_AlipaySDK"
    mPaaS_pod "mPaaS_TinyApp"
    
    pod 'QIMDataBase'
    pod 'QIMKitVendor'
    pod 'QIMCommon'
    pod 'QIMCommonCategories'
    pod 'QIMGeneralModule'

    pod 'MJRefresh'
    pod 'YLGIFImage'
    pod 'SwipeBack'
    pod 'SwipeTableView'
    pod 'MDHTMLLabel'
    pod 'MMMarkdown'
    pod 'MGSwipeTableCell'
    pod 'DACircularProgress'
    #使用WKWebView内核，不需要假进度条了
#    pod 'NJKWebViewProgress'
    pod 'AMapSearch-NO-IDFA'
    pod 'AMapLocation-NO-IDFA'
    pod 'AMap3DMap-NO-IDFA'

    pod 'Toast'
    pod 'MMPickerView'
    pod 'SCLAlertView-Objective-C'
    pod 'YYKeyboardManager'
    #修复缺失pod
    pod 'FDFullscreenPopGesture'
    pod 'RTLabel'
    pod 'TXLiteAVSDK_Player'
    
end
