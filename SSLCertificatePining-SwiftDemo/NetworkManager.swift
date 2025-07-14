//
//  ViewController.swift
//  SSLCertificatePining-SwiftDemo
//
//  Created by Gourav on 14/07/25.
//

import Foundation

class NetworkManager: NSObject, URLSessionDelegate {
    static let shared = NetworkManager()

    private lazy var session: URLSession = {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()

    func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("❌ Request failed: \(error!)")
                completion(nil)
                return
            }

            completion(data)
        }
        task.resume()
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let serverCert = SecTrustCopyCertificateChain(serverTrust) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        let localCertPath = Bundle.main.path(forResource: "yourserver.com", ofType: "cer")!
        let localCertData = try! Data(contentsOf: URL(fileURLWithPath: localCertPath))

        let serverCertData = SecCertificateCopyData(serverCert as! SecCertificate) as Data

        if serverCertData == localCertData {
            print("✅ Certificate is valid (pinned).")
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            print("❌ Certificate mismatch.")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
