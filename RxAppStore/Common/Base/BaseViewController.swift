//
//  BaseViewController.swift
//  RxAppStore
//
//  Created by 김규철 on 2023/11/10.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class BaseViewController: UIViewController {
    
    var disposeBag: DisposeBag = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "remove required init")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        bindAction()
        setHierarchy()
        setConstraints()
        setLayout()
        setNavigationBar()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setHierarchy() { }
    func setConstraints() { }
    func setLayout() {
        view.backgroundColor = .white
    }
    func setNavigationBar() { }
    func bind() { }
    func bindAction() { }
}
