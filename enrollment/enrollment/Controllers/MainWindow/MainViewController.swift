//
//  MainViewController.swift
//  enrollment
//
//  Created by Jay Latman on 7/20/18.
//  Copyright © 2017 IBM. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    /**
     Enumeration for errors generated by the MainViewController
     
     - noViewControllerForSegue: The view controller could not locate a segue
     - invalidAppSupportConfiguration: Could not create a valid reference for resources with AppConfiguration
     */
    enum MainError : Error {
        /// The view controller could not locate a segue
        case noViewControllerForSegue
        /// Could not create a valid reference for resources with AppConfiguration
        case invalidAppSupportConfiguration
    }
    
    /// Image view for displaying art
    @IBOutlet weak var sidePanelImageView: NSImageView!
    
    /// View for views move / transition in and out
    @IBOutlet weak var contentContainerView: NSView!
    
    /// Width constraint of content container view for maintaining aspect so subviews are able to move in and out
    @IBOutlet weak var contentContainerWidthConstraint: NSLayoutConstraint!
    /// Height constraint of content container view for maintaining aspect so subviews are able to move in and out
    @IBOutlet weak var contentContainerHeightContraint: NSLayoutConstraint!
    
    /// Value registering what the view is currently loaded into the content container view
    fileprivate var currentConfigurationViewController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Validate if the jamf binary is present on launch
        if FileManager.default.fileExists(atPath: JPSPaths.binaryPath) == false {
            IssueAlertService.sharedInstance.displayModalFailureToLaunch(header: AlertText.FailureToLaunch.header,
                                                    message: AlertText.FailureToLaunch.message,
                                                    style: .critical,
                                                    cancelButtonLabel: UserInteractionButtons.quit)
        }
    }
    
    override func viewWillAppear() {
       super.viewWillAppear()
       layoutSetup()
    }
    
    private func layoutSetup() {
        self.currentConfigurationViewController?.view.setFrameSize(self.contentContainerView.bounds.size)
    }
}


