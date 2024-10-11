import SwiftUI

struct frashView: View {
    @State private var currentNumber: Int = 0
    @State private var totalSum: Int = 0
    @State private var userInput: String = ""
    @State private var message: String = ""
    @State private var numbersShown: [Int] = []
    @State private var tmpNum: Int = 0
    @State private var isResultshow: Bool = false
    @State private var isShowNum: Bool = false
    
    // 数値を表示する時間間隔（秒）
//    @Binding var numberOfNumbers: Int // 表示する数の数
//    @Binding var numberOfDigit: Int //表示する数の桁
//    @Binding var displayInterval: Double //表示する間隔
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            // ランダムな数値を表示
            if isShowNum{
                Text("\(String(currentNumber))")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .bold()
            }
        }
        .background(Color.black)
        .onAppear(){
            isShowNum = false
            totalSum = 0
            currentNumber = Int.random(in: 10.power(of: dataModel.ketasuu-1)..<10.power(of: dataModel.ketasuu))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                isShowNum = true
                totalSum += currentNumber
                startFlashAnzan()
            }
        }
        .fullScreenCover(isPresented: $isResultshow){
            ResultView(Total: $totalSum)
        }
    }
    
    // フラッシュ暗算を開始
    func startFlashAnzan() {
        numbersShown = []
        
        for i in 1..<dataModel.kousuu {
            DispatchQueue.main.asyncAfter(deadline: .now() +  dataModel.hyoujiKankaku * Double(i)) {
                let randomNum = makeNum()
                currentNumber = randomNum
                totalSum += randomNum
                numbersShown.append(randomNum)
            }
        }
        
        // 数字表示後、結果入力フェーズに移行
        DispatchQueue.main.asyncAfter(deadline: .now() + dataModel.hyoujiKankaku * Double(dataModel.kousuu)) {
            isResultshow = true
        }
    }
    
    func makeNum() -> Int{
        repeat {
            tmpNum = Int.random(in: 10.power(of: dataModel.ketasuu-1)..<10.power(of: dataModel.ketasuu))
        }while tmpNum == currentNumber
        return Int(tmpNum)
    }
    
    // ユーザーの入力が正しいか確認
    func checkAnswer() {
        if let userSum = Int(userInput), userSum == totalSum {
            message = "正解！"
        } else {
            message = "不正解！ 正しい合計は \(totalSum) です"
        }
    }
    
}

extension Int{
    func power(of exponent: Int) -> Int{
        return Int(pow(Double(self),Double(exponent)))
    }
}

struct frashView_Previews: PreviewProvider {
    static var previews: some View {
        frashView()
            .environmentObject(DataModel())
    }
}


