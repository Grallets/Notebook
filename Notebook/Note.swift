import Foundation
import FirebaseFirestoreSwift

struct Note: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var content: String
    var timestamp: Date = Date()
    

    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "content": content,
            "timestamp": timestamp
        ]
    }
}

