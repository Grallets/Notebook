import Foundation
import FirebaseFirestoreSwift  // For Firestore Codable support

struct UserData: Codable {
    @DocumentID var id: String?  // Automatically managed Firestore document ID
    var email: String
}
