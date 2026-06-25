import Foundation
import NetworkKit

// MARK: - Get Summary Request
public struct GetDashboardSummaryRequest: NetworkRequest {
    public typealias Response = DashboardSummaryResponse
    
    public let path = "/dashboard/summary"
    public let method: HTTPMethod = .GET
    
    public init() {}
}

// MARK: - Get Timeline Request
public struct GetDashboardTimelineRequest: NetworkRequest {
    public typealias Response = DashboardTimelineResponse
    
    public let path = "/dashboard/timeline"
    public let method: HTTPMethod = .GET
    
    public init() {}
}

// MARK: - Get Status Breakdown Request
public struct GetDashboardStatusBreakdownRequest: NetworkRequest {
    public typealias Response = [String: Int]
    
    public let path = "/dashboard/by-status"
    public let method: HTTPMethod = .GET
    
    public init() {}
}
