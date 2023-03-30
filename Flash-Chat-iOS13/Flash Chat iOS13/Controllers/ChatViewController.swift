//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageTableViewCell" , bundle: nil), forCellReuseIdentifier: Constants.cellId)
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                self.messages = []
                
                if let data = querySnapshot?.documents {
                    for doc in data {
                      if let sender = doc[Constants.FStore.senderField] as? String,
                         let message = doc[Constants.FStore.bodyField] as? String {
                          let newMessage = Message(sender: sender, body: message)
                          self.messages.append(newMessage)
                          
                          DispatchQueue.main.async {
                              self.tableView.reloadData()
                              let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                              self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                          }
                      }
                    }
                } else {
                    print("QuerySnapShotData is empty")
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField:messageSender,
                Constants.FStore.bodyField:messageBody,
                Constants.FStore.dateField:Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("FireStore save Error, \(e)")
                } else {
                    print("FireStore save Success")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! MessageTableViewCell
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImg.isHidden = true
            cell.meImg.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.purple)
        }
        else {
            cell.youImg.isHidden = false
            cell.meImg.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        
        
        return cell
    }
    
}
