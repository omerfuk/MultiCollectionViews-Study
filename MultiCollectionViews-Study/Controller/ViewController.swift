//
//  ViewController.swift
//  MultiCollectionViews-Study
//
//  Created by Ömer Faruk Kılıçaslan on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header")
        cell?.textLabel?.text = "Header : \(section + 1)"
        cell?.textLabel?.font = UIFont(name: "Verdana", size: 20)
        cell?.contentView.backgroundColor = .white
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if indexPath.section % 2 == 0 {
            cell.configure(isBig: true)
        }else{
            cell.configure(isBig: false)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section % 2 == 0 {
           return 200
            
        }else{
            return 130
            
        }
    }
    

}
