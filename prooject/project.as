package  {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.utils.getTimer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	public class project extends MovieClip {
	
		private var arrowLeft, arrowRight, arrowUp, arrowDown:Boolean;
		private var gameStartTime:int;
		private var lastTime:int;
		private var score:int;
		private var map:Map;
		private var board:Board;
		private var gameOver:Boolean=false;
		private var remainingTime:int;
		private var transportation:String;
		private var catchUp:Boolean=false;
		private var endStatus:String;
		private var timer:Timer;
		//private var smallMap:SmallMap;
		
		var policeSound:HornSound = new HornSound();
		var clickSound:ClickSound = new ClickSound();
		
		public function project() {
			
		}
		public function startMove() {
			map=new Map();
			addChild(map);
			map.chooseTransportation(transportation);
			board=new Board();
			addChild(board);
			
			/*smallMap=new SmallMap();
			smallMap.x=500;
			smallMap.y=0;
			addChild(smallMap);*/
			
			gameStartTime = getTimer();
			
			board.setTransportation(transportation);
			board.updateTransportation();
			
			stage.focus=stage;
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			
		}
		
		
		public function gameLoop(event:Event){
		 if (lastTime == 0) lastTime = getTimer();
			var timeDiff:int = getTimer()-lastTime;
			lastTime += timeDiff;
	
	
			map.policeCarAnimation(timeDiff);
		
			if (arrowLeft) {
				map.playercar.rotateCar(timeDiff,"left");
			}
			if (arrowRight) {
				map.playercar.rotateCar(timeDiff,"right");
			}
			
			// move car
			if (arrowUp) {
				map.movePlayerCar(timeDiff);
				map.centerMap();
				map.pickUpPackge();
			}
			
			updateStatus();
		}
		
		public function updateStatus(){
			score=map.getScore();
			catchUp=map.checkCatchUp();
			if(map.playPoliceSound()){
				playSound(policeSound);
			}
			//trace(gameOver);
			
			board.setScore(score);
			remainingTime=120000-(lastTime-gameStartTime);
			board.setRemainingTime(remainingTime);
			board.updateBoard();
			
			if(catchUp){
				endStatus="You Lose";
				
				removeChild(map);
				removeChild(board);
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
				stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
				arrowLeft=false; 
				arrowRight=false; 
				arrowUp=false; 
				arrowDown=false;
				gotoAndStop(4);
				
			}
			
			if(remainingTime<0){
				if(score>=5){
				endStatus="You Win";
				}else{
					endStatus="You Lose";
				}
				removeChild(map);
				removeChild(board);
				this.removeEventListener(Event.ENTER_FRAME,gameLoop);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
				stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
				arrowLeft=false; 
				arrowRight=false; 
				arrowUp=false; 
				arrowDown=false;
				gotoAndStop(4);
				
				
			}
			
			
		}
		
		public function keyDownFunction(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				arrowLeft = true;
			} else if (event.keyCode == 39) {
				arrowRight = true;
			} else if (event.keyCode == 38) {
				arrowUp = true;
			} else if (event.keyCode == 40) {
				arrowDown = true;
			}
		}
		
		public function keyUpFunction(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				arrowLeft = false;
			} else if (event.keyCode == 39) {
				arrowRight = false;
			} else if (event.keyCode == 38) {
				arrowUp = false;
			} else if (event.keyCode == 40) {
				arrowDown = false;
			}
		}
		
		public function playSound(soundObject:Object) {
			var channel:SoundChannel = soundObject.play();
		}
		
		
		
		
	}
	
}
