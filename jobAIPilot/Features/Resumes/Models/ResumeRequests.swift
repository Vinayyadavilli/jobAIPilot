import Foundation
import NetworkKit

// MARK: - Enhance URL Request
public struct EnhanceUrlRequest: NetworkRequest {
    public typealias Response = ResumeResponse
    
    public let path = "/resumes/enhance"
    public let method: HTTPMethod = .POST
    
    public let url: String
    
    private struct Body: Encodable {
        let url: String
    }
    
    public var body: Encodable? {
        Body(url: url)
    }
    
    public init(url: String) {
        self.url = url
    }
}

// MARK: - List Resumes Request
public struct GetResumesRequest: NetworkRequest {
    public typealias Response = ResumeListResponse
    
    public let path = "/resumes"
    public let method: HTTPMethod = .GET
    
    public let skip: Int
    public let limit: Int
    
    public var queryParameters: [String: String]? {
        return [
            "skip": String(skip),
            "limit": String(limit)
        ]
    }
    
    public init(skip: Int = 0, limit: Int = 50) {
        self.skip = skip
        self.limit = limit
    }
}

// MARK: - Get Single Resume Request
public struct GetResumeRequest: NetworkRequest {
    public typealias Response = ResumeResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public init(resumeId: String) {
        self.path = "/resumes/\(resumeId)"
    }
}

// MARK: - Delete Resume Request
public struct DeleteResumeRequest: NetworkRequest {
    public typealias Response = EmptyResponse
    
    public let path: String
    public let method: HTTPMethod = .DELETE
    
    public init(resumeId: String) {
        self.path = "/resumes/\(resumeId)"
    }
}
