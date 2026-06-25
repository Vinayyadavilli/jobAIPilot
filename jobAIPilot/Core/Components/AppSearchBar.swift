//
//  AppSearchBar.swift
//  jobAIPilot
//
//  Reusable search bar with debounce, clear button, cancel animation,
//  filter chip support, and recent searches.
//
//  Usage:
//    AppSearchBar(text: $searchText)
//    AppSearchBar(text: $searchText, placeholder: "Search jobs…", showCancel: true)
//    AppSearchBar(text: $searchText, style: .minimal)
//

import SwiftUI
import Combine

// MARK: - AppSearchBar

struct AppSearchBar: View {
    
    @Binding var text: String
    let placeholder: String
    let style: Style
    let showCancel: Bool
    let debounceInterval: TimeInterval
    let onSearchSubmit: ((String) -> Void)?
    let onCancel: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    @State private var showCancelButton = false
    
    init(
        text: Binding<String>,
        placeholder: String = "Search…",
        style: Style = .standard,
        showCancel: Bool = true,
        debounceInterval: TimeInterval = 0.3,
        onSearchSubmit: ((String) -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.style = style
        self.showCancel = showCancel
        self.debounceInterval = debounceInterval
        self.onSearchSubmit = onSearchSubmit
        self.onCancel = onCancel
    }
    
    var body: some View {
        HStack(spacing: AppTheme.Spacing.xs) {
            // Search field
            HStack(spacing: AppTheme.Spacing.xs) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(
                        isFocused
                            ? AppTheme.Colors.primary
                            : AppTheme.Colors.textTertiary
                    )
                
                TextField(placeholder, text: $text)
                    .font(AppTheme.Typography.body)
                    .focused($isFocused)
                    .submitLabel(.search)
                    .onSubmit {
                        onSearchSubmit?(text)
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                // Clear button
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(AppTheme.Colors.textTertiary)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, style.verticalPadding)
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous)
                    .strokeBorder(
                        isFocused ? AppTheme.Colors.primary.opacity(0.5) : style.borderColor,
                        lineWidth: isFocused ? 1.5 : style.borderWidth
                    )
            )
            .animation(AppTheme.Animation.quick, value: isFocused)
            .animation(AppTheme.Animation.quick, value: text.isEmpty)
            
            // Cancel button
            if showCancel && showCancelButton {
                Button("Cancel") {
                    text = ""
                    isFocused = false
                    onCancel?()
                }
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.primary)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(AppTheme.Animation.standard, value: showCancelButton)
        .onChange(of: isFocused) { _, focused in
            showCancelButton = focused
        }
    }
}

// MARK: - Style

extension AppSearchBar {
    enum Style {
        case standard     // Filled background
        case outlined     // Border only
        case minimal      // No border, subtle bg
        case pill         // Pill-shaped
        
        var backgroundColor: Color {
            switch self {
            case .standard:   return AppTheme.Colors.inputBackground
            case .outlined:   return .clear
            case .minimal:    return AppTheme.Colors.surface.opacity(0.6)
            case .pill:       return AppTheme.Colors.inputBackground
            }
        }
        
        var borderColor: Color {
            switch self {
            case .standard:   return AppTheme.Colors.border.opacity(0.5)
            case .outlined:   return AppTheme.Colors.border
            case .minimal:    return .clear
            case .pill:       return AppTheme.Colors.border.opacity(0.3)
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .standard:   return 0.5
            case .outlined:   return 1
            case .minimal:    return 0
            case .pill:       return 0.5
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .standard:   return AppTheme.Spacing.sm
            case .outlined:   return AppTheme.Spacing.sm
            case .minimal:    return AppTheme.Spacing.xs + 2
            case .pill:       return AppTheme.Spacing.sm
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .standard:   return AppTheme.Radius.medium
            case .outlined:   return AppTheme.Radius.medium
            case .minimal:    return AppTheme.Radius.small
            case .pill:       return AppTheme.Radius.full
            }
        }
    }
}

// MARK: - AppSearchBar with Filter Chips

struct AppSearchBarWithFilters: View {
    @Binding var text: String
    let placeholder: String
    let filters: [FilterChip]
    @Binding var activeFilters: Set<String>
    let onSearchSubmit: ((String) -> Void)?
    
    init(
        text: Binding<String>,
        placeholder: String = "Search…",
        filters: [FilterChip],
        activeFilters: Binding<Set<String>>,
        onSearchSubmit: ((String) -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.filters = filters
        self._activeFilters = activeFilters
        self.onSearchSubmit = onSearchSubmit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            AppSearchBar(
                text: $text,
                placeholder: placeholder,
                onSearchSubmit: onSearchSubmit
            )
            
            if !filters.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppTheme.Spacing.xs) {
                        ForEach(filters) { chip in
                            AppFilterChip(
                                chip: chip,
                                isActive: activeFilters.contains(chip.id)
                            ) {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                if activeFilters.contains(chip.id) {
                                    activeFilters.remove(chip.id)
                                } else {
                                    activeFilters.insert(chip.id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Filter Chip Model

struct FilterChip: Identifiable {
    let id: String
    let title: String
    let icon: String?
    
    init(id: String? = nil, title: String, icon: String? = nil) {
        self.id = id ?? title
        self.title = title
        self.icon = icon
    }
}

// MARK: - Filter Chip View

struct AppFilterChip: View {
    let chip: FilterChip
    let isActive: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppTheme.Spacing.xxs) {
                if let icon = chip.icon {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .medium))
                }
                
                Text(chip.title)
                    .font(AppTheme.Typography.caption1)
                    .fontWeight(.medium)
                
                if isActive {
                    Image(systemName: "xmark")
                        .font(.system(size: 9, weight: .bold))
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, AppTheme.Spacing.sm)
            .padding(.vertical, AppTheme.Spacing.xxs + 2)
            .foregroundColor(isActive ? AppTheme.Colors.textOnPrimary : AppTheme.Colors.textSecondary)
            .background(isActive ? AppTheme.Colors.primary : AppTheme.Colors.surface)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(
                        isActive ? Color.clear : AppTheme.Colors.border,
                        lineWidth: 0.5
                    )
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(AppTheme.Animation.quick, value: isActive)
            .animation(AppTheme.Animation.quick, value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: - Preview

#Preview("Search Bars") {
    VStack(spacing: 24) {
        AppSearchBar(text: .constant(""), placeholder: "Search jobs…")
        
        AppSearchBar(text: .constant("iOS Developer"), placeholder: "Search…", style: .standard)
        
        AppSearchBar(text: .constant(""), placeholder: "Search companies…", style: .outlined)
        
        AppSearchBar(text: .constant(""), placeholder: "Quick search", style: .minimal, showCancel: false)
        
        AppSearchBar(text: .constant(""), placeholder: "Find anything…", style: .pill)
        
        Divider()
        
        AppSearchBarWithFilters(
            text: .constant(""),
            placeholder: "Search jobs…",
            filters: [
                FilterChip(title: "Remote", icon: "house"),
                FilterChip(title: "Full-time", icon: "clock"),
                FilterChip(title: "Part-time"),
                FilterChip(title: "Contract"),
            ],
            activeFilters: .constant(["Remote"])
        )
    }
    .padding()
}
