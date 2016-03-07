package  {
	
	import flash.display.*;
	import flash.geom.*;
	
	public class Board extends MovieClip {
		private var score:int;
		private var remainingTime:Number;
		private var transportation:String;
		private var speedCar:Transportation;
		
		public function Board() {
			// constructor code
			this.x=0;
			this.y=340;
		}
		public function setScore(score:Number){
			this.score=score;
		}
		
		public function setRemainingTime(remainingTime:Number){
			this.remainingTime=remainingTime;
		}
		
		public function setTransportation(transportation:String){
			this.transportation=transportation;
		}
		
		public function clockTime(ms:int):String {
			var seconds:int = Math.floor(ms/1000);
			var minutes:int = Math.floor(seconds/60);
			seconds -= minutes*60;
			var timeString:String = minutes+":"+String(seconds+100).substr(1,2);
			return timeString;
		}
		public function updateBoard(){
			this.scoreText.text=String(score);
			this.timeText.text=clockTime(remainingTime);
			//trace(score);
			//trace(remainingTime);
			
			
			
			
		}
		
		public function updateTransportation(){
			speedCar=new Transportation();
				if(this.transportation=="speedCar"){
					speedCar.x=500;
					speedCar.y=10;
					speedCar.gotoAndStop(1);
				//trace(this.speedCar.x);
				}
				if(this.transportation=="slowCar"){
					speedCar.x=550;
					speedCar.y=10;
					speedCar.gotoAndStop(2);
				//trace(this.speedCar.x);
				}
				if(this.transportation=="bicycle"){
					speedCar.x=550;
					speedCar.y=10;
					speedCar.gotoAndStop(3);
				//trace(this.speedCar.x);
				}
			this.addChild(speedCar);
			}
		
		
	}
	
}
