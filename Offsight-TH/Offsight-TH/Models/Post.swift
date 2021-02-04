//
//  Post.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

struct Post: Codable {
    
    var text: String? // string(length: 6-1000)
    var image: String? // string(url)
    var likes: Int? // number(init value: 0)
    var link: String? //string(url, length: 6-200)
    var tags: [String] // array(string)
    var publishDate: String? // string(autogenerated)
//    var owner: User// model(ref:User)
}