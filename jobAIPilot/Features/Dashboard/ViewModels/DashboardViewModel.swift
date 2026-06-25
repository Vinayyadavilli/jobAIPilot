import Foundation
import SwiftUI
import Combine

@MainActor
public final class DashboardViewModel: ObservableObject {
    private let dashboardService: DashboardServiceProtocol
    
    @Published public var summary: DashboardSummaryResponse?
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    public init(dashboardService: DashboardServiceProtocol) {
        self.dashboardService = dashboardService
    }
    
    public func fetchSummary() async {
        isLoading = true
        errorMessage = nil
        do {
            summary = try await dashboardService.getSummary()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
