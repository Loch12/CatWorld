//
//  CatTableViewCell.swift
//  catWorld
//
//  Created by Matheus on 09/11/21.
//

import UIKit

//Classe da Celula reutilizavel
class CatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
