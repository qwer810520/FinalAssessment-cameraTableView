
//
//  ShowDetailViewController.swift
//  FinalAssessment-5
//
//  Created by 楷岷 張 on 2017/5/17.
//  Copyright © 2017年 楷岷 張. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var photoimage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var selectPhoto:UIImage?
    var selectName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backScrollView.delegate = self
        backScrollView.maximumZoomScale = 2.0
        

       

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photoimage.image = selectPhoto
        nameLabel.text = selectName
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoimage
    }


}
