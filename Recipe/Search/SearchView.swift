//
//  SearchView.swift
//  Recipe
//
//  Created by Bartosz Klimek on 20/09/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var queryResults: [Product] = []
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    TextFieldModifier {
                        TextField("Enter product", text: $query)
                    }
                    Button {
                        Repository.searchProduct(query: query) { results in
                            queryResults = results ?? []
                        }
                    } label: {
                        ButtonView(title: "Search")
                    }
                }
                
                ForEach(queryResults, id: \.self) { result in
                    PLPMember(title: result.title, color: .gray)
                }
            }
            .padding(5)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
