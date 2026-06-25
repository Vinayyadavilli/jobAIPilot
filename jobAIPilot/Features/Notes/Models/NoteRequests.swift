import Foundation
import NetworkKit

// MARK: - Create Note Request
public struct NoteCreateRequest: NetworkRequest {
    public typealias Response = NoteResponse
    
    public let path: String
    public let method: HTTPMethod = .POST
    
    public let jobId: String
    public let content: String
    
    private struct Body: Encodable {
        let jobId: String
        let content: String
    }
    
    public var body: Encodable? {
        Body(jobId: jobId, content: content)
    }
    
    public init(jobId: String, content: String) {
        self.path = "/jobs/\(jobId)/notes"
        self.jobId = jobId
        self.content = content
    }
}

// MARK: - List Notes Request
public struct GetNotesRequest: NetworkRequest {
    public typealias Response = NoteListResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public let jobId: String
    public let skip: Int
    public let limit: Int
    
    public var queryParameters: [String: String]? {
        var params: [String: String] = [
            "skip": String(skip),
            "limit": String(limit)
        ]
        if !jobId.isEmpty {
            params["job_id"] = jobId
        }
        return params
    }
    
    public init(jobId: String = "", skip: Int = 0, limit: Int = 50) {
        self.jobId = jobId
        self.skip = skip
        self.limit = limit
        if jobId.isEmpty {
            self.path = "/notes"
        } else {
            self.path = "/jobs/\(jobId)/notes"
        }
    }
}

// MARK: - Get Single Note Request
public struct GetNoteRequest: NetworkRequest {
    public typealias Response = NoteResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public init(noteId: String) {
        self.path = "/notes/\(noteId)"
    }
}

// MARK: - Update Note Request
public struct NoteUpdateRequest: NetworkRequest {
    public typealias Response = NoteResponse
    
    public let path: String
    public let method: HTTPMethod = .PUT
    
    public let content: String
    
    private struct Body: Encodable {
        let content: String
    }
    
    public var body: Encodable? {
        Body(content: content)
    }
    
    public init(noteId: String, content: String) {
        self.path = "/notes/\(noteId)"
        self.content = content
    }
}

// MARK: - Delete Note Request
public struct DeleteNoteRequest: NetworkRequest {
    public typealias Response = EmptyResponse
    
    public let path: String
    public let method: HTTPMethod = .DELETE
    
    public init(noteId: String) {
        self.path = "/notes/\(noteId)"
    }
}
