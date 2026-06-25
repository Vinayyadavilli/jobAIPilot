import SwiftUI

public struct AddResumeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ResumesViewModel
    
    @State private var urlString: String = ""
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Resume PDF URL"), footer: Text("Provide a direct link to a PDF to be analyzed.")) {
                    TextField("https://example.com/resume.pdf", text: $urlString)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Enhance Resume")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        Task {
                            let success = await viewModel.enhanceResume(url: urlString)
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(urlString.isEmpty || viewModel.isLoading)
                }
            }
        }
    }
}
