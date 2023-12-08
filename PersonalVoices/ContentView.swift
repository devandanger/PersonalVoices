//
//  ContentView.swift
//  PersonalVoices
//
//  Created by Evan Anger on 12/8/23.
//

import SwiftUI
import AVFoundation
import AVFAudio

let synthesizer = AVSpeechSynthesizer()


struct ContentView: View {
    @State private var personalVoices: [AVSpeechSynthesisVoice] = []
    @State private var selectedVoice: AVSpeechSynthesisVoice?
    @State private var speechToText: String = "United States, Canada, Mexico, Panama, Haiti, Jamaica, Peru"
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await fetchPersonalVoices()
                }
            }, label: {
                Text("Request Personal Voices")
            })
            .padding()
            
            if personalVoices.isEmpty {
                Text("No voices available")
            } else {
                ForEach(self.personalVoices, id: \.identifier) { voice in
                    Button(action: {
                        selectedVoice = voice
                    }, label: {
                        Text(voice.name)
                    })
                    .padding()
                    
                }
            }
            Spacer()
            if let selectedVoice {
                TextEditor(text: $speechToText)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    speakUtterance(string: speechToText)
                }, label: {
                    Text("Speak")
                })
                .padding()
            }
        
        }.padding()
    }
    
    func speakUtterance(string: String) {
        let utterance = AVSpeechUtterance(string: string)
        if let selectedVoice {
            utterance.voice = selectedVoice
            synthesizer.speak(utterance)
        }
    }
    
    func fetchPersonalVoices() async {
        AVSpeechSynthesizer.requestPersonalVoiceAuthorization() { status in
            if status == .authorized {
                personalVoices = AVSpeechSynthesisVoice.speechVoices().filter { $0.voiceTraits.contains(.isPersonalVoice) }
            }
        }
    }
}

#Preview {
    ContentView()
}
