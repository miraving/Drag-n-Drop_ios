//
//  Model.swift
//  Drag-n-Drop
//
//  Created by Vitalii Obertynskyi on 5/2/18.
//  Copyright © 2018 Vitalii Obertynskyi. All rights reserved.
//

import UIKit

class Model {
    var title: String
    var image: UIImage?
    
    init() {
        title = ""
        image = nil
    }
    
    func load(with object: NSItemProviderReading) {
        
        switch object.self {
        case is String:
            title = object as! String
        case is UIImage:
            image = object as? UIImage
        default:
            title = "Error..."
            print("Error: -some-")
        }
    }
}
