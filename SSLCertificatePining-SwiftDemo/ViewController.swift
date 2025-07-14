//
//  ViewController.swift
//  SSLCertificatePining-SwiftDemo
//
//  Created by Gourav on 14/07/25.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://yourserver.com/api/secure")!

        NetworkManager.shared.fetchData(from: url) { data in
            if let data = data {
                print("✅ Received data: \(data)")
            } else {
                print("❌ Failed to fetch data.")
            }
        }
    }
}

