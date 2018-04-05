//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by Justin Hohl on 3/29/18.
//  Copyright © 2018 hohljm. All rights reserved.
//

import UIKit
import CoreData
class MovieQuotesTableViewController: UITableViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let movieQuoteCellIdentifier = "MovieQuoteCell"
    let noMovieQuotesCellIdentifier = "NoMovieQuotesCell"
    let showDetailSegueIdentifier = "ShowDetailSegue"
//    let names = ["Justin","Ryan", "Kelly", "Sidney"]
    var movieQuotes = [MovieQuote]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddDialog))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateMovieQuoteArray()
        tableView.reloadData()
    }
    
    func save() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    @objc func showAddDialog(){
        let alertController = UIAlertController(title: "Create a new movie quote",
                                                message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        
        let createQuote = UIAlertAction(
            title: "Create",
                                        style: .default) { (action) in
                                            let quoteTextField = alertController.textFields![0]
                                            let movieTextField = alertController.textFields![1]
                                            // TODO add context
                                            let newMovieQuote = MovieQuote(context: self.context)
                                            newMovieQuote.quote = quoteTextField.text
                                            newMovieQuote.movie = movieTextField.text
                                            newMovieQuote.created = Date()
                                            self.save()
                                            self.updateMovieQuoteArray()
                                            self.tableView.reloadData()
                              
        }
        
        alertController.addAction(createQuote)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }

    func updateMovieQuoteArray(){
        //make fetch request
        //execute request in try catch
        let request: NSFetchRequest<MovieQuote> = MovieQuote.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
        do{
            movieQuotes = try context.fetch(request)
        } catch{
           fatalError("Unresolved Core Dta error \(error)")
        }
    }
    
//    makes it so edit cnnot be clicked while nothing can be deleted
    override func setEditing(_ editing: Bool, animated: Bool) {
        if movieQuotes.count == 0 {
            super.setEditing(false, animated: animated)
        }else{
            super.setEditing(editing, animated: animated)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return max(movieQuotes.count, 1)
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if movieQuotes.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIdentifier , for: indexPath)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIdentifier, for: indexPath)
            cell.textLabel?.text = movieQuotes[indexPath.row].quote
            cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
        }
       


        return cell
    }
    

//    lets you turn on and off if you can delete
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return movieQuotes.count > 0
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            context.delete(movieQuotes[indexPath.row])
            save()
            updateMovieQuoteArray()
            
//            movieQuotes.remove(at: indexPath.row)
            if movieQuotes.count == 0 {
                tableView.reloadData()
            }else{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow{
                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
