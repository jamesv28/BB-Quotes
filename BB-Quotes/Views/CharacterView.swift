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
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        ProgressView()
                    }
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
                        
                        
                    }
                    .frame(width: geo.size.width / 1.25, alignment: .leading)
                    
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
