import SwiftUI

struct AddNotesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var content = ""
    var onAddNote: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                    .padding()
                
                TextEditor(text: $content)
                    .border(Color.gray, width: 1)
                    .padding()
                
                Button("Add Note") {
                    let newNote = Note(title: title, content: content)
                    FirebaseManager.shared.addNote(newNote)
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
                .navigationBarTitle("Add Note", displayMode: .inline)
                .navigationBarItems(leading: Button("Go Back") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    struct AddNotesView_Previews: PreviewProvider {
        static var previews: some View {
            AddNotesView()
        }
    }
}
