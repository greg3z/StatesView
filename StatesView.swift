//
//  StatesView.swift
//  StatesView
//
//  Created by Grégoire Lhotellier on 12/04/2016.
//  Copyright © 2016 Grégoire Lhotellier. All rights reserved.
//

import UIKit

class StatesView: UIViewController, StatefulViewController {
    
    var viewController: UIViewController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        startLoading()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()
    }
    
    func hasContent() -> Bool {
        return viewController != nil
    }
    
    func setChildViewController(viewController: UIViewController) {
        self.viewController = viewController
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        addChildViewController(viewController)
        endLoading()
    }
    
    func setEmpty() {
        endLoading()
    }
    
    func setError(error: ErrorType) {
        endLoading(error: error)
    }
    
    func handleErrorWhenContentAvailable(error: ErrorType) {
        let alertController = UIAlertController(title: "Ooops", message: "Something went wrong. \(error)", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
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
