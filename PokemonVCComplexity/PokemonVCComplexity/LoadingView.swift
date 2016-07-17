//
//  LoadingView.swift
//  PokemonVCComplexity
//
//  Created by Jeffrey Bergier on 7/17/16.
//  Copyright © 2016 Jeffrey Bergier. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spinner!.stopAnimating()
        self.alpha = 0
    }
    
    var loading: Bool = false {
        didSet {
            switch self.loading {
            case true:
                self.spinner!.startAnimating()
                UIView.animateWithDuration(0.3, animations: {
                    self.alpha = 1
                })
            case false:
                UIView.animateWithDuration(
                    0.3, animations: {
                        self.alpha = 0
                    }, completion: { success in
                        self.spinner!.stopAnimating()
                    }
                )
            }
        }
    }
}
