import Foundation

public struct NoteResponse: Codable, Identifiable {
    public let id: String
    public let jobId: String
    public let userId: String
    public let content: String
    public let createdAt: String
    public let updatedAt: String
}

public struct NoteListResponse: Codable {
    public let total: Int
    public let notes: [NoteResponse]
}
