//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by Justin Hohl on 4/3/18.
//  Copyright © 2018 hohljm. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {

    @IBOutlet weak var MovieLabel: UILabel!
    @IBOutlet weak var QuoteLabel: UILabel!
    
    var movieQuote: MovieQuote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEditDialogue))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func showEditDialogue(){
        let alertController = UIAlertController(title: "Create a new movie quote",
                                                message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
            textField.text = self.movieQuote?.movie
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        
        let createQuote = UIAlertAction(title: "Edit",
                                        style: .default) { (action) in
                                            let quoteTextField = alertController.textFields![0]
                                            let movieTextField = alertController.textFields![1]
                                            self.movieQuote?.quote = quoteTextField.text!
                                            self.movieQuote?.movie = movieTextField.text!
                                            self.updateView()
                                            
                                            // save context
                                            (UIApplication.shared.delegate as! AppDelegate).saveContext()
                                           
        }
        
        alertController.addAction(createQuote)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }

    func updateView() {
        QuoteLabel.text = movieQuote?.quote
        MovieLabel.text = movieQuote?.movie
    }

}
