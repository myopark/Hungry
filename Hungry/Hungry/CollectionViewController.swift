//
//  CollectionViewController.swift
//  Hungry
//
//  Created by Melody park on 10/29/17.
//  Copyright © 2017 Melody park. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class CollectionViewController: UICollectionViewController {
    @IBOutlet weak var sample: UIImageView!
    
    var imageArray = [String]()
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let headerView = "HeaderView"
        static let showDetailSegue = "ShowDetail"
        
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        let url = URL(string:"http://api.yummly.com/v1/api/recipes?_app_id=0d8e8a84&_app_key=108d39dca04337a59dfb5ccb9241bd78&savory&requirePictures=true")
        let task = URLSession(configuration: URLSessionConfiguration.default ).dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        if let m = json["matches"] as? [NSDictionary]{
                            for image in m {
                                let urlString = image["smallImageUrls"]!
                                self.imageArray.append(String(describing:urlString))
                            }
                            DispatchQueue.main.async {
                                self.collectionView?.reloadData()
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //change
        return self.imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! CollectionViewCell
        //2
        cell.backgroundColor = UIColor.black
        cell.foodImage = self.imageArray[indexPath.row]
        //TODO: put cell for API images
        //TODO: figure out how to different sized cells
      //  return cell
        return cell
    }
    /*
     TODO:
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.headerView, for: indexPath) as! HeaderView
        let category = photoCategories[indexPath.section]
        
        headerView.category = category
        
        return headerView
    }
    
*/
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
