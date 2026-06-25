import SwiftUI

public struct EditNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: NotesViewModel
    
    let note: NoteResponse
    @State private var content: String
    
    public init(viewModel: NotesViewModel, note: NoteResponse) {
        self.viewModel = viewModel
        self.note = note
        _content = State(initialValue: note.content)
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Note Details")) {
                    TextEditor(text: $content)
                        .frame(minHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            let success = await viewModel.updateNote(id: note.id, content: content)
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(content.isEmpty || viewModel.isLoading)
                }
            }
        }
    }
}
