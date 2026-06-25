import Foundation

public enum InterviewType: String, Codable {
    case video
    case phone
    case inPerson = "in_person"
    case technical
    case hr
}

public enum InterviewStatus: String, Codable {
    case scheduled
    case completed
    case cancelled
    case rescheduled
    case all // Used for filtering
}

public struct InterviewResponse: Codable, Identifiable {
    public let id: String
    public let jobId: String
    public let userId: String
    public let round: String?
    public let interviewType: InterviewType
    public let scheduledAt: String?
    public let status: InterviewStatus
    public let interviewerName: String?
    public let location: String?
    public let meetingLink: String?
    public let feedback: String?
    public let createdAt: String
    public let updatedAt: String
}

public struct InterviewListResponse: Codable {
    public let total: Int
    public let interviews: [InterviewResponse]
}
