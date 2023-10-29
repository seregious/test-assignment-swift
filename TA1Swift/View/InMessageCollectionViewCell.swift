//
//  InMessageCollectionViewCell.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import UIKit

class InMessageCollectionViewCell: UICollectionViewCell {

    private let imageDownloader: ImageDownloadable = NetworkManager.shared

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var countImages: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var patient: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    func setupCell(for message: SampleMessage) {
        name.text = message.sender?.senderFullName
        patient.text = message.sender?.senderMeta
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        background.layer.cornerRadius = 10
        
        
        if let images = message.media {
            
            setMoreImages(for: images)
            
            if images.count <= 2 {
                self.countImages.isHidden = true
            } else {
                self.countImages.text = "+\(images.count - 1)"
                self.countImages.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                self.countImages.roundCorners(corners: [.bottomRight, .topRight], radius: 10)
            }
        }
        self.time.text = getCurrentTime()
        self.time.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.time.roundCorners(corners: .allCorners, radius: 10)
    }
    
    private func setMoreImages(for images: [NSURL]) {
        
        if let image = images.first {
            imageDownloader.downloadImage(from: image) { data in
                DispatchQueue.main.async { [self] in
                    self.secondImage.image = data
                    self.secondImage.roundCorners(corners: [.bottomRight, .topRight], radius: 10)
                }
                
            }
        }
        
        let image = images[1]
            imageDownloader.downloadImage(from: image) { data in
                DispatchQueue.main.async { [self] in
                    self.firstImage.image = data
                    self.firstImage.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
                }
                
            }
    }
    
}
