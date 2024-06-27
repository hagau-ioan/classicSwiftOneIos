//
//  ViewController.swift
//  Project31
//
//  Created by TwoStraws on 23/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, UIGestureRecognizerDelegate {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dict = message.body as? [String : AnyObject] else {
            return
        }
        // This message is sent directly from the webview page content,
        // check contentController.add(self, name: "toggleMessageHandler")
        print("userContentController: \(dict)")
        
    }
    
   
    // using stack view a s POC to see how can we add multiple views (webviews) on same screen
    // IStackView is useful when you need to repeat same views multiple times like in Sing up view. We use many textfields and manually set constraints between each textfields. But if you put all textfields in stack view then you just need to set required constraints of stackview only and not textfields. Textfields inside stackview will be arranged automatically without Autolayout.
    // Sometimes we need to hide view and we want to remove its occupied space so at that time use of stackview is recommended because if you hide any view that resided in stackview will also remove its occupied space automatically.
    // TODO: not used, keeped for reference
    var stackView: UIStackView!
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //stackView = UIStackView()
        
//        view.addSubview(stackView)
        view.addSubview(webView)
        
        setDefaultTitle()
        view.backgroundColor = .white

        addWebView()
    }

    func setDefaultTitle() {
        title = "WebView Browser"
    }

    @objc func addWebView() {
    
        webView.navigationDelegate = self
        
        
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "toggleMessageHandler")
        registerWebviewControllerHandler(contentController: contentController)
        

        //stackView.addArrangedSubview(webView)

        let url = URL(string: "https://www.hagau.ro")!
        webView.load(URLRequest(url: url))

        webView.layer.borderColor = UIColor.blue.cgColor
        selectWebView(webView)

        // handle and catch the gestures inside the webview.
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
    
        NSLayoutConstraint.activate([
            //webView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            //webView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

    /*
     * TODO: Not used at the moment.
     */
//    @objc func deleteWebView() {
//        // safely unwrap our webview
//        if let webView = activeWebView {
//            if let index = stackView.arrangedSubviews.firstIndex(of: webView) {
//                // we found the current webview in the stack view! Remove it from the stack view
//                stackView.removeArrangedSubview(webView)
//
//                // now remove it from the view hierarchy – this is important!
//                webView.removeFromSuperview()
//
//                if stackView.arrangedSubviews.count == 0 {
//                    // go back to our default UI
//                    setDefaultTitle()
//                } else {
//                    // convert the Index value into an integer
//                    var currentIndex = Int(index)
//
//                    // if that was the last web view in the stack, go back one
//                    if currentIndex == stackView.arrangedSubviews.count {
//                        currentIndex = stackView.arrangedSubviews.count - 1
//                    }
//
//                    // find the web view at the new index and select it
//                    if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? WKWebView {
//                        selectWebView(newSelectedWebView)
//                    }
//                }
//            }
//        }
//    }

    func selectWebView(_ webView: WKWebView) {
//        for view in stackView.arrangedSubviews {
//            view.layer.borderWidth = 0
//        }

//        activeWebView = webView
        webView.layer.borderWidth = 1

        updateUI(for: webView)
    }

    @objc func webViewTapped(_ recognizer: UITapGestureRecognizer) {
        print("Handle every tap gesture inside the webview.")
        // handle some cases when the webview is tapped.
//        if let selectedWebView = recognizer.view as? WKWebView {
//            selectWebView(selectedWebView)
//        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        if traitCollection.horizontalSizeClass == .compact {
//            stackView.axis = .vertical
//        } else {
//            stackView.axis = .horizontal
//        }
    }
    
    /*
     * Do something after the page was loaded.
     * Example: Inject some java script in the code.
     */
    func updateUI(for webView: WKWebView) {
        setControllerTitle(title: webView.title)
    }
    
    /*
     * This JS injection code is done after .atDocumentEnd is loaded.
     */
    private func registerWebviewControllerHandler(contentController: WKUserContentController) {
        // Send a message to the uikit controller after 2 sec of waiting.
        let js = """
            setTimeout(function(){
                if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleMessageHandler) {
                   window.webkit.messageHandlers.toggleMessageHandler.postMessage({
                       "message": "A DUMMY MESSAGE SENT FROM WEBVIEW PAGE TO THE WEBVIEW IOS"
                  });
              }
            }, 2000)
        """
        // Execute after the data was loaded in the page
        let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)
    }
    
    /*
     * This JS injection code can be done any time we want. Compaire it with "addUserScript(...)"
     */
    private func evaluateJsDoChangeInWebViewPage() {
        let css = """
        body {
          background-color: red !important;
        }
        """
        let cssString = css.components(separatedBy: .newlines).joined()
        // Do something inside the page after 2 seconds
        let script = """
             setTimeout(function(){
                var element = document.createElement('style');
                element.innerHTML = '\(cssString)';
                document.head.appendChild(element);
             }, 2000);
         """
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
    
    private func setControllerTitle(title: String?) {
        self.title = webView.title ?? ""
    }
    
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
    
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //if webView == activeWebView {
        updateUI(for: webView)
        evaluateJsDoChangeInWebViewPage()
        //}
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//         `navigationType` indicates how this request got created
//         `.other` may indicate an Ajax request
//         More info: https://developer.apple.com/documentation/webkit/wknavigationtype

//         Update: remove the if clause for now and see if you get any result for your Ajax requests.
         if navigationAction.navigationType == .other {
            if let request = navigationAction.request.url {
                print("Resource Request: \(request)")
            }
         }

//         Allow the navigation to continue or not, depending on your business logic
        decisionHandler(.allow)
    }
    
}

