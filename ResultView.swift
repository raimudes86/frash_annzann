//
//  ResultView.swift
//  testmodal
//
//  Created by 木下来夢 on 2024/09/13.
//

import SwiftUI

struct ResultView: View {
    @Binding var Total: Int
    @State var Result: Int = 0
    @State var inputText: String = ""
    @State var answer: Bool = false
    @State var isShowAnswer: Bool = false
    
    // グリッドに使う列の定義
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            // テキスト表示部分
            Text("回答を入力してください")
                .font(.title)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
            
            // 数字を表示する部分
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: UIScreen.main.bounds.height / 3)
                
                Text(inputText)
                    .foregroundColor(.white)
                    .font(.system(size: 100))
            }
            
            // キーパッド
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(1...9, id: \.self) { number in
                    Button(action: {
                        self.inputText += "\(number)"
                    }) {
                        Text("\(number)")
                            .frame(width: 110, height: 80)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 36))
                            .cornerRadius(10)
                    }
                }
                
                // その他のボタン (クリア、0、マイナス)
                Button(action: {
                    self.inputText = ""
                }) {
                    Image(systemName: "delete.left")
                        .frame(width: 110, height: 80)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    if !inputText.isEmpty && inputText != "-"{
                        self.inputText += "0"
                    }
                }) {
                    Text("0")
                        .frame(width: 110, height: 80)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    if inputText.isEmpty {
                        self.inputText += "-"
                    }
                }) {
                    Text("-")
                        .frame(width: 110, height: 80)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                        .cornerRadius(10)
                }
            }
            // 決定ボタン
            Button(action: {
                Judge()
                isShowAnswer = true
            }) {
                Text("決定")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .font(.system(size: 36))
                    .cornerRadius(10)
            }
            .padding()
            .fullScreenCover(isPresented: $isShowAnswer){
                AnswerView(judge: $answer, Total: $Total, inputText: $inputText)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    func Judge(){
        if inputText == String(Total){
            answer = true
        }else{
            answer = false
        }
    }
}

#Preview {
    ResultView(Total: .constant(50))
}
