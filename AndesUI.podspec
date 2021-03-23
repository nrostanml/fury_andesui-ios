Pod::Spec.new do |s|
    s.name             = 'AndesUI'
    s.version          = '4.0.0'
    s.summary          = 'AndesUI library for ios app.'
    
    s.description      = 'AndesUI is the UI library of Mercado Libre. It provides the definitions, components and tools to build consistent experiences, with agility and visual quality.'
    
    s.homepage         = 'https://github.com/mercadolibre/fury_andesui-ios'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = 'Mercado Libre'
    s.source = { :http => "https://mercadolibre.bintray.com/ios-public/AndesUI/#{s.version}/LibraryComponents.zip" }
    
    s.platform         = :ios, '10.0'
    s.requires_arc     = true
    s.swift_version = '5.0'
    s.default_subspec = 'Core'
    
    s.subspec 'Core' do |core|
        core.source_files = 'LibraryComponents/Classes/Core/**/*.{h,m,swift}'
        core.resource_bundle = {'AndesUIResources' => ['LibraryComponents/Classes/Core/**/*.{xib}',
            'LibraryComponents/Resources/Core/Assets/AndesPaletteColors.xcassets', 'LibraryComponents/Resources/Core/Strings/*.lproj']}
        
        # remove this if we start using remote strategy for icons
        core.dependency 'AndesUI/LocalIcons'
    end
    
    s.subspec 'AndesCoachmark' do |coachmark|
        coachmark.source_files = 'LibraryComponents/Classes/AndesCoachmark/**/*.{h,m,swift}'
        
        coachmark.dependency 'AndesUI/Core'
    end
    
    s.subspec 'AndesBottomSheet' do |bottomsheet|
        bottomsheet.source_files = 'LibraryComponents/Classes/AndesBottomSheet/**/*.{h,m,swift}'
        
        bottomsheet.dependency 'AndesUI/Core'
    end
    
    s.subspec 'AndesDropdown' do |dropdown|
        dropdown.source_files = 'LibraryComponents/Classes/AndesDropdown/**/*.{h,m,swift}'
        dropdown.resource_bundle = {'AndesDropdownResources' => ['LibraryComponents/Classes/AndesDropdown/**/*.{xib}']}
        
        dropdown.dependency 'AndesUI/Core'
        dropdown.dependency 'AndesUI/AndesBottomSheet'
    end
    
    s.subspec 'LocalIcons' do |la|
        la.resource_bundle = {'AndesIcons' => ['LibraryComponents/Resources/LocalIcons/Assets/Images.xcassets']}
    end
end
