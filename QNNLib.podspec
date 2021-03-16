
Pod::Spec.new do |s|
    s.name             = 'QNNLib'
    s.version          = '0.1.1'
    s.summary          = 'QNNLib'
    s.description      = <<-DESC
    Swift 私有组件库
    DESC
    
    s.homepage         = 'https://github.com/wangdongyang/QNNLib.git'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'joewang' => 'joewang@qianshengqian.com' }
    s.source           = { :git => 'git@github.com:wangdongyang/QNNLib.git', :tag => s.version.to_s }
    
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
        c.dependency 'SDWebImage'
        c.dependency 'QNNLib/Base'
        c.dependency 'SnapKit'
        c.dependency 'Then', '~> 2.6.0'
        c.dependency 'Toast'
    end
    
    # 工具库
    s.subspec 'Tools' do |m|
        m.source_files = 'QNNLib/Classes/Tools/**/*'
        m.dependency 'Fuzi'
        m.dependency 'FCUUID'
        m.dependency 'SDWebImage'
        m.dependency 'SwiftyJSON'
        m.dependency 'QNNLib/Extension'
        m.dependency 'QNNLib/Base'
        m.dependency 'Toast'
    end
    
    # 封装的组件库
    s.subspec 'UIComponents' do |t|
        t.source_files = 'QNNLib/Classes/UIComponents/**/*'
        t.dependency 'FSPagerView'
        t.dependency 'SnapKit'
        t.dependency 'Then', '~> 2.6.0'
        t.dependency 'QNNLib/Extension'
        t.dependency 'QNNLib/Tools'
        t.dependency 'QNNLib/VenderLib'
        t.dependency 'QNNLib/Base'
    end
    
    # 第三方库
    s.subspec 'VenderLib' do |v|
        v.source_files = 'QNNLib/Classes/VenderLib/**/*'
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
