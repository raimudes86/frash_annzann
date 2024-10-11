//
//  AnswerView.swift
//  testmodal
//
//  Created by 木下来夢 on 2024/09/14.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject var dataModel: DataModel
    @Binding var judge: Bool
    @Binding var Total: Int
    @Binding var inputText: String
    @State var isShowMenu: Bool = false
    @State var isShowFrash: Bool = false
    var body: some View {
        if judge{
            ZStack{
                VStack(spacing: 0){
                    Text("正解")
                        .frame(width: UIScreen.main.bounds.width*4/5,height: 80)
                        .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.2))
                        .font(.system(size: 70))
                        .background(Color(red: 0.8, green: 0.5, blue: 0.5))
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width*4/5,height: 5)
                        .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.2))
                        .font(.system(size: 70))
                        .background(Color(red: 0.8, green: 0.5, blue: 0.5))
                    HStack{
                        Text("正答")
                            .padding(.leading, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(red: 0.5, green:0.8, blue: 0.5))
                        Spacer()
                        Text(String(Total))
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.title)
                            .foregroundColor(Color(red:0.5,green:0.5,blue:0.5))
                        
                    }
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width*4/5)
                    //ボタンの作成
                    HStack{
                        Button {
                            isShowMenu = true
                        } label: {
                            Text("やめる")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color(red:0.0,green:0.4,blue:0.8))
                                .font(.system(size: 40))
                                .padding(.top, 15)
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        }
                        .fullScreenCover(isPresented: $isShowMenu){
                            ContentView()
                                .environmentObject(dataModel)
                        }
                        
                        Button {
                            isShowFrash = true
                        } label: {
                            Text("つぎへ")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color(red:0.8,green:0.6,blue:0.1))
                                .font(.system(size: 40))
                                .padding(.top, 15)
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        }
                        .fullScreenCover(isPresented: $isShowFrash){
                            frashView()
                                .environmentObject(dataModel)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(Color.black)
        }else{
            ZStack{
                VStack(spacing: 0){
                    Text("不正解")
                        .frame(width: UIScreen.main.bounds.width*4/5,height: 80)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.6))
                        .font(.system(size: 70))
                        .background(Color(red: 0.5, green: 0.5, blue: 0.8))
                        .cornerRadius(2.0)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width*4/5,height: 5)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.6))
                    HStack{
                        Text("正答")
                            .padding(.leading, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(red: 0.5, green:0.8, blue: 0.5))
                        Spacer()
                        Text(String(Total))
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.title)
                            .foregroundColor(Color(red:0.5,green:0.5,blue:0.5))
                        
                    }//H
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width*4/5)
                    .cornerRadius(2.0)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width*4/5,height: 0.8)
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .font(.system(size: 70))
                    
                    HStack{
                        Text("あなたの回答")
                            .padding(.leading, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color(red: 0.5, green:0.8, blue: 0.5))
                        Spacer()
                        Text(inputText)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .font(.title)
                            .foregroundColor(Color(red:0.5,green:0.5,blue:0.5))
                        
                    }//H
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width*4/5)
                    .cornerRadius(2.0)
                    
                    //ボタンの作成
                    HStack{
                        Button {
                            isShowMenu = true
                        } label: {
                            Text("やめる")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color(red:0.0,green:0.4,blue:0.8))
                                .font(.system(size: 40))
                                .padding(.top, 15)
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        }
                        .fullScreenCover(isPresented: $isShowMenu){
                            ContentView()
                                .environmentObject(DataModel())
                        }
                        
                        Button {
                            isShowFrash = true
                        } label: {
                            Text("つぎへ")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color(red:0.8,green:0.6,blue:0.1))
                                .font(.system(size: 40))
                                .padding(.top, 15)
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        }
                        .fullScreenCover(isPresented: $isShowFrash){
                            frashView()
                                .environmentObject(DataModel())
                        }
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(Color.black)
        }
    }
}

#Preview {
    AnswerView(judge: .constant(true),Total: .constant(5), inputText: .constant("10"))
}
