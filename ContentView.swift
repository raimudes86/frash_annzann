import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: DataModel
    
    @State private var showAlert = false
    @State private var selectedValue: SelectedValue?
    @State private var inputValue: String = ""
    @State private var newinputValue: String = ""
    @FocusState private var isTextFocused: Bool
    @State private var isPressed = false
    @State private var isActive = false
    @State private var isshowAlert = false
    
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: UIScreen.main.bounds.width,height: 70)
                    Text("フラッシュ暗算")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                    
                }
                
                List {
                    HStack {
                        Text("口数")
                        Spacer()
                        Button(action: {
                            selectedValue = .kousuu
                            inputValue = "\(dataModel.kousuu)"
                            showAlert = true
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: 100, height: 30)
                                    .cornerRadius(5)
                                Text("\(dataModel.kousuu)")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                                    .padding(.leading, 15)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    HStack {
                        Text("桁数")
                        Spacer()
                        Button(action: {
                            selectedValue = .ketasuu
                            inputValue = "\(dataModel.ketasuu)"
                            showAlert = true
                        }) {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: 100, height: 30)
                                    .cornerRadius(5)
                                Text("\(dataModel.ketasuu)")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                                    .padding(.leading, 15)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                    HStack {
                        Text("表示間隔")
                        Spacer()
                        Button(action: {
                            selectedValue = .hyoujiKankaku
                            inputValue = String(format: "%.3f", dataModel.hyoujiKankaku)
                            showAlert = true
                        }) {
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: 100, height: 30)
                                    .cornerRadius(5)
                                Text(String(format: "%.3f", dataModel.hyoujiKankaku))
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                                    .padding(.leading, 15)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Button {
                    isPressed = true
                    isActive = true
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.green)
                            .frame(width: UIScreen.main.bounds.width/1.5,height: 70)
                            .cornerRadius(5)
                            .shadow(color: isPressed ? Color.gray.opacity(0.5) : Color.gray.opacity(0.7), radius: 10, x: isPressed ? 5 : 10, y: isPressed ? 5 : 10)
                        //                            .scaleEffect(isPressed ? 0.95 : 1.0)
                        Text("スタート")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                }
                .fullScreenCover(isPresented: $isActive){
                    frashView()
                        .environmentObject(dataModel)
                }
            }//V
            .alert("エラー", isPresented: $isshowAlert){
                Button("OK", role: .cancel){}
            }message:{
                Text("範囲内の値を入力してください")
            }
            
            // カスタムアラートをオーバーレイ
            if showAlert {
                Color.black.opacity(0.4) // 背景の半透明
                    .edgesIgnoringSafeArea(.all) // 全画面に広げる
                
                VStack(spacing: 20) {
                    Text("値を入力")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    switch selectedValue {
                    case .kousuu:
                        Text("3〜100の範囲で指定してください")
                    case .ketasuu:
                        Text("1〜5の範囲で指定してください")
                    case .hyoujiKankaku:
                        Text("100〜5000ミリ秒の範囲で設定してください")
                    case .none:
                        Text("ボタンを選択してください")
                    }
                    
                    TextField("数値を入力", text: $newinputValue)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.primary)
                        .focused($isTextFocused)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .onSubmit{
                            decision_process()
                        }
                    
                    HStack {
                        Button("キャンセル") {
                            showAlert = false
                            newinputValue = ""
                        }
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        
                        Button("決定") {
                            decision_process()
                            
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .frame(width: UIScreen.main.bounds.width/1.3)
                .onAppear{
                    isTextFocused = true
                }
            }//カスタムアラート
        }//Z
    }
    func decision_process(){
        if let value = Double(newinputValue) {
            switch selectedValue {
            case .kousuu:
                if 3 > value || value > 100{
                    isshowAlert = true
                }else{
                    dataModel.kousuu = value == 0 ? 0 : Int(value)
                }
            case .ketasuu:
                if value < 1 || value > 5{
                    isshowAlert = true
                }else{
                    dataModel.ketasuu = value == 0 ? 0 : Int(value)
                }
            case .hyoujiKankaku:
                if value < 100 || value > 5000{
                    isshowAlert = true
                }else{
                    dataModel.hyoujiKankaku = value == 0 ? 0 :  value/1000
                }
            case .none:
                break
            }
        }
        showAlert = false
        newinputValue = ""
    }
    
}

enum SelectedValue {
    case kousuu
    case ketasuu
    case hyoujiKankaku
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
