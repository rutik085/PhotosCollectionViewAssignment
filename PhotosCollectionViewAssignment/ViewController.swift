//
//  ViewController.swift
//  PhotosCollectionViewAssignment
//
//  Created by Mac on 04/01/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var post : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeTableView()
        registerXibWithTableView()
        fetchDataFromApi()
        
    }
    func initilizeTableView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerXibWithTableView(){
        let uiNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(uiNib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    
    
    func fetchDataFromApi()
    {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/photos")
        var postUrlRequest = URLRequest(url: postUrl!)
        postUrlRequest.httpMethod = "Get"
        let postUrlSesson = URLSession(configuration: .default)
        
        let dataTask = postUrlSesson.dataTask(with: postUrlRequest) { postData, postUrlResponse, postError in
            let postUrlResponse = try! JSONSerialization.jsonObject(with: postData!) as! [[String : Any]]
            
            for eachResponse in postUrlResponse   {
                let postDictonary = eachResponse as! [String : Any]
                let albumId = postDictonary["albumId"] as! Int
                let id = postDictonary["id"] as! Int
                let title = postDictonary["title"] as! String
                let url = postDictonary["url"] as! String
                let thumbnailUrl = postDictonary["thumbnailUrl"] as! String
                
                let postObject = Post(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
                self.post.append(postObject)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        dataTask.resume()
    }

}

extension ViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        customCollectionViewCell.albumIdLabel.text = String(post[indexPath.item].albumId)
        customCollectionViewCell.idLabel.text = String(post[indexPath.item].id)
        customCollectionViewCell.titleLabel.text = (post[indexPath.item].title)
        customCollectionViewCell.postUrlImageView.kf.setImage(with: URL(string: post[indexPath.item].url))
        customCollectionViewCell.postthumbnailUrlImageView.kf.setImage(with: URL(string: post[indexPath.item].thumbnailUrl))
        return customCollectionViewCell
    }
    
    
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenTheCell : CGFloat = (flowLayout.minimumInteritemSpacing) ?? 0.0 +
        (flowLayout.sectionInset.left ?? 0.0) + (flowLayout.sectionInset.right ?? 0.0)
        let size = (self.collectionView.frame.width - spaceBetweenTheCell) / 2
                    return CGSize(width: size, height: size)
    }
    
    
}
