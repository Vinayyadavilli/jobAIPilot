import SwiftUI

public struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: NotesViewModel
    @ObservedObject var jobsViewModel: JobsViewModel
    
    @State private var jobId: String = ""
    @State private var content: String = ""
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Note Details")) {
                    Picker("Select Job", selection: $jobId) {
                        if jobsViewModel.jobs.isEmpty {
                            Text("General Note (No Job)").tag("")
                        } else {
                            Text("General Note (No Job)").tag("")
                            ForEach(jobsViewModel.jobs) { job in
                                Text("\(job.company) - \(job.role)").tag(job.id)
                            }
                        }
                    }
                    
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
            .navigationTitle("Add Note")
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
                            let success = await viewModel.createNote(jobId: jobId, content: content)
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(jobId.isEmpty || content.isEmpty || viewModel.isLoading)
                }
            }
            .onAppear {
                Task {
                    await jobsViewModel.fetchJobs()
                }
            }
        }
    }
}
