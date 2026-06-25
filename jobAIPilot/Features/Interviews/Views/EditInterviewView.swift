import SwiftUI

public struct EditInterviewView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: InterviewsViewModel
    
    let interview: InterviewResponse
    @State private var interviewType: InterviewType
    @State private var roundString: String
    @State private var scheduledAt: Date
    
    public init(viewModel: InterviewsViewModel, interview: InterviewResponse) {
        self.viewModel = viewModel
        self.interview = interview
        
        _interviewType = State(initialValue: interview.interviewType)
        _roundString = State(initialValue: interview.round ?? "")
        
        if let dateStr = interview.scheduledAt, let date = ISO8601DateFormatter().date(from: dateStr) {
            _scheduledAt = State(initialValue: date)
        } else {
            _scheduledAt = State(initialValue: Date())
        }
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Interview Details")) {
                    Picker("Type", selection: $interviewType) {
                        Text("Technical").tag(InterviewType.technical)
                        Text("HR").tag(InterviewType.hr)
                        Text("Video").tag(InterviewType.video)
                        Text("Phone").tag(InterviewType.phone)
                        Text("In Person").tag(InterviewType.inPerson)
                    }
                    
                    TextField("Round (Number)", text: $roundString)
                        .keyboardType(.numberPad)
                    
                    DatePicker("Date & Time", selection: $scheduledAt, displayedComponents: [.date, .hourAndMinute])
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Edit Interview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let formatter = ISO8601DateFormatter()
                        let dateStr = formatter.string(from: scheduledAt)
                        
                        Task {
                            let success = await viewModel.updateInterview(
                                id: interview.id,
                                round: roundString.isEmpty ? nil : roundString,
                                type: interviewType,
                                scheduledAt: dateStr
                            )
                            if success {
                                dismiss()
                            }
                        }
                    }
                    .disabled(viewModel.isLoading)
                }
            }
        }
    }
}
