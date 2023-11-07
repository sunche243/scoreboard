//
//  ContentView.swift
//  scoreboard
//
//  Created by 박찬준 on 10/29/23.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    private let width = 60.0

    func makeBody(configuration: Configuration) -> some View {
        HStack{
            ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: width - 5, height: (width / 2) + 3)
                    .foregroundColor(configuration.isOn ? Color.green : Color("toggleBackgroundColor"))
                Circle()
                    .frame(width: (width / 2) - 2, height: (width / 2) - 2)
                    .padding(3)
                    .foregroundColor(Color.white)
                    .shadow(color: Color("toggleShadowColor"), radius: 4)
            }
            .onTapGesture{
                withAnimation{
                    configuration.$isOn.wrappedValue.toggle()
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }
        }
    }
}

struct ContentView: View {
    @State var red_score: Int = 0
    @State var blue_score: Int = 0
    @State var red_set_score: Int = 0
    @State var blue_set_score: Int = 0
    @State var serve: Bool = false
    @State var pingpongMode: Bool = false
    var body: some View {
        ZStack{
            VStack(spacing:0){
                Spacer()
                ZStack{
                    Color.red
                        .ignoresSafeArea()
                    Text("\(String(red_set_score))")
                        .font(.system(size: 60, weight: .bold))
                        .padding(.bottom, 200)
                        .foregroundColor(Color.white)
                    if(serve){
                        Text("\(String(red_score))")
                            .font(.system(size: 200, weight: .bold))
                            .foregroundColor(pingpongMode == false ? Color.white : (((red_score + blue_score) / 2) % 2 == 1 ? Color.green : Color.white))
                            .padding(.bottom, -100)
                    } else{
                        Text("\(String(red_score))")
                            .font(.system(size: 200, weight: .bold))
                            .foregroundColor(pingpongMode == false ? Color.white : (((red_score + blue_score) / 2) % 2 == 1 ? Color.white : Color.green))
                            .padding(.bottom, -100)
                    }
                    HStack(spacing:0){
                        Rectangle()
                            .opacity(0.0001)
                            .onTapGesture {
                                if(red_score > 0){
                                    red_score = red_score - 1
                                }else{
                                    red_score = 0
                                }
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        Rectangle()
                            .opacity(0.0001)
                            .onTapGesture {
                                red_score = red_score + 1
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                    }
                }
                .ignoresSafeArea()
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(height: 10)
                ZStack{
                    Color.blue
                        .ignoresSafeArea()
                    Text("\(String(blue_set_score))")
                        .font(.system(size: 60, weight: .bold))
                        .padding(.bottom, 200)
                        .foregroundColor(Color.white)
                    if(serve){
                        Text("\(String(blue_score))")
                            .font(.system(size: 200, weight: .bold))
                            .foregroundColor(pingpongMode == false ? Color.white : (((red_score + blue_score) / 2) % 2 == 1 ? Color.white : Color.green))
                            .padding(.bottom, -100)
                    } else{
                        Text("\(String(blue_score))")
                            .font(.system(size: 200, weight: .bold))
                            .foregroundColor(pingpongMode == false ? Color.white : (((red_score + blue_score) / 2) % 2 == 1 ? Color.green : Color.white))
                            .padding(.bottom, -100)
                    }
                    HStack(spacing:0){
                        Rectangle()
                            .opacity(0.0001)
                            .onTapGesture {
                                if(blue_score > 0){
                                    blue_score = blue_score - 1
                                } else{
                                    blue_score = 0
                                }
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        Rectangle()
                            .opacity(0.0001)
                            .onTapGesture {
                                blue_score = blue_score + 1
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                    }
                }
            }
            .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Image(systemName: "figure.table.tennis")
                        .foregroundColor(Color.white)
                    Toggle("Ping-Pong Mode", isOn: $pingpongMode)
                        .toggleStyle(MyToggleStyle())
                }
                .padding(.horizontal)
                Spacer()
            }
            ZStack{
                Color.clear
                Rectangle()  // 가운데 네모
                    .frame(width: 240, height: 60)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .padding(.bottom, -6)
                HStack{
                    Image(systemName: "minus")
                        .foregroundColor(Color.red)
                        .bold()
                        .frame(width: 22, height: 26)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if(red_set_score > 0){
                                red_set_score = red_set_score - 1
                            }else{
                                red_set_score = 0
                            }
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    Image(systemName: "plus")
                        .foregroundColor(Color.red)
                        .bold()
                        .frame(width: 22, height: 26)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            red_set_score = red_set_score + 1
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.gray)
                        .bold()
                        .frame(width: 22, height: 26)
                        .contentShape(Rectangle())
                        .padding(.leading, pingpongMode ? 10 : 25)
                        .padding(.trailing, pingpongMode ? 0 : 25)
                        .onTapGesture {
                            blue_score = 0
                            red_score = 0
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                            .onEnded { _ in
                                blue_set_score = 0
                                red_set_score = 0
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        )
                    if(pingpongMode){
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(Color.gray)
                            .bold()
                            .frame(width: 22, height: 26)
                            .padding(.trailing, 10)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                serve.toggle()
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                    }
                    Image(systemName: "minus")
                        .foregroundColor(Color.blue)
                        .bold()
                        .frame(width: 22, height: 26)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if(blue_set_score > 0){
                                blue_set_score = blue_set_score - 1
                            } else{
                                blue_set_score = 0
                            }
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                    Image(systemName: "plus")
                        .foregroundColor(Color.blue)
                        .bold()
                        .frame(width: 22, height: 26)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            blue_set_score = blue_set_score + 1
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                }
                .padding(.bottom, -6)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
