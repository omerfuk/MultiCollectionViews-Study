//
//  TableViewCell.swift
//  MultiCollectionViews-Study
//
//  Created by Ömer Faruk Kılıçaslan on 27.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    var isBigger = false
    
    func configure(isBig: Bool) {
        isBigger = isBig
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        
        if isBigger == true {
            flowLayout.itemSize = CGSize(width: 300, height: 190)

        }
        else{
            flowLayout.itemSize = CGSize(width: 160, height: 110)

        }
        
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.scrollDirection = .horizontal
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        
    }
}


extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isBigger == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "big", for: indexPath) as! CollectionViewCell
            cell.image.load(urlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png")
            cell.lblTitle.text = "Title : \(indexPath.row + 1)"
            cell.lblDesc.text = "Desc : \(indexPath.row + 1)"
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "small", for: indexPath) as! CollectionViewCell
            cell.image.load(urlString: "https://media.gettyimages.com/photos/tokyo-japan-high-speed-train-tunnel-motion-blur-abstract-picture-id1195455865?s=612x612")
            cell.lblTitle.text = "Title : \(indexPath.row + 1)"
            cell.lblDesc.text = "Desc : \(indexPath.row + 1)"
            return cell
        }
        
    }
}
var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func load(urlString: String) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
