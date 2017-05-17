//
//  MainTableViewController.swift
//  FinalAssessment-5
//
//  Created by 楷岷 張 on 2017/5/17.
//  Copyright © 2017年 楷岷 張. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var photoArray:[PhotoMo] = []
    var fetchResultController:NSFetchedResultsController<PhotoMo>!
    

    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        let addPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController")
        navigationController?.pushViewController(addPhotoViewController!, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: nil, action:nil)
        
    }
    
    func loadCoreData() {
        let fetchRequest:NSFetchRequest<PhotoMo> = PhotoMo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let content = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: content, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
               try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    photoArray = fetchedObjects
                }
            } catch {
                
            }
            
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObject = controller.fetchedObjects {
            photoArray = fetchedObject as! [PhotoMo]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photoArray.count != 0 {
            return photoArray.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        if photoArray.count != 0 {
            cell.photoImage.image = UIImage(data: photoArray[indexPath.row].photo! as Data)
            cell.nameLabel.text = photoArray[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            let defaultAction = "title: \(String(describing: self.photoArray[indexPath.row].name))"
            if let imageToShare = self.photoArray[indexPath.row].photo {
                let photo = UIImage(data: imageToShare as Data)
                let activityController = UIActivityViewController(activityItems: [defaultAction, photo!], applicationActivities: nil)
                
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let content = appDelegate.persistentContainer.viewContext
                let photoToDelete = self.fetchResultController.object(at: indexPath)
                content.delete(photoToDelete)
                
                appDelegate.saveContext()
            }
        }
        shareAction.backgroundColor = UIColor.blue
        
        return [shareAction, deleteAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailViewController") as! ShowDetailViewController
        showDetailViewController.selectName = photoArray[indexPath.row].name
        showDetailViewController.selectPhoto = UIImage(data: photoArray[indexPath.row].photo as! Data)
        
        navigationController?.pushViewController(showDetailViewController, animated: true)
    }
    
}
