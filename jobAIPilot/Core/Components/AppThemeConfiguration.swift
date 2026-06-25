//
//  AppThemeConfiguration.swift
//  jobAIPilot
//
//  Injectable singleton holding all design tokens.
//  Call `configure(...)` once at app launch to override any defaults.
//  Only pass the values you want to change — everything else keeps its default.
//
//  Usage:
//    AppThemeConfiguration.shared.configure(
//        primary: Color(hex: "#FF6B00"),
//        accent: Color(hex: "#00C853")
//    )
//

import SwiftUI

public final class AppThemeConfiguration: @unchecked Sendable {
    
    public static let shared = AppThemeConfiguration()
    
    // ─── Brand Colors ───────────────────────────────────────────────
    
    public var primary: Color
    public var primaryDark: Color
    public var primaryLight: Color
    public var accent: Color
    
    // ─── Semantic Colors ────────────────────────────────────────────
    
    public var error: Color
    public var errorLight: Color
    public var success: Color
    public var successLight: Color
    public var warning: Color
    public var warningLight: Color
    
    // ─── Surface Colors ─────────────────────────────────────────────
    
    public var background: Color
    public var surface: Color
    public var inputBackground: Color
    public var border: Color
    public var borderFocused: Color
    
    // ─── Text Colors ────────────────────────────────────────────────
    
    public var textPrimary: Color
    public var textSecondary: Color
    public var textTertiary: Color
    public var textOnPrimary: Color
    public var placeholder: Color
    
    // ─── Typography ─────────────────────────────────────────────────
    
    public var largeTitleFont: Font
    public var title1Font: Font
    public var title2Font: Font
    public var title3Font: Font
    public var headlineFont: Font
    public var bodyFont: Font
    public var calloutFont: Font
    public var subheadlineFont: Font
    public var footnoteFont: Font
    public var caption1Font: Font
    public var caption2Font: Font
    public var buttonFont: Font
    public var buttonSmallFont: Font
    
    // ─── Radii ──────────────────────────────────────────────────────
    
    public var radiusSmall: CGFloat
    public var radiusMedium: CGFloat
    public var radiusLarge: CGFloat
    public var radiusExtraLarge: CGFloat
    public var radiusFull: CGFloat
    
    // ─── Spacing ────────────────────────────────────────────────────
    
    public var spacingXXXS: CGFloat
    public var spacingXXS: CGFloat
    public var spacingXS: CGFloat
    public var spacingSM: CGFloat
    public var spacingMD: CGFloat
    public var spacingLG: CGFloat
    public var spacingXL: CGFloat
    public var spacingXXL: CGFloat
    public var spacingXXXL: CGFloat
    
    // ─── Shadows ────────────────────────────────────────────────────
    
    public var shadowSmall: ShadowStyle
    public var shadowMedium: ShadowStyle
    public var shadowLarge: ShadowStyle
    
    // ─── Animations ─────────────────────────────────────────────────
    
    public var animationQuick: Animation
    public var animationStandard: Animation
    public var animationSpring: Animation
    
    // MARK: - Init (all defaults)
    
