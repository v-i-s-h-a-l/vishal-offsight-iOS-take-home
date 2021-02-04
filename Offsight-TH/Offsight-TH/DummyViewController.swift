//
//  DummyViewController.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Combine
import UIKit

class DummyViewController: UIViewController {

    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        // Do any additional setup after loading the view.

        DummyAPINetworkClient().getPosts(page: 2)
            .sink { completion in
                switch completion {
                // TODO: Handle error
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { apiData in
                print(apiData.data.count)
            }
            .store(in: &subscriptions)

    }
}
