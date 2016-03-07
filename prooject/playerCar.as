package  {
	
	import flash.display.MovieClip;
	
	
	public class playerCar extends MovieClip {
		
		//static const speed:Number = .3;
		static const turnSpeed:Number = .4;
		
		public function playerCar() {
			// constructor code
		}
		public function rotateCar(timeDiff:Number, direction:String) {
			if (direction == "left") {
				this.rotation -= turnSpeed*timeDiff;
			} else if (direction == "right") {
				this.rotation += turnSpeed*timeDiff;
			}
		}
		
		
		
		
		
	}
	
}
