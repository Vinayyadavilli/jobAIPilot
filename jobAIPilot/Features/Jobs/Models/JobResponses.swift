import Foundation

public enum JobStatus: String, Codable {
    case applied
    case interviewing
    case offered
    case rejected
    case withdrawn
    case all // Used for filtering
}

public struct JobResponse: Codable, Identifiable {
    public let id: String
    public let userId: String
    public let company: String
    public let role: String
    public let status: JobStatus
    public let source: String?
    public let appliedDate: String?
    public let jobUrl: String?
    public let location: String?
    public let salaryRange: String?
    public let description: String?
    public let createdAt: String
    public let updatedAt: String
}

public struct JobListResponse: Codable {
    public let total: Int
    public let jobs: [JobResponse]
}
