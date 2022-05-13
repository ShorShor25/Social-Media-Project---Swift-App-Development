//
//  TItleRow.swift
//  SocialMedia
//
//  Created by Shaurya Baranwal on 3/21/22.
//

import SwiftUI

struct TItleRow: View {
    var imageUrl = URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fchieffrocka%2Fmiles-morales-spider-man%2F&psig=AOvVaw2gBX-2OHm1wKvQPkGsQS8W&ust=1650590354726000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCNjKvrD-o_cCFQAAAAAdAAAAABAD")
    var name = "Shaurya Baranwal"
    var body: some View {
        HStack(spacing: 20){
            AsyncImage(url: imageUrl){ image in
                image.resizable()
                    .aspectRatio(contentMode: .fill).frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name).font(.title).bold()
                
                Text("@ShorShor25").font(.caption).foregroundColor(Color("Dark Gray"))
            }.frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "phone.fill").foregroundColor(.gray).padding(10).background(.white).cornerRadius(50)
        }
        .padding()
    }
}

struct TItleRow_Previews: PreviewProvider {
    static var previews: some View {
        TItleRow().background(Color("Red"))
    }
}
