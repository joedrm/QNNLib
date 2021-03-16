
Pod::Spec.new do |s|
    s.name             = 'QNNLib'
    s.version          = '0.1.1'
    s.summary          = 'QNNLib'
    s.description      = <<-DESC
    Swift 私有组件库
    DESC
    
    s.homepage         = 'https://github.com/wangdongyang/QNNLib'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'joe' => 'wf_pinbo@163.com' }
    s.source           = { :git => 'https://github.com/wangdongyang/QNNLib.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '8.0'
    s.swift_version = '5.0'
    #s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    
    # 基类
    s.subspec 'Base' do |b|
        b.source_files = 'QNNLib/Classes/Base/**/*'
        b.dependency 'QNNLib/VenderLib'
    end
    
    # 分类
    s.subspec 'Extension' do |c|
        c.source_files = 'QNNLib/Classes/Extension/**/*'
        c.dependency 'SDWebImage'#, '~> 5.10.4'
        c.dependency 'QNNLib/Base'
        c.dependency 'SnapKit'#, '~> 5.0.1'
        c.dependency 'Then'#, '~> 2.6.0'
        c.dependency 'Toast'#, '~> 4.0.0'
    end
    
    # 工具库
    s.subspec 'Tools' do |m|
        m.source_files = 'QNNLib/Classes/Tools/**/*'
        m.dependency 'Fuzi'
        m.dependency 'FCUUID'
#        m.dependency 'SDWebImage', '~> 5.10.4'
        m.dependency 'SwiftyJSON'#, '~> 4.0'
        m.dependency 'QNNLib/Extension'
        m.dependency 'QNNLib/Base'
        m.dependency 'Toast'#, '~> 4.0.0'
    end
    
    # 封装的组件库
    s.subspec 'UIComponents' do |t|
        t.source_files = 'QNNLib/Classes/UIComponents/**/*'
        t.dependency 'FSPagerView'
        t.dependency 'SnapKit'#, '~> 5.0.1'
        t.dependency 'Then'#, '~> 2.6.0'
        t.dependency 'QNNLib/Extension'
        t.dependency 'QNNLib/Tools'
        t.dependency 'QNNLib/VenderLib'
        t.dependency 'QNNLib/Base'
    end
    
    # 第三方库
    s.subspec 'VenderLib' do |v|
        v.source_files = 'QNNLib/Classes/VenderLib/**/*'
        v.dependency 'TTTAttributedLabel'
        #v.vendored_frameworks = ['QNNLib/Classes/VenderLib/TCWebCodesSDK.framework']
        #v.vendored_libraries  = 'QNNLib/Classes/VenderLib/**/*.{a}'
    end
    
    s.frameworks = 'SystemConfiguration',
    'CoreGraphics',
    'CoreTelephony',
    'Security',
    'CoreLocation',
    'AddressBook',
    'AddressBookUI',
    'AdSupport',
    
    s.resource_bundles = {
      'QNNLib' => ['QNNLib/Assets/*.png']
    }
    s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
    s.frameworks = 'UIKit'
end
