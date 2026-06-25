import Foundation
import NetworkKit

// MARK: - Create Interview Request
public struct InterviewCreateRequest: NetworkRequest {
    public typealias Response = InterviewResponse
    
    public let path: String
    public let method: HTTPMethod = .POST
    
    public let jobId: String
    public let round: String?
    public let interviewType: InterviewType
    public let scheduledAt: String?
    public let status: InterviewStatus
    public let interviewerName: String?
    public let location: String?
    public let meetingLink: String?
    public let feedback: String?
    
    private struct Body: Encodable {
        let jobId: String
        let round: String?
        let interviewType: InterviewType
        let scheduledAt: String?
        let status: InterviewStatus
        let interviewerName: String?
        let location: String?
        let meetingLink: String?
        let feedback: String?
    }
    
    public var body: Encodable? {
        Body(jobId: jobId, round: round, interviewType: interviewType, scheduledAt: scheduledAt, status: status, interviewerName: interviewerName, location: location, meetingLink: meetingLink, feedback: feedback)
    }
    
    public init(jobId: String, round: String? = nil, interviewType: InterviewType = .video, scheduledAt: String? = nil, status: InterviewStatus = .scheduled, interviewerName: String? = nil, location: String? = nil, meetingLink: String? = nil, feedback: String? = nil) {
        self.path = "/jobs/\(jobId)/interviews"
        self.jobId = jobId
        self.round = round
        self.interviewType = interviewType
        self.scheduledAt = scheduledAt
        self.status = status
        self.interviewerName = interviewerName
        self.location = location
        self.meetingLink = meetingLink
        self.feedback = feedback
    }
}

// MARK: - List Interviews Request
public struct GetInterviewsRequest: NetworkRequest {
    public typealias Response = InterviewListResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public let status: InterviewStatus
    public let jobId: String?
    public let skip: Int
    public let limit: Int
    
    public var queryParameters: [String: String]? {
        var params: [String: String] = [
            "status": status.rawValue,
            "skip": String(skip),
            "limit": String(limit)
        ]
        if let jobId = jobId {
            params["job_id"] = jobId
        }
        return params
    }
    
    public init(status: InterviewStatus = .all, jobId: String? = nil, skip: Int = 0, limit: Int = 50) {
        self.status = status
        self.jobId = jobId
        self.skip = skip
        self.limit = limit
        if let jobId = jobId, !jobId.isEmpty {
            self.path = "/jobs/\(jobId)/interviews"
        } else {
            self.path = "/interviews"
        }
    }
}

// MARK: - Get Single Interview Request
public struct GetInterviewRequest: NetworkRequest {
    public typealias Response = InterviewResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public init(interviewId: String) {
        self.path = "/interviews/\(interviewId)"
    }
}

// MARK: - Update Interview Request
public struct InterviewUpdateRequest: NetworkRequest {
    public typealias Response = InterviewResponse
    
    public let path: String
    public let method: HTTPMethod = .PUT
    
    public let round: String?
    public let interviewType: InterviewType?
    public let scheduledAt: String?
    public let status: InterviewStatus?
    public let interviewerName: String?
    public let location: String?
    public let meetingLink: String?
    public let feedback: String?
    
    private struct Body: Encodable {
        let round: String?
        let interviewType: InterviewType?
        let scheduledAt: String?
        let status: InterviewStatus?
        let interviewerName: String?
        let location: String?
        let meetingLink: String?
        let feedback: String?
    }
    
    public var body: Encodable? {
        Body(round: round, interviewType: interviewType, scheduledAt: scheduledAt, status: status, interviewerName: interviewerName, location: location, meetingLink: meetingLink, feedback: feedback)
    }
    
    public init(interviewId: String, round: String? = nil, interviewType: InterviewType? = nil, scheduledAt: String? = nil, status: InterviewStatus? = nil, interviewerName: String? = nil, location: String? = nil, meetingLink: String? = nil, feedback: String? = nil) {
        self.path = "/interviews/\(interviewId)"
        self.round = round
        self.interviewType = interviewType
        self.scheduledAt = scheduledAt
        self.status = status
        self.interviewerName = interviewerName
        self.location = location
        self.meetingLink = meetingLink
        self.feedback = feedback
    }
}

// MARK: - Delete Interview Request
public struct DeleteInterviewRequest: NetworkRequest {
    public typealias Response = EmptyResponse // Can reuse from Jobs or recreate locally
    
    public let path: String
    public let method: HTTPMethod = .DELETE
    
    public init(interviewId: String) {
        self.path = "/interviews/\(interviewId)"
    }
}
