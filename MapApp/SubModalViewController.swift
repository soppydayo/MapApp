//
//  SubModalViewController.swift
//  MapApp
//
//  Created by 白川創大 on 2023/06/04.
//

import UIKit

class SubModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セミモーダルのビューの構築
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        containerView.backgroundColor = .white
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 260, height: 30))
        titleLabel.text = "Sub Modal"
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        
        let closeButton = UIButton(frame: CGRect(x: 20, y: 70, width: 260, height: 40))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.backgroundColor = .blue
        containerView.addSubview(closeButton)
        
        // セミモーダルのビューを表示する
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(containerView)
        containerView.center = view.center
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
