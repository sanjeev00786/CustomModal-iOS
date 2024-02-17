//
//  TermsConditionModal.swift
//  TradeIQ Ultra
//
//  Created by Sanjeev Mehta on 16/02/24.
//

import UIKit
import WebKit

class TermsConditionModal: UIViewController, WKNavigationDelegate {
    
    private let dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = COLORS.BG_CLR
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = COLORS.PRIMARY_CLR
        loader.hidesWhenStopped = true
        return loader
    }()
    
    var webViewURL: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        webView.navigationDelegate = self
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(dialogView)
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dialogView.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            dialogView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -52),
            dialogView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            dialogView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
        
        // Add dismiss button
        dialogView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -8)
        ])
        
        // Add webView
        dialogView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 8),
            webView.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: 0)
        ])
        
        // Add loaderView
        dialogView.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: webView.centerYAnchor)
        ])
        
        // Load a sample web content
        if let urlString = webViewURL, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func show(in viewController: UIViewController) {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: true, completion: nil)
        animateDialogAppearance()
    }
    
    @objc private func dismissButtonTapped() {
        dismiss()
    }
    
    func dismiss() {
        animateDialogDismissal {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func animateDialogAppearance() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.dialogView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.dialogView.transform = .identity
            }
        }
    }
    
    private func animateDialogDismissal(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            self.dialogView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        } completion: { _ in
            self.view.alpha = 0.0
            completion()
        }
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loaderView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loaderView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loaderView.stopAnimating()
    }
    
}
