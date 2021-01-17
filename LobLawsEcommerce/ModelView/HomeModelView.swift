//
//  HomeModelView.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-17.
//

import Foundation

protocol HomeModelViewDelete {
    func networkApiFails(error : String)
    func networkApiSuccessful(entry : [Entry])
}

class HomeModelView {
    var delegate : HomeModelViewDelete!

    func fetchData(){
        let apiClient = ApiClient()
        apiClient.fetchCart(inputJson: "") { (entry, err) in
            if (entry.count == 0){
                self.delegate.networkApiFails(error: err)
                return
            }
            self.delegate.networkApiSuccessful(entry: entry)
        }
    }
}
