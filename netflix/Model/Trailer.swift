//
//  Trailer.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import Foundation

struct Trailer: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var videoURL: URL
    var ThumbnailImageURL: URL
}
