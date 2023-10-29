//
//  OutMessageSingleCollectionViewCell.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import UIKit

class OutMessageSingleCollectionViewCell: UICollectionViewCell {
    
    private let imageDownloader: ImageDownloadable = NetworkManager.shared

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setupCell(for message: SampleMessage) {
        if let images = message.media {
            setSingleImage(for: images)
        }
        self.time.text = getCurrentTime()
        self.time.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.time.roundCorners(corners: .allCorners, radius: 10)
    }
    
    private func setSingleImage(for images: [NSURL]) {
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
