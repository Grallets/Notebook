import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager: ObservableObject {
    
    static let shared = FirebaseManager()
    @Published var notes: [Note] = []

    private let db = Firestore.firestore() // Firestore database instance
    private init() {}
    
    // User Registration Method
    func registerUser(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            completion(true, nil)
        }
    }

    
    func loginUser(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            self.fetchNotes(sortedDescending: true) 
            completion(true, nil)
        }
    }
    
    func fetchNotes(sortedDescending: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            self.notes = [] // Clear notes if user is not logged in
            return
        }

        db.collection("notes")
          .whereField("userID", isEqualTo: userID)
          .order(by: "timestamp", descending: sortedDescending)
          .getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.notes = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Note.self)
                }
            }
        }
    }

    func addNote(_ note: Note) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        var noteData = note.toDictionary()
        noteData["userID"] = userID

        db.collection("notes").document().setData(noteData) { error in
            if let error = error {
                print("Error adding note: \(error.localizedDescription)")
                return
            }
            self.fetchNotes(sortedDescending: true)  // Refresh the notes list
        }
    }

    func deleteNote(_ noteID: String) {
        db.collection("notes").document(noteID).delete() { error in
            if let error = error {
                print("Error deleting note: \(error.localizedDescription)")
                return
            }
            self.fetchNotes(sortedDescending: true)  // Refresh the notes list
        }
    }
}
