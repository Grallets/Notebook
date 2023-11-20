import SwiftUI

struct ListofNotesView: View {
    @ObservedObject var firebaseManager = FirebaseManager.shared
    @State private var showingAddNoteView = false
    @State private var isSortedDescending = true

    var body: some View {
        
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(firebaseManager.notes, id: \.id) { note in
                        VStack(alignment: .leading) {
                            Text(note.title).font(.headline)
                            Text(note.content).font(.subheadline)
                        }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let noteID = firebaseManager.notes[index].id ?? ""
                            firebaseManager.deleteNote(noteID)
                        }
                    }
                }

                Button(action: {
                    showingAddNoteView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundColor(Color.blue)
                        .padding().padding()
                }
                .sheet(isPresented: $showingAddNoteView) {
                    AddNotesView()
                }
            }
            .navigationBarTitle("Your Notes", displayMode: .inline)
            .navigationBarItems(leading: Button("Sort By: \(isSortedDescending ? "Newest" : "Oldest")") {
                isSortedDescending.toggle()
                firebaseManager.fetchNotes(sortedDescending: isSortedDescending)
            })
            .onAppear {
                firebaseManager.fetchNotes(sortedDescending: isSortedDescending)
            }
        }
    }


struct ListofNotesView_Previews: PreviewProvider {
    static var previews: some View {
        ListofNotesView()
    }
}
