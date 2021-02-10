//
//  PostDetailView.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import SwiftUI

struct PostDetailView: View {

    @ObservedObject var viewModel: PostDetailsViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(viewModel: PostDetailsViewModel(with: Post.dummy()))
        PostDetailView(viewModel: PostDetailsViewModel(with: Post.dummy())).colorScheme(.dark)
    }
}
