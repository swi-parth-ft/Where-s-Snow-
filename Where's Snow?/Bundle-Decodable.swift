//
//  Bundle-Decodable.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { fatalError() }
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(T.self, from: data)
    }
}
