class BasicStopwatch {
	
	var requiredDuration: TimeInterval = 12
	
	var timer: CADisplayLink!
	var firstTimestamp: CFTimeInterval!
	var elapsedTime: TimeInterval = 0

	let formatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "mm:ss.SS"
		return df
	}()
	
	func begin() {
		timer = CADisplayLink(target: self, selector: #selector(tick))
		timer.preferredFramesPerSecond = 30
		timer.add(to: .main, forMode: .common)
	}
	
	@objc func tick() {
		if (self.firstTimestamp == nil) {
			print("Start")
			self.firstTimestamp = timer!.timestamp
			return
		}
		
		elapsedTime = timer.timestamp - firstTimestamp
		print(elapsedTimeAsString())

		if elapsedTime >= requiredDuration {
			print("Done")
			timer.isPaused = true
		}
	}
	
	func elapsedTimeAsString() -> String {
		return formatter.string(from: Date(timeIntervalSinceReferenceDate: elapsedTime))
	}
}


