//
//  CollectionTableViewCell.swift
//  VSMS
//
//  Created by Vuthy Tep on 5/17/19.
//  Copyright © 2019 121. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Toast_Swift
import Photos

var ImageCount = 0

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var postImagecollectionview: UICollectionView!
    
    var dataArr: [imageWithPLAsset] = []
    var imageArr: [UIImage] = []
    var selectedAssets = [TLPHAsset]()
    var setValueDelegate: getValueFromXibPhoto?
    var CellClick: ((Int) -> Void)?
    var kkk = PHAsset()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        postImagecollectionview?.collectionViewLayout = layout
        
        postImagecollectionview.delegate = self
        postImagecollectionview.dataSource = self
        
        postImagecollectionview?.clipsToBounds = true
        postImagecollectionview?.showsHorizontalScrollIndicator = false
    
        
        if dataArr.count == 0
        {
            for _ in 0...3 {
                self.dataArr.append(imageWithPLAsset(image: UIImage(named: "icons8-plus-math-50 (5)")!, PLAsset: nil, selectedImage: nil))
            }
        }
        
        let cellphoto = UINib(nibName: "PhotoListCollectionViewCell", bundle: nil)
        postImagecollectionview?.register(cellphoto, forCellWithReuseIdentifier: "photoCell")
        
        //Calling Function
    }
    
    func loadEditImage(FImage: UIImage?, LImage: UIImage?, RImage: UIImage?, BImage: UIImage?)
    {
        dataArr[0].selectedImage = FImage
        dataArr[1].selectedImage = LImage
        dataArr[2].selectedImage = RImage
        dataArr[3].selectedImage = BImage
        postImagecollectionview.reloadData()
    }
    
    func refreshDataArr()
    {
        for i in 0...3
        {
            self.dataArr[i].PLAsset = nil
        }
    }
    
    func getInstructionMessage(select: Int) -> String
    {
        switch (selectedAssets.count + select) {
        case 0: return "Front Image"
        case 1: return "Left Image"
        case 2: return "Right Image"
        case 3: return "Back Image"
        default: return ""
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoListCollectionViewCell
        
        let data = dataArr[indexPath.row]
        cell.data = data
        cell.imageIndex = indexPath.row
      
        
        cell.removeImage = { index in
            ImageCount = ImageCount - 1
            self.dataArr.remove(at: index)
            self.refreshDataArr()
            self.refreshSelectAsset()
            ImageCount = self.selectedAssets.count
            self.postImagecollectionview.reloadData()
        }
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if dataArr[indexPath.row].PLAsset != nil || dataArr[indexPath.row].selectedImage != nil{
            return
        }
        
        let TLPhotoPicker = TLPhotosPickerViewController()
        var TLconfig = TLPhotosPickerConfigure()
        
        TLconfig.maxSelectedAssets = (4 - ImageCount)
        TLconfig.allowedVideo = false
        TLconfig.allowedVideoRecording = false
        TLconfig.nibSet = (nibName: "CustomCell_Instagram", bundle: Bundle.main)
        
        TLPhotoPicker.delegate = self
        TLPhotoPicker.logDelegate = self
        TLPhotoPicker.configure = TLconfig
        
        let topVC = UIApplication.topViewController()
        topVC!.present(TLPhotoPicker, animated: true, completion: nil)
    }
    
    func refreshSelectAsset(){
        for i in 0..<self.selectedAssets.count {
            self.dataArr[i] = imageWithPLAsset(image: UIImage(named: "icons8-plus-math-50 (5)")!, PLAsset: self.selectedAssets[i], selectedImage: dataArr[i].selectedImage)
        }
    }

}

extension CollectionTableViewCell: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        self.selectedAssets += withTLPHAssets
        ImageCount = self.selectedAssets.count
    }
    
    func photoPickerDidCancel() {
        // cancel
    }
    func dismissComplete() {
        refreshDataArr()
        refreshSelectAsset()
        self.postImagecollectionview.reloadData()
        self.setValueDelegate?.getPhoto(Photos: dataArr)
    }
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        Message.AlertMessage(message: "Image can select only 4.", header: "Warning", View: picker) {
            
        }
    }
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        Message.AlertMessage(message: "Gallery is not avialable.", header: "Warning", View: picker) {
            
        }
    }
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        Message.AlertMessage(message: "Camera is not avialable.", header: "Warning", View: picker) {
            
        }
    }
}

extension CollectionTableViewCell: TLPhotosPickerLogDelegate {
    func selectedCameraCell(picker: TLPhotosPickerViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let currentView = UIApplication.topViewController() {
                currentView.view.makeToast(self.getInstructionMessage(select: picker.selectedAssets.count), duration: 2.0, point: CGPoint(x: currentView.view.frame.width/2, y: 75.0), title: nil, image: nil) { didTap in
                    if didTap {
                        print("completion from tap")
                    } else {
                        print("completion without tap")
                    }
                }
            }
        }
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        
    }
    
    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        
    }
    
    func selectedAlbum(picker: TLPhotosPickerViewController, title: String, at: Int) {
        
    }
}
