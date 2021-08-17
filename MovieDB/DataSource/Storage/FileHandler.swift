import Foundation

final class FileHandler {
    private func documentDirectory() -> URL? {
        let documentDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentDirectory
    }

    func read(fileFromBundle: String, type: String) -> Data? {
        guard let bundle = Bundle.main.path(forResource: fileFromBundle, ofType: type) else {
            return nil
        }
        let path = URL(fileURLWithPath: bundle)
        return try? Data(contentsOf: path)
    }

    func read(fileFromDocuments fileName: String) -> Data? {
        guard let path = documentDirectory()?.appendingPathComponent(fileName) else {
            return nil
        }

        return try? Data(contentsOf: path)
    }

    func delete(fileFromDocuments fileName: String) {
        guard let path = documentDirectory()?.appendingPathComponent(fileName) else { return }
        try? FileManager.default.removeItem(at: path)
    }

    func save(data: Data, fileName: String) {
        guard let path = documentDirectory()?.appendingPathComponent(fileName) else {
            return
        }

        do {
            try data.write(to: path, options: .atomic)
        } catch {
            print("FILEHANDLER: Error", error)
            return
        }
        print("FILEHANDLER: \(fileName) saved")
    }
}
