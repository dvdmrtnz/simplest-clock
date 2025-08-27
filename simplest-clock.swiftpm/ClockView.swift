import SwiftUI

struct ClockView: View {
    @State private var now = Date()
    // 24h formatter
    private static let df: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_GB") // ensures 24h symbols
        f.dateFormat = "HH mm ss"
        return f
    }()
    
    var body: some View {
        Text(Self.df.string(from: now))
            .font(.system(size: 1000, weight: .bold))
            .minimumScaleFactor(0.1)
            .monospacedDigit()
            .lineLimit(1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .foregroundStyle(.white)
            .scaleEffect(x: 1, y: 2)
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                now = Date()
            }
            .onAppear {
                // Disable the idle timer when the view appears
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                // Re-enable the idle timer when the view disappears
                UIApplication.shared.isIdleTimerDisabled = false
            }
    }
}
