//
//  ViewController.swift
//  catWorld
//
//  Created by Matheus on 09/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var cats = [CatStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Carregamento dos dados na tabela
        downloadJSON {
            self.tableView.reloadData()
        }
                
        tableView.delegate = self
        tableView.dataSource = self
                
        //Detalhes visuais
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    //Definição de itens na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    //Reutilizando celula modelo
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell") as! CatTableViewCell
        cell.catName.text = cats[indexPath.row].name
        
        //Detalhe visual
        cell.catView.layer.cornerRadius = cell.catView.frame.height/2
        
        return cell
    }
    
    //Definindo ações para cada celula (Segue)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    //Define o destino e envia o objeto selecionado para a proxima pagina
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CatViewController{
            destination.cat = cats[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    //Função de Request da API
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")
        
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.addValue("842c54ee-add1-4eab-9747-f2fd69603dde", forHTTPHeaderField: "x-api-key")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    if let data = data {
                        do{
                            self.cats = try JSONDecoder().decode([CatStats].self, from: data) as [CatStats]
                            
                            DispatchQueue.main.async{
                                completed()
                            }
                           
                        }catch {
                            print(String(describing: error))
                        }
                    }
                }else{
                    print("ERROR JSON")
                }
            }
            dataTask.resume()
        }
    }

}

