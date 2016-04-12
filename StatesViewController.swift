//
//  StatesViewController.swift
//  StatesViewController
//
//  Created by Grégoire Lhotellier on 12/04/2016.
//  Copyright © 2016 Grégoire Lhotellier. All rights reserved.
//

import UIKit

class StatesViewController<T>: UIViewController, StatefulViewController {

    var data: Cardinality<T>? {
        didSet {
            endLoading()
        }
    }

    init(dataOrigin: DataOrigin<T>) {
        super.init(nibName: nil, bundle: nil)
        switch dataOrigin {
        case .Direct(let data): self.data = data
        case .Distant(let callback):
            startLoading()
            callback() {
                res in
                switch res {
                case .Success(let data): self.data = data
                case .Error(let error): self.endLoading(true, error: error, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()
    }
    
    func hasContent() -> Bool {
        return data != nil
    }
    
}

enum Cardinality<T> {
    case One(T)
    case Many(Book<T>)
}

enum DataOrigin<T> {
    case Direct(Cardinality<T>)
    case Distant((DistantDataResult<T> -> Void) -> Void)
}

enum DistantDataResult<T> {
    case Success(Cardinality<T>)
    case Error(ErrorType)
}

extension StatefulViewController {
    
    func initViews() {
        loadingView = {
            let view = UIView()
            view.backgroundColor = .whiteColor()
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            activity.startAnimating()
            activity.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(activity)
            NSLayoutConstraint(item: activity, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
            NSLayoutConstraint(item: activity, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0).active = true
            return view
        }()
        emptyView = {
            let label = UILabel()
            label.text = "Empty"
            return label
        }()
        errorView = {
            let label = UILabel()
            label.text = "Error"
            return label
        }()
    }
    
}
