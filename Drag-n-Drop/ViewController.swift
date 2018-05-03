//
//  ViewController.swift
//  Drag-n-Drop
//
//  Created by Vitalii Obertynskyi on 5/2/18.
//  Copyright © 2018 Vitalii Obertynskyi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dropDelegate = self
        tableView.dragDelegate = self        
    }
    
    private func refreshData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ident = "cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ident) as! CellTableViewCell
        
        let item = models[indexPath.row]
        
        cell.title.text = item.title
        cell.imgView.image = item.image
        cell.title.numberOfLines = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return String().appendingFormat("%d object%@", models.count, models.count == 1 ? "" : "s")
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            models.remove(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        for item in coordinator.items {
            
            let model = Model()
            
            if item.dragItem.itemProvider.canLoadObject(ofClass: UIImage.self) {
             
                item.dragItem.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    
                    if error != nil {
                        print("Error: \(error?.localizedDescription ?? "-some-")")
                    }
                    
                    if let o = image {
                        model.load(with: o)
                        self.refreshData()
                    }
                }
            }
            
            if item.dragItem.itemProvider.canLoadObject(ofClass: NSString.self) {
                
                item.dragItem.itemProvider.loadObject(ofClass: NSString.self, completionHandler: { (object, error) in
                    
                    if error != nil {
                        print("Error: \(error?.localizedDescription ?? "-some-")")
                    }
                    
                    if let o = object {
                        model.load(with: o)
                        self.refreshData()
                    }
                })
            }
            
            if let index = coordinator.destinationIndexPath {
                self.models.insert(model, at: index.row)
            } else {
                self.models.append(model)
            }
        }
    }
}

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let item = models[indexPath.row]
        
        var result = [UIDragItem]()
        
        if let i = item.image {
            let provider = NSItemProvider(object: i)
            let dragItem = UIDragItem(itemProvider: provider)
            result.append(dragItem)
        }
        
        let provider = NSItemProvider(object: item.title as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: provider)
        result.append(dragItem)
        
        return result
    }
}




