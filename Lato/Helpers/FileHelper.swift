//
//  FileHelper.swift
//  Lato
//
//  Created by juandahurt on 6/02/21.
//

import Foundation

struct FileHelper {
    func write(_ str: String, to fileName: String) {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            try str.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            debugPrint("Error at write func")
        }
    }
    
    func read(contentsOf fileName: String) -> String? {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            let text = try String(contentsOf: fileURL, encoding: .utf8)
            return text
        } catch {
            debugPrint("Error at read func")
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
