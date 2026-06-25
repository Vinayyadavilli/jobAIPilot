import Foundation

public struct ResumeResponse: Codable, Identifiable {
    public let id: String
    public let originalUrl: String?
    public let rawText: String
    public let enhancedText: String
    public let downloadUrl: String
    public let createdAt: String
}

public struct ResumeListResponse: Codable {
    public let total: Int
    public let resumes: [ResumeResponse]
}
