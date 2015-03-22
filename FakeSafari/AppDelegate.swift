//
//  AppDelegate.swift
//  FakeSafari
//
//  Created by ugur on 19/03/15.
//  Copyright (c) 2015 Ugur Yavas. All rights reserved.
//

import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate{

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var textField: NSTextField!
    
    var homePage = "http://www.google.com"
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        textField.placeholderString = "http://www.google.com"
        var req:NSURLRequest = NSURLRequest(URL: NSURL(string: homePage)!)
        webView.mainFrame.loadRequest(req)
    }
    
    // Set it to true if...you know what.
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return false
    }

    // MARK: - IBActions
    
    @IBAction func goToHomePage(sender: AnyObject){
        var req:NSURLRequest = NSURLRequest(URL: NSURL(string: homePage)!)
        webView.mainFrame.loadRequest(req)
    }
    
    @IBAction func goOldSchool(sender: AnyObject){
        httpPrefixHandler()
        var req:NSURLRequest = NSURLRequest(URL: NSURL(string: textField.stringValue)!)
        webView.mainFrame.loadRequest(req)
    }
    
    @IBAction func goModern(sender: AnyObject){
        goOldSchool(sender)
    }
    
    // MARK: - WebFrameLoadDelegate functionality
    
    // Set current URL into the text field
    override func webView(sender: WebView!, didStartProvisionalLoadForFrame frame: WebFrame!) {
        if frame == sender.mainFrame {
            textField.stringValue = frame.provisionalDataSource.request.URL!.absoluteString!
        }
    }
    
    // Set page title wrt the current page
    override func webView(sender: WebView!, didReceiveTitle title: String!, forFrame frame: WebFrame!) {
        if frame == sender.mainFrame {
            sender.window?.title = title
        }
    }
    
    // MARK: - Helper functions
    
    // Handle http prefix issue
    func httpPrefixHandler(){
        if textField.stringValue.isEmpty{
            textField.stringValue = homePage
        }
        
        if textField.stringValue.lowercaseString.hasPrefix("http://"){
            // do nothing...
        }
        else{
            textField.stringValue = "http://\(textField.stringValue)"
        }
    }
}