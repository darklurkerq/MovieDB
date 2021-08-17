import Foundation

final class Cache<T: Codable> {

    private struct Entry: Codable {
        let data: T
        let expirationDate: Date
    }

    private var genericTypeName: String {
        return String(describing: T.self)
    }

    private let entryLifeTime: TimeInterval = 24 * 60 * 60

    func loadData() -> T? {
        if let fileData = FileHandler().read(fileFromDocuments: "\(genericTypeName).json") {
            guard let entry = try? JSONDecoder().decode(Entry.self, from: fileData) else {
                return nil
            }
            if entry.expirationDate < Date() {
                return nil
            }
            return entry.data
        } else {
            return nil
        }
    }

    func saveData(_ data: T) {
        let expiration = Date().addingTimeInterval(entryLifeTime)
        let entry = Entry(data: data, expirationDate: expiration)
        if let fileData = try? JSONEncoder().encode(entry) {
            FileHandler().save(data: fileData, fileName: "\(genericTypeName).json")
        }
    }

    func deleteData() {
        FileHandler().delete(fileFromDocuments: "\(genericTypeName).json")
    }
}
