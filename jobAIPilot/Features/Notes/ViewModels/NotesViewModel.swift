import Foundation
import SwiftUI
import Combine

@MainActor
public final class NotesViewModel: ObservableObject {
    private let noteService: NoteServiceProtocol
    
    @Published public var notes: [NoteResponse] = []
    @Published public var errorMessage: String?
    @Published public var isLoading: Bool = false
    
    public init(noteService: NoteServiceProtocol) {
        self.noteService = noteService
    }
    
    // Defaulting jobId to an empty string to fetch all for now, or you'd pass it in
    public func fetchNotes(forJobId jobId: String = "") async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await noteService.getNotes(request: GetNotesRequest(jobId: jobId))
            notes = response.notes
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    public func createNote(jobId: String, content: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = NoteCreateRequest(jobId: jobId, content: content)
            _ = try await noteService.createNote(request: request)
            await fetchNotes()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func updateNote(id: String, content: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = NoteUpdateRequest(noteId: id, content: content)
            _ = try await noteService.updateNote(request: request)
            await fetchNotes()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    public func deleteNote(id: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        do {
            let request = DeleteNoteRequest(noteId: id)
            _ = try await noteService.deleteNote(request: request)
            await fetchNotes()
            return true
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}
