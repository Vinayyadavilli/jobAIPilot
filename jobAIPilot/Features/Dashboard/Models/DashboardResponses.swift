import Foundation

public struct CompanyCount: Codable {
    public let company: String
    public let count: Int
}

public struct DashboardSummaryResponse: Codable {
    public let totalApplications: Int
    public let successRate: Double
    public let interviewRate: Double
    public let activeThisWeek: Int
    public let statusBreakdown: [String: Int]
    public let topCompanies: [CompanyCount]
}

public struct TimelineDataPoint: Codable {
    public let date: String
    public let count: Int
}

public struct DashboardTimelineResponse: Codable {
    public let timeline: [TimelineDataPoint]
}
