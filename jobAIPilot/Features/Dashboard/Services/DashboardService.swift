import Foundation
import NetworkKit

public protocol DashboardServiceProtocol {
    func getSummary() async throws -> DashboardSummaryResponse
    func getTimeline() async throws -> DashboardTimelineResponse
    func getStatusBreakdown() async throws -> [String: Int]
}

public final class DashboardService: DashboardServiceProtocol {
    private let client: NetworkClientProtocol
    
    public init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func getSummary() async throws -> DashboardSummaryResponse {
        return try await client.send(GetDashboardSummaryRequest())
    }
    
    public func getTimeline() async throws -> DashboardTimelineResponse {
        return try await client.send(GetDashboardTimelineRequest())
    }
    
    public func getStatusBreakdown() async throws -> [String: Int] {
        return try await client.send(GetDashboardStatusBreakdownRequest())
    }
}
