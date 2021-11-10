//
//  Image.swift
//  catWorld
//
//  Created by Matheus on 09/11/21.
//

import Foundation


//Classe das imagens dos gatos (JSON)
struct Image: Codable{
    var height: Int?
    var id: String?
    var url: String?
    var width: Int?
}
