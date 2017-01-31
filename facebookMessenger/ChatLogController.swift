//
//  ChatLogController.swift
//  facebookMessenger
//
//  Created by Edward on 1/30/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: {
                $0.date!.compare($1.date! as Date) == .orderedAscending
            })
        }
    }
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        
        cell.messageTextView.text = messages?[indexPath.item].text
        
        if let message = messages?[indexPath.item], let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            
            cell.profileImageView.image = UIImage(named: profileImageName)
            
            let size = CGSize(width: 200, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
            
            if !message.isSender {
                cell.messageTextView.frame = CGRect(x: 48, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48 - 26, y: 0, width: estimatedFrame.width + 16 + 28, height: estimatedFrame.height + 20)
                cell.profileImageView.isHidden = false
                cell.bubbleImageView.tintColor = UIColor(white: 0.90, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage
            } else {
    
                // User sent the message
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 28, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 28 - 8, y: 0, width: estimatedFrame.width + 16 + 28, height: estimatedFrame.height + 20)
                cell.profileImageView.isHidden = true
                cell.bubbleImageView.tintColor = UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.white
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 200, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample Messsage"
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 12, left: 30, bottom: 24, right: 12)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 12, left: 12, bottom: 24, right: 30)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.blueBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(30)]-18-|", views: profileImageView)
        
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintsWithFormat("H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintsWithFormat("V:|[v0]|", views: bubbleImageView)
    }
}
























