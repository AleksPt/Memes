//
//  Mem.swift
//  Memes
//
//  Created by Алексей on 17.03.2024.
//

import Foundation

struct Mem: Decodable {
    let data: DataInfo
}

struct DataInfo: Decodable {
    let memes: [Meme]
}

struct Meme: Decodable {
    let url: URL
}
