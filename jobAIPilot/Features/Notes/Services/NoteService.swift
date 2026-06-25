import Foundation
import NetworkKit

public protocol NoteServiceProtocol {
    func createNote(request: NoteCreateRequest) async throws -> NoteResponse
    func getNotes(request: GetNotesRequest) async throws -> NoteListResponse
    func getNote(request: GetNoteRequest) async throws -> NoteResponse
    func updateNote(request: NoteUpdateRequest) async throws -> NoteResponse
    func deleteNote(request: DeleteNoteRequest) async throws -> EmptyResponse
}

public final class NoteService: NoteServiceProtocol {
    private let client: NetworkClientProtocol
    
    public init(client: NetworkClientProtocol) {
        self.client = client
    }
    
    public func createNote(request: NoteCreateRequest) async throws -> NoteResponse {
        return try await client.send(request)
    }
    
    public func getNotes(request: GetNotesRequest) async throws -> NoteListResponse {
        return try await client.send(request)
    }
    
    public func getNote(request: GetNoteRequest) async throws -> NoteResponse {
        return try await client.send(request)
    }
    
    public func updateNote(request: NoteUpdateRequest) async throws -> NoteResponse {
        return try await client.send(request)
    }
    
    public func deleteNote(request: DeleteNoteRequest) async throws -> EmptyResponse {
        return try await client.send(request)
    }
}
