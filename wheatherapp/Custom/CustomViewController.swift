//
//  CustomViewController.swift
//  wheatherapp
//
//  Created by Leonardo Leffa on 08/05/20.
//  Copyright © 2020 Leonardo Leffa. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON
import MBProgressHUD

class CustomViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showLoading(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func stopLoading(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}

extension Float {
    func celsius() -> Float {
        return (self - 273.15);
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension String {
    func errorAlert(_ controller: UIViewController) {
        let alert = UIAlertController(title: "Ops!", message: self, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