    init() {
        // Brand
        self.primary        = Color(hex: "#4F46E5")
        self.primaryDark    = Color(hex: "#4338CA")
        self.primaryLight   = Color(hex: "#EEF2FF")
        self.accent         = Color(hex: "#06B6D4")
        
        // Semantic
        self.error          = Color(hex: "#EF4444")
        self.errorLight     = Color(hex: "#FEF2F2")
        self.success        = Color(hex: "#10B981")
        self.successLight   = Color(hex: "#ECFDF5")
        self.warning        = Color(hex: "#F59E0B")
        self.warningLight   = Color(hex: "#FFFBEB")
        
        // Surfaces
        self.background      = Color(UIColor.systemBackground)
        self.surface         = Color(UIColor.secondarySystemBackground)
        self.inputBackground = Color(UIColor.tertiarySystemBackground)
        self.border          = Color(UIColor.separator)
        self.borderFocused   = Color(hex: "#4F46E5")
        
        // Text
        self.textPrimary    = Color(UIColor.label)
        self.textSecondary  = Color(UIColor.secondaryLabel)
        self.textTertiary   = Color(UIColor.tertiaryLabel)
        self.textOnPrimary  = .white
        self.placeholder    = Color(UIColor.placeholderText)
        
        // Typography
        self.largeTitleFont  = .system(size: 34, weight: .bold, design: .rounded)
        self.title1Font      = .system(size: 28, weight: .bold, design: .rounded)
        self.title2Font      = .system(size: 22, weight: .semibold, design: .rounded)
        self.title3Font      = .system(size: 20, weight: .semibold, design: .rounded)
        self.headlineFont    = .system(size: 17, weight: .semibold)
        self.bodyFont        = .system(size: 17, weight: .regular)
        self.calloutFont     = .system(size: 16, weight: .regular)
        self.subheadlineFont = .system(size: 15, weight: .regular)
        self.footnoteFont    = .system(size: 13, weight: .regular)
        self.caption1Font    = .system(size: 12, weight: .regular)
        self.caption2Font    = .system(size: 11, weight: .regular)
        self.buttonFont      = .system(size: 17, weight: .semibold)
        self.buttonSmallFont = .system(size: 15, weight: .semibold)
        
        // Radii
        self.radiusSmall      = 8
        self.radiusMedium     = 12
        self.radiusLarge      = 16
        self.radiusExtraLarge = 24
        self.radiusFull       = 9999
        
        // Spacing
        self.spacingXXXS = 2
        self.spacingXXS  = 4
        self.spacingXS   = 8
        self.spacingSM   = 12
        self.spacingMD   = 16
        self.spacingLG   = 20
        self.spacingXL   = 24
        self.spacingXXL  = 32
        self.spacingXXXL = 48
        
        // Shadows
        self.shadowSmall  = ShadowStyle(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
        self.shadowMedium = ShadowStyle(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        self.shadowLarge  = ShadowStyle(color: .black.opacity(0.12), radius: 16, x: 0, y: 8)
        
        // Animations
        self.animationQuick    = .easeOut(duration: 0.15)
        self.animationStandard = .easeInOut(duration: 0.25)
        self.animationSpring   = .spring(response: 0.35, dampingFraction: 0.7)
    }
    
    // MARK: - Configure
    
    /// Override any subset of tokens. Only pass the values you want to change.
    public func configure(
        primary: Color? = nil,
        primaryDark: Color? = nil,
        primaryLight: Color? = nil,
        accent: Color? = nil,
        error: Color? = nil,
        errorLight: Color? = nil,
        success: Color? = nil,
        successLight: Color? = nil,
        warning: Color? = nil,
        warningLight: Color? = nil,
        background: Color? = nil,
        surface: Color? = nil,
        inputBackground: Color? = nil,
        border: Color? = nil,
        borderFocused: Color? = nil,
        textPrimary: Color? = nil,
        textSecondary: Color? = nil,
        textTertiary: Color? = nil,
        textOnPrimary: Color? = nil,
        placeholder: Color? = nil,
        largeTitleFont: Font? = nil,
        title1Font: Font? = nil,
        title2Font: Font? = nil,
        title3Font: Font? = nil,
        headlineFont: Font? = nil,
        bodyFont: Font? = nil,
        calloutFont: Font? = nil,
        subheadlineFont: Font? = nil,
        footnoteFont: Font? = nil,
        caption1Font: Font? = nil,
        caption2Font: Font? = nil,
        buttonFont: Font? = nil,
        buttonSmallFont: Font? = nil,
        radiusSmall: CGFloat? = nil,
        radiusMedium: CGFloat? = nil,
        radiusLarge: CGFloat? = nil,
        radiusExtraLarge: CGFloat? = nil,
        radiusFull: CGFloat? = nil,
        spacingXXXS: CGFloat? = nil,
        spacingXXS: CGFloat? = nil,
        spacingXS: CGFloat? = nil,
        spacingSM: CGFloat? = nil,
        spacingMD: CGFloat? = nil,
        spacingLG: CGFloat? = nil,
        spacingXL: CGFloat? = nil,
        spacingXXL: CGFloat? = nil,
        spacingXXXL: CGFloat? = nil,
        shadowSmall: ShadowStyle? = nil,
        shadowMedium: ShadowStyle? = nil,
        shadowLarge: ShadowStyle? = nil,
        animationQuick: Animation? = nil,
        animationStandard: Animation? = nil,
        animationSpring: Animation? = nil
    ) {
        if let v = primary        { self.primary = v; self.borderFocused = borderFocused ?? v }
        if let v = primaryDark    { self.primaryDark = v }
        if let v = primaryLight   { self.primaryLight = v }
        if let v = accent         { self.accent = v }
        if let v = error          { self.error = v }
        if let v = errorLight     { self.errorLight = v }
        if let v = success        { self.success = v }
        if let v = successLight   { self.successLight = v }
        if let v = warning        { self.warning = v }
        if let v = warningLight   { self.warningLight = v }
        if let v = background     { self.background = v }
        if let v = surface        { self.surface = v }
        if let v = inputBackground { self.inputBackground = v }
        if let v = border         { self.border = v }
        if let v = borderFocused  { self.borderFocused = v }
        if let v = textPrimary    { self.textPrimary = v }
        if let v = textSecondary  { self.textSecondary = v }
        if let v = textTertiary   { self.textTertiary = v }
        if let v = textOnPrimary  { self.textOnPrimary = v }
        if let v = placeholder    { self.placeholder = v }
        if let v = largeTitleFont  { self.largeTitleFont = v }
        if let v = title1Font      { self.title1Font = v }
        if let v = title2Font      { self.title2Font = v }
        if let v = title3Font      { self.title3Font = v }
        if let v = headlineFont    { self.headlineFont = v }
        if let v = bodyFont        { self.bodyFont = v }
        if let v = calloutFont     { self.calloutFont = v }
        if let v = subheadlineFont { self.subheadlineFont = v }
        if let v = footnoteFont    { self.footnoteFont = v }
        if let v = caption1Font    { self.caption1Font = v }
        if let v = caption2Font    { self.caption2Font = v }
        if let v = buttonFont      { self.buttonFont = v }
        if let v = buttonSmallFont { self.buttonSmallFont = v }
        if let v = radiusSmall      { self.radiusSmall = v }
        if let v = radiusMedium     { self.radiusMedium = v }
        if let v = radiusLarge      { self.radiusLarge = v }
        if let v = radiusExtraLarge { self.radiusExtraLarge = v }
        if let v = radiusFull       { self.radiusFull = v }
        if let v = spacingXXXS { self.spacingXXXS = v }
        if let v = spacingXXS  { self.spacingXXS = v }
        if let v = spacingXS   { self.spacingXS = v }
        if let v = spacingSM   { self.spacingSM = v }
        if let v = spacingMD   { self.spacingMD = v }
        if let v = spacingLG   { self.spacingLG = v }
        if let v = spacingXL   { self.spacingXL = v }
        if let v = spacingXXL  { self.spacingXXL = v }
        if let v = spacingXXXL { self.spacingXXXL = v }
        if let v = shadowSmall  { self.shadowSmall = v }
        if let v = shadowMedium { self.shadowMedium = v }
        if let v = shadowLarge  { self.shadowLarge = v }
        if let v = animationQuick    { self.animationQuick = v }
        if let v = animationStandard { self.animationStandard = v }
        if let v = animationSpring   { self.animationSpring = v }
    }
    
    // MARK: - Reset
    
    /// Resets all tokens back to factory defaults.
    public func reset() {
        let fresh = AppThemeConfiguration()
        self.primary = fresh.primary
        self.primaryDark = fresh.primaryDark
        self.primaryLight = fresh.primaryLight
        self.accent = fresh.accent
        self.error = fresh.error
        self.errorLight = fresh.errorLight
        self.success = fresh.success
        self.successLight = fresh.successLight
        self.warning = fresh.warning
        self.warningLight = fresh.warningLight
        self.background = fresh.background
        self.surface = fresh.surface
        self.inputBackground = fresh.inputBackground
        self.border = fresh.border
        self.borderFocused = fresh.borderFocused
        self.textPrimary = fresh.textPrimary
        self.textSecondary = fresh.textSecondary
        self.textTertiary = fresh.textTertiary
        self.textOnPrimary = fresh.textOnPrimary
        self.placeholder = fresh.placeholder
        self.largeTitleFont = fresh.largeTitleFont
        self.title1Font = fresh.title1Font
        self.title2Font = fresh.title2Font
        self.title3Font = fresh.title3Font
        self.headlineFont = fresh.headlineFont
        self.bodyFont = fresh.bodyFont
        self.calloutFont = fresh.calloutFont
        self.subheadlineFont = fresh.subheadlineFont
        self.footnoteFont = fresh.footnoteFont
        self.caption1Font = fresh.caption1Font
        self.caption2Font = fresh.caption2Font
        self.buttonFont = fresh.buttonFont
        self.buttonSmallFont = fresh.buttonSmallFont
        self.radiusSmall = fresh.radiusSmall
        self.radiusMedium = fresh.radiusMedium
        self.radiusLarge = fresh.radiusLarge
        self.radiusExtraLarge = fresh.radiusExtraLarge
        self.radiusFull = fresh.radiusFull
        self.spacingXXXS = fresh.spacingXXXS
        self.spacingXXS = fresh.spacingXXS
        self.spacingXS = fresh.spacingXS
        self.spacingSM = fresh.spacingSM
        self.spacingMD = fresh.spacingMD
        self.spacingLG = fresh.spacingLG
        self.spacingXL = fresh.spacingXL
        self.spacingXXL = fresh.spacingXXL
        self.spacingXXXL = fresh.spacingXXXL
        self.shadowSmall = fresh.shadowSmall
        self.shadowMedium = fresh.shadowMedium
        self.shadowLarge = fresh.shadowLarge
        self.animationQuick = fresh.animationQuick
        self.animationStandard = fresh.animationStandard
        self.animationSpring = fresh.animationSpring
    }
}
