//
//  UICommentTableViewCell.swift
//  Comments
//
//  Created by Julien Limoges on 2015-08-14.
//  Copyright (c) 2015 limoges.co. All rights reserved.
//

import UIKit

@IBDesignable class UICommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postView: UIView?
    @IBOutlet weak var userPictureView: UIImageView!
    @IBOutlet weak var userInformationView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postContentView: UIView!
    @IBOutlet weak var postMessageView: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var controlReplyButton: UIButton!
    
    var level: Int = 0 {
        didSet {
            switch level {
            case 1:
                self.postView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
            case 2:
                self.postView?.backgroundColor = UIColor(white: 0.90, alpha: 1)
            case 3:
                self.postView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
            default:
                self.postView?.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    var delegate: UICommentReply?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.setup()
    }
    
    func setup() {
        
        self.controlReplyButton.addTarget(self, action: Selector("handleReplyButton:event:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func handleReplyButton(sender: UIButton, event: UIEvent) {
        
        self.delegate?.replyToCommentAtIndexPath(self)
    }
}