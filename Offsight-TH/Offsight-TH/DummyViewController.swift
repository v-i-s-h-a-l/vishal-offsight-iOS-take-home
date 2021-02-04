//
//  DummyViewController.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

class DummyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        
        let dataTask = URLSession.shared.dataTask(with: Endpoint.post.urlRequest) { (data, response, error) in
            // TODO: check response status code
            // TODO: Handle error
            guard let data = data else { return }
            let apiData = try! JSONDecoder().decode(DummyAPIData.self, from: data)
            print(apiData)
        }
        
        dataTask.resume()
    }
}
