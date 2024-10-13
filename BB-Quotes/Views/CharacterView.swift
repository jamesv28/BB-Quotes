import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                ScrollView {
                    TabView {
                        ForEach(character.images, id: \.self) { characterImage in
                            AsyncImage(url: characterImage) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                    }
                    .tabViewStyle(.page)
                    .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                    .clipShape(.rect(cornerRadius: 26))
                    .padding(.top, 60)
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        Text("Protrayed By: \(character.portrayedBy)")
                        Divider()
                        
                        Text("\(character.name) Character Info;")
                            .font(.title2)
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations: ")
                        
                        ForEach(character.occupations, id: \.self){ occupation in
                            Text("• \(occupation)")
                                .font(.subheadline)
                        }
                        Divider()
                        
                        Text("NIcknames")
                        
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self){ alias in
                                Text("• \(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        DisclosureGroup("Status: spoiler alert!") {
                            VStack(alignment: .leading) {
                                Text(character.status)
                                    .font(.title2)
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text("How: \(death.details)")
                                        .padding(.bottom, 6)
                                    Text("Last Words: \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                        .tint(.primary)
                        
                        
                    }
                    .frame(width: geo.size.width / 1.25, alignment: .leading)
                    .padding(.bottom, 50)
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
