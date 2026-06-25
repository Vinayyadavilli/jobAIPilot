import Foundation
import NetworkKit

// MARK: - Create Job Request
public struct JobCreateRequest: NetworkRequest {
    public typealias Response = JobResponse
    
    public let path = "/jobs"
    public let method: HTTPMethod = .POST
    
    public let company: String
    public let role: String
    public let status: JobStatus
    public let source: String?
    public let appliedDate: String?
    public let jobUrl: String?
    public let location: String?
    public let salaryRange: String?
    public let description: String?
    
    private struct Body: Encodable {
        let company: String
        let role: String
        let status: JobStatus
        let source: String?
        let appliedDate: String?
        let jobUrl: String?
        let location: String?
        let salaryRange: String?
        let description: String?
    }
    
    public var body: Encodable? {
        Body(company: company, role: role, status: status, source: source, appliedDate: appliedDate, jobUrl: jobUrl, location: location, salaryRange: salaryRange, description: description)
    }
    
    public init(company: String, role: String, status: JobStatus = .applied, source: String? = nil, appliedDate: String? = nil, jobUrl: String? = nil, location: String? = nil, salaryRange: String? = nil, description: String? = nil) {
        self.company = company
        self.role = role
        self.status = status
        self.source = source
        self.appliedDate = appliedDate
        self.jobUrl = jobUrl
        self.location = location
        self.salaryRange = salaryRange
        self.description = description
    }
}

// MARK: - List Jobs Request
public struct GetJobsRequest: NetworkRequest {
    public typealias Response = JobListResponse
    
    public let path = "/jobs"
    public let method: HTTPMethod = .GET
    
    public let status: JobStatus
    public let search: String?
    public let skip: Int
    public let limit: Int
    
    public var queryParameters: [String: String]? {
        var params: [String: String] = [
            "status": status.rawValue,
            "skip": String(skip),
            "limit": String(limit)
        ]
        if let search = search {
            params["search"] = search
        }
        return params
    }
    
    public init(status: JobStatus = .all, search: String? = nil, skip: Int = 0, limit: Int = 50) {
        self.status = status
        self.search = search
        self.skip = skip
        self.limit = limit
    }
}

// MARK: - Get Single Job Request
public struct GetJobRequest: NetworkRequest {
    public typealias Response = JobResponse
    
    public let path: String
    public let method: HTTPMethod = .GET
    
    public init(jobId: String) {
        self.path = "/jobs/\(jobId)"
    }
}

// MARK: - Update Job Request
public struct JobUpdateRequest: NetworkRequest {
    public typealias Response = JobResponse
    
    public let path: String
    public let method: HTTPMethod = .PUT
    
    public let company: String?
    public let role: String?
    public let status: JobStatus?
    public let source: String?
    public let appliedDate: String?
    public let jobUrl: String?
    public let location: String?
    public let salaryRange: String?
    public let description: String?
    
    private struct Body: Encodable {
        let company: String?
        let role: String?
        let status: JobStatus?
        let source: String?
        let appliedDate: String?
        let jobUrl: String?
        let location: String?
        let salaryRange: String?
        let description: String?
    }
    
    public var body: Encodable? {
        Body(company: company, role: role, status: status, source: source, appliedDate: appliedDate, jobUrl: jobUrl, location: location, salaryRange: salaryRange, description: description)
    }
    
    public init(jobId: String, company: String? = nil, role: String? = nil, status: JobStatus? = nil, source: String? = nil, appliedDate: String? = nil, jobUrl: String? = nil, location: String? = nil, salaryRange: String? = nil, description: String? = nil) {
        self.path = "/jobs/\(jobId)"
        self.company = company
        self.role = role
        self.status = status
        self.source = source
        self.appliedDate = appliedDate
        self.jobUrl = jobUrl
        self.location = location
        self.salaryRange = salaryRange
        self.description = description
    }
}

// MARK: - Delete Job Request
public struct DeleteJobRequest: NetworkRequest {
    public typealias Response = EmptyResponse // Assuming empty response, might need EmptyResponse struct
    
    public let path: String
    public let method: HTTPMethod = .DELETE
    
    public init(jobId: String) {
        self.path = "/jobs/\(jobId)"
    }
}
