//
//  ViewController.swift
//  ConcurrencyTest
//


import UIKit

class ViewController: UIViewController {

    let label = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        
        label.text = "loading"
        //load message timeout is 2 seconds
        let timeout = DispatchTimeInterval.seconds(2)
        
        loadGreetingMessage(timeout: timeout) { combinedMessage in
            self.label.text = combinedMessage
        }
    }
}

extension ViewController {
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
