//
//  AppTheme.swift
//  jobAIPilot
//
//  Static facade that all components use.
//  Reads from AppThemeConfiguration.shared so overrides apply everywhere.
//
//  Related files:
//    AppThemeConfiguration.swift  — Injectable singleton (stored properties, configure, reset)
//    AppTheme+Helpers.swift       — ShadowStyle, .appShadow(), Color(hex:)
//    AppTheme+Preview.swift       — Xcode Canvas previews
//

import SwiftUI

struct AppTheme {
    
    // MARK: - Colors
    
    struct Colors {
        private static var c: AppThemeConfiguration { .shared }
        
        static var primary: Color        { c.primary }
        static var primaryDark: Color    { c.primaryDark }
        static var primaryLight: Color   { c.primaryLight }
        static var accent: Color         { c.accent }
        
        static var error: Color          { c.error }
        static var errorLight: Color     { c.errorLight }
        static var success: Color        { c.success }
        static var successLight: Color   { c.successLight }
        static var warning: Color        { c.warning }
        static var warningLight: Color   { c.warningLight }
        
        static var background: Color      { c.background }
        static var surface: Color         { c.surface }
        static var inputBackground: Color { c.inputBackground }
        static var border: Color          { c.border }
        static var borderFocused: Color   { c.borderFocused }
        
        static var textPrimary: Color    { c.textPrimary }
        static var textSecondary: Color  { c.textSecondary }
        static var textTertiary: Color   { c.textTertiary }
        static var textOnPrimary: Color  { c.textOnPrimary }
        static var placeholder: Color    { c.placeholder }
    }
    
    // MARK: - Typography
    
    struct Typography {
        private static var c: AppThemeConfiguration { .shared }
        
        static var largeTitle: Font  { c.largeTitleFont }
        static var title1: Font      { c.title1Font }
        static var title2: Font      { c.title2Font }
        static var title3: Font      { c.title3Font }
        static var headline: Font    { c.headlineFont }
        static var body: Font        { c.bodyFont }
        static var callout: Font     { c.calloutFont }
        static var subheadline: Font { c.subheadlineFont }
        static var footnote: Font    { c.footnoteFont }
        static var caption1: Font    { c.caption1Font }
        static var caption2: Font    { c.caption2Font }
        static var button: Font      { c.buttonFont }
        static var buttonSmall: Font { c.buttonSmallFont }
    }
    
    // MARK: - Radii
    
    struct Radius {
        private static var c: AppThemeConfiguration { .shared }
        
        static var small: CGFloat      { c.radiusSmall }
        static var medium: CGFloat     { c.radiusMedium }
        static var large: CGFloat      { c.radiusLarge }
        static var extraLarge: CGFloat { c.radiusExtraLarge }
        static var full: CGFloat       { c.radiusFull }
    }
    
    // MARK: - Spacing
    
    struct Spacing {
        private static var c: AppThemeConfiguration { .shared }
        
        static var xxxs: CGFloat { c.spacingXXXS }
        static var xxs: CGFloat  { c.spacingXXS }
        static var xs: CGFloat   { c.spacingXS }
        static var sm: CGFloat   { c.spacingSM }
        static var md: CGFloat   { c.spacingMD }
        static var lg: CGFloat   { c.spacingLG }
        static var xl: CGFloat   { c.spacingXL }
        static var xxl: CGFloat  { c.spacingXXL }
        static var xxxl: CGFloat { c.spacingXXXL }
    }
    
    // MARK: - Shadows
    
    struct Shadow {
        private static var c: AppThemeConfiguration { .shared }
        
        static var small: ShadowStyle  { c.shadowSmall }
        static var medium: ShadowStyle { c.shadowMedium }
        static var large: ShadowStyle  { c.shadowLarge }
    }
    
    // MARK: - Animation
    
    struct Animation {
        private static var c: AppThemeConfiguration { .shared }
        
        static var quick: SwiftUI.Animation    { c.animationQuick }
        static var standard: SwiftUI.Animation { c.animationStandard }
        static var spring: SwiftUI.Animation   { c.animationSpring }
    }
}
