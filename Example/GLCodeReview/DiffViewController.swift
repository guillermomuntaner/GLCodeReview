//
//  DiffViewController.swift
//  GLCodeReview_Example
//
//  Created by Guillermo Muntaner Perelló on 30/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import GLCodeReview

class DiffViewController: UIViewController {

    public var mergeRequestChange: Change!
    public var gitDiffs: [GitDiff] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let diffParser = ExperimentalDiff(unifiedDiff: mergeRequestChange.diff)
        text.attributedText = diffParser.parse()
    }
}
