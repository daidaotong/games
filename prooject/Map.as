package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.utils.getTimer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Map extends MovieClip {
		
		static const mapRect:Rectangle = new Rectangle(0,0,2280,2277);
		//static const speed:Number ;
		static const carSize:Number = 50;
		static const policeCarVision:Number=150;
		static const policeCarVoice:Number=700;
		
		private var speed:Number;
		private var blocks:Array;
		private var documentObject:bag;
		private var score:int=0;
		private var policeCarDirection:String;
		private var policeCarDirectionBefore:String;
		private var firstTurn:Boolean=true;
		private var finishTurn:Boolean;
		private var turnDirection:String;
		private var beenCaught:Boolean=false;
		
		
		/*var theGotOneSound:GotOneSound = new GotOneSound();
		var theFullSound:FullSound = new FullSound();
		var theDumpSound:DumpSound = new DumpSound();*/
		
		public function Map() {
			// constructor code
			policeCarDirection="right";
			findBlocks();
			placeDocument();
			centerMap();
			
		}
	
		
		public function findBlocks() {
			blocks = new Array();
			for(var i=0;i<this.numChildren;i++) {
				var mc = this.getChildAt(i);
				if (mc is Block) {
					// add to array and make invisible
					blocks.push(mc);
					//mc.visible = false;
				}
			}
		}
		
		public function placeDocument() {
			
			var x:Number = Math.floor(Math.random()*mapRect.width)+mapRect.x;
			var y:Number;
			if((this.turn1.x-120<x&&x<this.turn1.x)||(this.Tcross1.x<x&&x<this.Tcross1.x+120)||(this.Tcross2.x<x&&x<this.Tcross2.x+120)||(this.turn2.x-120<x&&x<this.turn2.x)){
				y = Math.floor(Math.random()*mapRect.height)+mapRect.y;
			}else{
				y = Math.floor(Math.random()*120)+mapRect.y+Math.floor(Math.random()*4)*720;
				}
			documentObject= new bag();
			documentObject.x = x;
			documentObject.y = y;
			documentObject.gotoAndStop(1);
			this.addChild(documentObject);
		}
		
		
		public function movePlayerCar(timeDiff:Number) {
			// calculate current car area
			var playerCarRect = new Rectangle(this.playercar.x-carSize/2, this.playercar.y-carSize/2, carSize, carSize);
			
			// calculate new car area
			var newCarRect = playerCarRect.clone();
			var carAngle:Number = (this.playercar.rotation/360)*(2.0*Math.PI);
			var dx:Number = Math.cos(carAngle);
			var dy:Number = Math.sin(carAngle);
			newCarRect.x += dx*speed*timeDiff;
			newCarRect.y += dy*speed*timeDiff;
			
			// calculate new location
			var newX:Number = this.playercar.x + dx*speed*timeDiff;
			var newY:Number = this.playercar.y + dy*speed*timeDiff;
			
			// loop through blocks and check collisions
			for(var i:int=0;i<blocks.length;i++) {
				
				// get block rectangle, see if there is a collision
				var blockRect:Rectangle = blocks[i].getRect(this);
				if (blockRect.intersects(newCarRect)) {
		
					// horizontal push-back
					if (playerCarRect.right <= blockRect.left) {
						newX += blockRect.left - newCarRect.right;
					} else if (playerCarRect.left >= blockRect.right) {
						newX += blockRect.right - newCarRect.left;
					}
					
					// vertical push-back
					if (playerCarRect.top >= blockRect.bottom) {
						newY += blockRect.bottom-newCarRect.top;
					} else if (playerCarRect.bottom <= blockRect.top) {
						newY += blockRect.top - newCarRect.bottom;
					}
				}
				
			}
			
			// check for collisions with sidees
			if ((newCarRect.right > mapRect.right) && (playerCarRect.right <= mapRect.right)) {
				newX += mapRect.right - newCarRect.right;
			}
			if ((newCarRect.left < mapRect.left) && (playerCarRect.left >= mapRect.left)) {
				newX += mapRect.left - newCarRect.left;
			}
			
			if ((newCarRect.top < mapRect.top) && (playerCarRect.top >= mapRect.top)) {
				newY += mapRect.top-newCarRect.top;
			}
			if ((newCarRect.bottom > mapRect.bottom) && (playerCarRect.bottom <= mapRect.bottom)) {
				newY += mapRect.bottom - newCarRect.bottom;
			}
		
			// set new car location
			if(!beenCaught){
			this.playercar.x = newX;
			this.playercar.y = newY;
			}
		}
		
		
		
		public function centerMap() {
			this.x = -this.playercar.x + 275;
			this.y = -this.playercar.y + 200;
		}
		
		
		public function collisionPoliceCar(timeDiff:Number){
		var rectanglePoliceCar:Rectangle = new Rectangle(this.policecar.x-carSize/2, this.policecar.y-carSize/2, carSize, carSize);
		
		var rectangleTurn1:Rectangle=new Rectangle (this.turn1.x-120,this.turn1.y,120,120);
		 var rectangleTurn2:Rectangle=new Rectangle(this.turn2.x-120,this.turn2.y-120,120,120);
		 var rectangleTurn3:Rectangle=new Rectangle(this.turn3.x,this.turn3.y,120,120);
		 var rectangleTurn4:Rectangle=new Rectangle(this.turn4.x,this.turn4.y-120,120,120);
		
		 var rectangleCrossRoad1:Rectangle=new Rectangle(this.crossroad1.x,this.crossroad1.y,120,120);
		 var rectangleCrossRoad2:Rectangle=new Rectangle(this.crossroad2.x,this.crossroad2.y,120,120);
		 var rectangleCrossRoad3:Rectangle=new Rectangle(this.crossroad3.x,this.crossroad3.y,120,120);
		 var rectangleCrossRoad4:Rectangle=new Rectangle(this.crossroad4.x,this.crossroad4.y,120,120);
		
		 var rectangleTCross1:Rectangle=new Rectangle(this.Tcross1.x,this.Tcross1.y,120,120);
		 var rectangleTCross2:Rectangle=new Rectangle(this.Tcross2.x,this.Tcross2.y,120,120);
		 var rectangleTCross3:Rectangle=new Rectangle(this.Tcross3.x,this.Tcross3.y-120,120,120);
		 var rectangleTCross4:Rectangle=new Rectangle(this.Tcross4.x-120,this.Tcross4.y,120,120);
		 var rectangleTCross5:Rectangle=new Rectangle(this.Tcross5.x,this.Tcross5.y-120,120,120);
		 var rectangleTCross6:Rectangle=new Rectangle(this.Tcross6.x-120,this.Tcross6.y,120,120);
		 var rectangleTCross7:Rectangle=new Rectangle(this.Tcross7.x-120,this.Tcross7.y-120,120,120);
		 var rectangleTCross8:Rectangle=new Rectangle(this.Tcross8.x-120,this.Tcross8.y-120,120,120);
		
		if(rectanglePoliceCar.intersects(rectangleTurn1)){
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
			}
			if(policeCarDirectionBefore=="left"){
				this.policecar.turnPoliceCar(timeDiff,"left","down"); 
				finishTurn=false; 
				policeCarDirection="down";
			}
			if(policeCarDirectionBefore=="up"){
				this.policecar.turnPoliceCar(timeDiff,"up","right"); 
				finishTurn=false; 
				policeCarDirection="right";
			}
			firstTurn=false;
		}
		if(rectanglePoliceCar.intersects(rectangleTurn2)){ 	
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
			}
			if(policeCarDirectionBefore=="up"){
				this.policecar.turnPoliceCar(timeDiff,"up","left"); 
				finishTurn=false; 
				policeCarDirection="left";
			}
			if(policeCarDirectionBefore=="right"){
				this.policecar.turnPoliceCar(timeDiff,"right","down"); 
				finishTurn=false; 
				policeCarDirection="down";
			}
			firstTurn=false;
		}
			
		if(rectanglePoliceCar.intersects(rectangleTurn3)){ 
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
			}
			if(policeCarDirectionBefore=="down"){
				this.policecar.turnPoliceCar(timeDiff,"down","right"); 
				finishTurn=false;
				policeCarDirection="right";
			}
			if(policeCarDirectionBefore=="left"){
				this.policecar.turnPoliceCar(timeDiff,"left","up"); 
				finishTurn=false;
				policeCarDirection="up";
			}
			firstTurn=false;
		}
		if(rectanglePoliceCar.intersects(rectangleTurn4)){
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
			}
			if(policeCarDirectionBefore=="right"){
				this.policecar.turnPoliceCar(timeDiff,"right","up"); 
				finishTurn=false;
				policeCarDirection="up";
			}
			if(policeCarDirectionBefore=="down"){
				this.policecar.turnPoliceCar(timeDiff,"down","left"); 
				finishTurn=false;
				policeCarDirection="left";
			}
			firstTurn=false;
			}
		
		if(rectanglePoliceCar.intersects(rectangleCrossRoad1)||rectanglePoliceCar.intersects(rectangleCrossRoad2)||rectanglePoliceCar.intersects(rectangleCrossRoad3)||rectanglePoliceCar.intersects(rectangleCrossRoad4)){
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
				
				do{
					var turnRandom=Math.floor(Math.random()*4);
					if(turnRandom==0){
						turnDirection="left";
					}else if(turnRandom==1){
						turnDirection="right";
					}else if(turnRandom==2){

						turnDirection="up";
					}else{
						turnDirection="down";
					}
					//trace(turnRandom);
				}while((policeCarDirectionBefore=="left"&&turnDirection=="right")||(policeCarDirectionBefore=="up"&&turnDirection=="down")||(policeCarDirectionBefore=="down"&&turnDirection=="up")||(policeCarDirectionBefore=="right"&&turnDirection=="left"));
			}
			
			this.policecar.turnPoliceCar(timeDiff,policeCarDirectionBefore,turnDirection); 
			finishTurn=false;
			policeCarDirection=turnDirection;

			firstTurn=false;
			
		}
		
		if(rectanglePoliceCar.intersects(rectangleTCross1)||rectanglePoliceCar.intersects(rectangleTCross2)){
			
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
				
				do{
					var turnRandom1=Math.floor(Math.random()*3);
					if(turnRandom1==0){
						turnDirection="left";
					}else if(turnRandom1==1){
						turnDirection="right";
					}else {
						turnDirection="down";
					}
					//trace(turnRandom);
				}while((policeCarDirectionBefore=="left"&&turnDirection=="right")||(policeCarDirectionBefore=="up"&&turnDirection=="down")||(policeCarDirectionBefore=="right"&&turnDirection=="left"));
			}
			
			this.policecar.turnPoliceCar(timeDiff,policeCarDirectionBefore,turnDirection); 
			finishTurn=false;
			policeCarDirection=turnDirection;
			firstTurn=false;
			
		}
		
		if(rectanglePoliceCar.intersects(rectangleTCross3)||rectanglePoliceCar.intersects(rectangleTCross5)){
			
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
				
				do{
					var turnRandom4=Math.floor(Math.random()*3);
					if(turnRandom4==0){
						turnDirection="up";
					}else if(turnRandom4==1){
						turnDirection="right";
					}else {
						turnDirection="down";
					}
					//trace(turnRandom);
				}while((policeCarDirectionBefore=="left"&&turnDirection=="right")||(policeCarDirectionBefore=="up"&&turnDirection=="down")||(policeCarDirectionBefore=="down"&&turnDirection=="up"));
			}
			
			this.policecar.turnPoliceCar(timeDiff,policeCarDirectionBefore,turnDirection); 
			finishTurn=false;
			policeCarDirection=turnDirection;
			firstTurn=false;
			
		}
		
		if(rectanglePoliceCar.intersects(rectangleTCross4)||rectanglePoliceCar.intersects(rectangleTCross6)){
			
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
				
				do{
					var turnRandom2=Math.floor(Math.random()*3);
					if(turnRandom2==0){
						turnDirection="up";
					}else if(turnRandom2==1){
						turnDirection="left";
					}else {
						turnDirection="down";
					}
					//trace(turnDirection);
				}while((policeCarDirectionBefore=="right"&&turnDirection=="left")||(policeCarDirectionBefore=="up"&&turnDirection=="down")||(policeCarDirectionBefore=="down"&&turnDirection=="up"));
			}
			this.policecar.turnPoliceCar(timeDiff,policeCarDirectionBefore,turnDirection); 
			finishTurn=false;
			policeCarDirection=turnDirection;
			firstTurn=false;
			
		}

			
			
		if(rectanglePoliceCar.intersects(rectangleTCross7)||rectanglePoliceCar.intersects(rectangleTCross8)){
			
			if(firstTurn==true){
				policeCarDirectionBefore=policeCarDirection;
				
				do{
					var turnRandom3=Math.floor(Math.random()*3);
					if(turnRandom3==0){
						turnDirection="up";
					}else if(turnRandom3==1){
						turnDirection="left";
					}else {
						turnDirection="right";
					}
					//trace(turnRandom);
				}while((policeCarDirectionBefore=="right"&&turnDirection=="left")||(policeCarDirectionBefore=="left"&&turnDirection=="right")||(policeCarDirectionBefore=="down"&&turnDirection=="up"));
			}
			
			
			this.policecar.turnPoliceCar(timeDiff,policeCarDirectionBefore,turnDirection); 
			finishTurn=false;
			policeCarDirection=turnDirection;
			firstTurn=false;
			
		}
			
		}
	public function policeCarMovingToward(timeDiff:Number){
			
			if(this.policecar.x<0||this.policecar.x>2280||this.policecar.y<0||this.policecar.y>2277){
				this.policecar.x=876.80;
				this.policecar.y=2218.10;
				policeCarDirection="right";
				finishTurn=true;
			}
			
			if(finishTurn==true&&!beenCaught){

				this.policecar.policeCarMove(timeDiff,policeCarDirection);
			
				firstTurn=true;
			}
		}
		public function pickUpPackge(){
			if(this.playercar.hitTestObject(documentObject)){
				score++;
				this.removeChild(documentObject);
				placeDocument();
			}
		}
			
	
		public function policeCarAnimation(timeDiff:Number){
			finishTurn=true;
			collisionPoliceCar(timeDiff);
			policeCarMovingToward(timeDiff);
		}
		public function getScore(){
			return this.score;
		}
		
		public function checkCatchUp():Boolean{
			var policeCarVisualRect:Rectangle=new Rectangle(this.policecar.x-policeCarVision/2,this.policecar.y-policeCarVision/2,150,150);
			var playerCarRect:Rectangle = new Rectangle(this.playercar.x-carSize/2, this.playercar.y-carSize/2, carSize, carSize);
			if(policeCarVisualRect.intersects(playerCarRect)){
				
				beenCaught=true;
				return true;
			}else{
				return false;
			}
			
		}
		public function chooseTransportation(transportation:String){
			if(transportation=="speedCar"){
				playercar.gotoAndStop(1);
				this.speed=.3;
				//trace(this.speedCar.x);
				}
				if(transportation=="slowCar"){
					playercar.gotoAndStop(2);
					this.speed=.25;
				//trace(this.speedCar.x);
				}
				if(transportation=="bicycle"){
					playercar.gotoAndStop(3);
					this.speed=.2;
				//trace(this.speedCar.x);
				}
			
		}
		
		public function playPoliceSound():Boolean{
			
			if (Point.distance(new Point(this.playercar.x,this.playercar.x), new Point(this.policecar.x, this.policecar.x)) < policeCarVoice) {
				return true;
				
			}else{
				return false;
			}
			
		}
		
		
	}
	
}
