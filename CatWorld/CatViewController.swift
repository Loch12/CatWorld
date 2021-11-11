//
//  CatViewController.swift
//  catWorld
//
//  Created by Matheus on 09/11/21.
//

import UIKit


//função que faz o download da imagem pra ser exibida (Request API)





class CatViewController: UIViewController {

    @IBOutlet weak var dadosStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var cat:CatStats?
    
    //Carregamento das informações na tela secundaria
    override func viewDidLoad() {
        super.viewDidLoad()

        //Carrega os dados do gato selecionado nos labels
        nameLabel.text = cat?.name
        tempLabel.text = "Temperamento: "+(cat?.temperament)!
        descriptionLabel.text = cat?.description
        
        //Carrega a imagem do gato no ImageView
        if let urlImage = (cat?.image?.url){
            if let url = URL(string: urlImage){
                imageView.downloaded(from: url)
            }
        }
        
        
        //Mudanças visuais
                
        //setando background
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "backgroundAsset")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        
        //modificando labels
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 20
        
        tempLabel.layer.masksToBounds = true
        tempLabel.layer.cornerRadius = 20
        
        dadosStackView.layer.masksToBounds = true
        dadosStackView.layer.cornerRadius = 20
        
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.layer.cornerRadius = 20
        
    }
}

//extension que carrega a imagem atraves do JSON
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
