//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Martí Espinosa Farran on 22/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = [
        "afghanistan",
        "albania",
        "algeria",
        "andorra",
        "angola",
        "antigua-and-barbuda",
        "argentina",
        "armenia",
        "australia",
        "austria",
        "azerbaijan",
        "bahamas",
        "bahrain",
        "bangladesh",
        "barbados",
        "belarus",
        "belgium",
        "belize",
        "benin",
        "bhutan",
        "bolivia",
        "bosnia-and-herzegovina",
        "botswana",
        "brazil",
        "brunei",
        "bulgaria",
        "burkina-faso",
        "burundi",
        "cabo-verde",
        "cambodia",
        "cameroon",
        "canada",
        "central-african-republic",
        "chad",
        "chile",
        "china",
        "colombia",
        "comoros",
        "congo",
        "costa-rica",
        "croatia",
        "cuba",
        "cyprus",
        "czech-republic",
        "denmark",
        "djibouti",
        "dominica",
        "dominican-republic",
        "dr-congo",
        "ecuador",
        "egypt",
        "el-salvador",
        "equatorial-guinea",
        "eritrea",
        "estonia",
        "eswatini",
        "ethiopia",
        "fiji",
        "finland",
        "france",
        "gabon",
        "gambia",
        "georgia",
        "germany",
        "ghana",
        "greece",
        "grenada",
        "guatemala",
        "guinea-bissau",
        "guinea",
        "guyana",
        "haiti",
        "honduras",
        "hungary",
        "iceland",
        "india",
        "indonesia",
        "iran",
        "iraq",
        "ireland",
        "israel",
        "italy",
        "ivory-coast",
        "jamaica",
        "japan",
        "jordan",
        "kazakhstan",
        "kenya",
        "kiribati",
        "kuwait",
        "kyrgyzstan",
        "laos",
        "latvia",
        "lebanon",
        "lesotho",
        "liberia",
        "libya",
        "liechtenstein",
        "lithuania",
        "luxembourg",
        "madagascar",
        "malawi",
        "malaysia",
        "maldives",
        "mali",
        "malta",
        "marshall-islands",
        "mauritania",
        "mauritius",
        "mexico",
        "micronesia",
        "moldova",
        "monaco",
        "mongolia",
        "montenegro",
        "morocco",
        "mozambique",
        "myanmar",
        "namibia",
        "nauru",
        "nepal",
        "netherlands",
        "new-zealand",
        "nicaragua",
        "niger",
        "nigeria",
        "north-korea",
        "north-macedonia",
        "norway",
        "oman",
        "pakistan",
        "palau",
        "panama",
        "papua-new-guinea",
        "paraguay",
        "peru",
        "philippines",
        "poland",
        "portugal",
        "qatar",
        "romania",
        "russia",
        "rwanda",
        "saint-kitts-and-nevis",
        "saint-lucia",
        "saint-vincent-and-grenadines",
        "samoa",
        "san-marino",
        "sao-tome-and-principe",
        "saudi-arabia",
        "senegal",
        "serbia",
        "seychelles",
        "sierra-leone",
        "singapore",
        "slovakia",
        "slovenia",
        "solomon-islands",
        "somalia",
        "south-africa",
        "south-korea",
        "south-sudan",
        "spain",
        "sri-lanka",
        "sudan",
        "suriname",
        "sweden",
        "switzerland",
        "syria",
        "tajikistan",
        "tanzania",
        "thailand",
        "timor-leste",
        "togo",
        "tonga",
        "trinidad-and-tobago",
        "tunisia",
        "turkey",
        "turkmenistan",
        "tuvalu",
        "uganda",
        "ukraine",
        "united-arab-emirates",
        "united-kingdom",
        "united-states",
        "uruguay",
        "uzbekistan",
        "vanuatu",
        "vatican-city",
        "venezuela",
        "vietnam",
        "yemen",
        "zambia",
        "zimbabwe",
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var selectedFlag: Int? = nil
    @State private var isDisabled = false
    
    @State private var correctCount = 0
    @State private var totalCount = 0
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
//            LinearGradient(colors: [.blue, .blue.opacity(0.5)], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            Color.green.ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    Text("Tap the flag of")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text(countries[correctAnswer].replacingOccurrences(of: "-", with: " "))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(height: 40)
                        .padding(.bottom, 20)
                }
                .foregroundStyle(.background.opacity(0.8))
                .textCase(.uppercase)
                
                VStack(spacing: -25) {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            ZStack {
                                Image(countries[number])
                                    .resizable()
                                    .frame(width: 200, height: 200)
//                                    .shadow(color: selectedFlag != nil ? (number == correctAnswer ? .green : number == selectedFlag ? .red : .black.opacity(0.5)) : .black.opacity(0.5), radius: 10)
                                    .opacity(0.85)
                                Rectangle()
                                    .fill(selectedFlag != nil ? (number == correctAnswer ? Color.green.opacity(0.7) : number == selectedFlag ? Color.red.opacity(0.7) : Color.gray) : Color.clear)
                                    .frame(width: 200, height: 145)
                                    .cornerRadius(21)
                                    .padding(28)
                                Text(selectedFlag != nil ? (number == correctAnswer ? "" : number == selectedFlag ? countries[number].uppercased() : "") : "")
                                    .font(.headline)
                                    .foregroundStyle(.primary.opacity(0.5))
                            }
                        }
                        .disabled(isDisabled)
                    }
                }
                .padding(.vertical)
                .frame(width: 260, height: 560)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                Spacer()
                Text("SCORE: \(correctCount) / \(totalCount)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.background.opacity(0.8))
                    .persistentSystemOverlays(.hidden)
            }
            .padding()
        }
        .onTapGesture {
            if selectedFlag != nil {
                askQuestion()
            }
        }
        .alert("Your score is \(correctCount) / \(totalCount)", isPresented: $showAlert) {
            Button("Play again") {
                correctCount = 0
                totalCount = 0
                askQuestion()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedFlag = number
        isDisabled = true
        totalCount += 1
        if number == correctAnswer {
            correctCount += 1
        }
        
        if totalCount == 10 {
            showAlert = true
        }
    }
    
    func askQuestion() {
        selectedFlag = nil
        isDisabled = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

