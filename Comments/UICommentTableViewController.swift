//
//  ViewController.swift
//  Comments
//
//  Created by Julien Limoges on 2015-08-14.
//  Copyright (c) 2015 limoges.co. All rights reserved.
//

import UIKit

class Post {
    
    enum Type {
        case Post
        case Reply
        case Comment
    }
    
    var type: Type {
        get {
            return .Post
        }
    }
}

class Reply: Post {
    
    override var type: Type {
        get {
            return .Reply
        }
    }
}

class Comment: Post {
    
    override var type: Type {
        get {
            return .Comment
        }
    }
    var level = 0
    
    override init() {
        
    }
    
    init(level: Int) {
        self.level = level
    }
}

protocol UICommentReply {

    func replyToCommentAtIndexPath(cell: UICommentTableViewCell)
}

class UICommentTableViewController: UITableViewController, UICommentReply {

    
    var tableContent: [Post] = [
        Comment(), Comment(level: 1), Comment(level: 1), Comment(), Comment()
    ]
    
    // The cellIdentifier corresponding to the nib
    let cellIdentifier = "UICommentTableViewCell"
    let replyIdentifier = "UICommentReplyTableViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupRefreshControl()
        
        self.tableView.registerNib(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.registerNib(UINib(nibName: replyIdentifier, bundle: nil), forCellReuseIdentifier: replyIdentifier)
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 174
        self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
    }
    
    func setupRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        //var attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl.attributedTitle = attributedTitle
        refreshControl.tintColor = UIColor(white: 0.80, alpha: 1)
        refreshControl.addTarget(self, action: Selector("handleRefresh:"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func handleRefresh(sender: UIRefreshControl) {
        
        sender.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableContent.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let post = self.tableContent[row]
        switch post.type {
        case .Comment:
            let comment = post as! Comment
            let commentCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICommentTableViewCell
            commentCell.delegate = self
            commentCell.level = comment.level
            return commentCell
        case .Reply:
            let replyCell = tableView.dequeueReusableCellWithIdentifier(replyIdentifier, forIndexPath: indexPath) as! UICommentReplyTableViewCell
            return replyCell
        default:
            return UITableViewCell()
        }
    }
    
    func replyToCommentAtIndexPath(cell: UICommentTableViewCell) {
        
        println(__FUNCTION__)
        if let path = tableView.indexPathForCell(cell) {
            
            let indexPath = NSIndexPath(forRow: path.row + 1, inSection: path.section)
            if self.tableContent[indexPath.row].type == .Reply {
                self.tableContent.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            } else {
                self.tableContent.insert(Reply(), atIndex: indexPath.row)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
        }
        
    }

}

