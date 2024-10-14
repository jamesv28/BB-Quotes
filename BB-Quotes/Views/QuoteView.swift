//
//  QuoteView.swift
//  BB-Quotes
//
//  Created by James Volmert on 10/9/24.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    @State var showCharacterInfo: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.removeCasesAndSpaces())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2 )
                VStack {
                    VStack {
                        
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                
                            }
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 60))
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                        case .failed(let error):
                            Text("Error: \(error.localizedDescription)")
                        }
                        
                        Spacer()
                    }
                    Button {
                        Task {
                            await vm.getQuoteData(for: show)
                        }
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color("\(show.removeSpaces())Button"))
                            .clipShape(.rect(cornerRadius: 5))
                            .shadow(color: Color(Color("\(show.removeSpaces())Shadow")), radius: 2)
                    }
                    Spacer(minLength: 95)
                    
                    
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height )
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    QuoteView(show: Constants.ecName)
        .preferredColorScheme(.dark)
}
