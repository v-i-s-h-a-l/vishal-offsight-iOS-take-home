//
//  PostDetailView.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import SwiftUI
import URLImage

struct PostDetailView: View {

    @ObservedObject var viewModel: PostDetailsViewModel
    
    var body: some View {
        ZStack {
            Theme.Col.background
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if let url = viewModel.imageURL {
                        URLImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.bottom)
                                .shadow(color: Theme.Col.shadowCasted, radius: 3.0, x: 3.0, y: 3.0)
                        }
                    } else {
                        Image(uiImage: UIImage(systemName: "xmark.icloud.fill")!)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.bottom)
                    }
                    HStack {
                        LikesButton(numberOfLikes: viewModel.numberOfLikes, isLiked: viewModel.isLiked, action: viewModel.onLikeButtonTap)
                        if viewModel.linkURL != nil {
                            OpenLinkButton(action: viewModel.onDetailTap)
                        }
                    }
                    Text(viewModel.text)
                        .font(.callout)
                        .foregroundColor(Theme.Col.textColor)
                        .padding(.top)
                    HStack {
                        Text(viewModel.publisherInfo)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.vertical)
                        Spacer()
                        Text(viewModel.publishDateText)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.vertical)
                    }
                    if !viewModel.tags.isEmpty {
                        VStack {
                            Text("Tags")
                                .font(.caption)
                                .foregroundColor(.primary)
                                .padding(2)
                                .background(Theme.Col.redStart)
                        }
                        HStack {
                            ForEach(viewModel.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                    .padding()
                                    .background(Theme.Col.redEnd)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(viewModel: PostDetailsViewModel(with: Post.dummy()))
        PostDetailView(viewModel: PostDetailsViewModel(with: Post.dummy())).colorScheme(.dark)
    }
}
