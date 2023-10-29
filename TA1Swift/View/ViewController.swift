//
//  ViewController.swift
//  TA1Swift
//
//  Created by Ivan Manov on 29.03.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var messagesList = [SampleMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sampleDataSource = SampleDataSource()
        sampleDataSource.loadMessages { (messages) in
            self.messagesList = messages
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.registerTableViewCells()
        self.collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        messagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let images = messagesList[indexPath.row].media
        var height: CGFloat = 170
        if images?.count == 1 {
            height = 250
        }
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messagesList[indexPath.row]
        let id = message.sender?.senderId
        let count = message.media?.count
        
        switch (id, count) {
        case ("01", 1) :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "incomeSingleCell", for: indexPath) as! InMessageSingleCollectionViewCell
            cell.setupCell(for: message)
            return cell
        case ("01", _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "incomeCell", for: indexPath) as! InMessageCollectionViewCell
            cell.setupCell(for: message)
            return cell
        case("00", 1):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outcomeSingleCell", for: indexPath) as! OutMessageSingleCollectionViewCell
            cell.setupCell(for: message)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outcomeCell", for: indexPath) as! OutMessageCollectionViewCell
            cell.setupCell(for: message)
            return cell
        }
        
    }
        
    private func registerTableViewCells() {
        let incomeCell = UINib(nibName: "InMessageCollectionViewCell", bundle: Bundle.main)
        let incomeSingleCell = UINib(nibName: "InMessageSingleCollectionViewCell", bundle: Bundle.main)
        let outcomeCell = UINib(nibName: "OutMessageCollectionViewCell", bundle: Bundle.main)
        let outcomeSingleCell = UINib(nibName: "OutMessageSingleCollectionViewCell", bundle: Bundle.main)
                
        collectionView.register(incomeCell, forCellWithReuseIdentifier: "incomeCell")
        collectionView.register(outcomeCell, forCellWithReuseIdentifier: "outcomeCell")
        collectionView.register(incomeSingleCell, forCellWithReuseIdentifier: "incomeSingleCell")
        collectionView.register(outcomeSingleCell, forCellWithReuseIdentifier: "outcomeSingleCell")
    }
    

}

