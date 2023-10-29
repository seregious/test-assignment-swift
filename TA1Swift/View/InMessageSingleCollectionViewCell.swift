//
//  InMessageSingleCollectionViewCell.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import UIKit

class InMessageSingleCollectionViewCell: UICollectionViewCell {
    
    private let imageDownloader: ImageDownloadable = NetworkManager.shared

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var patient: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func setupCell(for message: SampleMessage) {
        name.text = message.sender?.senderFullName
        patient.text = message.sender?.senderMeta
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        background.layer.cornerRadius = 10
        
        self.time.text = getCurrentTime()
        self.time.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.time.roundCorners(corners: .allCorners, radius: 10)
        
        if let images = message.media {
            if let image = images.first {
                imageDownloader.downloadImage(from: image) { data in
                    DispatchQueue.main.async { [self] in
                        self.image.image = data
                        self.image.roundCorners(corners: .allCorners, radius: 10)
                    }
                    
                }
            }
        }
    }
}
