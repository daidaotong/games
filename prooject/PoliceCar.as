package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	
	public class PoliceCar extends MovieClip {
		
		static const speed:Number = .3;
		static const turnSpeed:Number = .4;
		
		public function PoliceCar() {
			// constructor code
		}
		
		
		public function turnPoliceCar(timeDiff:Number,directionFrom:String,directionTo:String){
			if(directionFrom=="right"&&directionTo=="up"){
				
				this.x+=speed*timeDiff;
				this.y-=speed*timeDiff;
				this.rotation -= turnSpeed*timeDiff;
				if(this.rotation<-90){
					this.rotation=-90;
				}
			}
			
			if(directionFrom=="right"&&directionTo=="down"){
				
				this.x+=speed*timeDiff;
				this.y+=speed*timeDiff;
				this.rotation += turnSpeed*timeDiff;
				if(this.rotation>90){
					this.rotation=90;
				}
			}
			
			if(directionFrom=="right"&&directionTo=="right"){
				
				this.x+=speed*timeDiff;
				/*this.y-=speed*timeDiff;
				this.rotation -= turnSpeed*timeDiff;
				if(this.rotation<-90){
					this.rotation=-90;
				}*/
			}
			
			
			
			if(directionFrom=="up"&&directionTo=="left"){
				this.x-=speed*timeDiff;
				this.y-=speed*timeDiff;
				this.rotation -= turnSpeed*timeDiff;
				if(this.rotation>0){
					this.rotation=180;
				}
				
			}
			if(directionFrom=="up"&&directionTo=="right"){
				this.x+=speed*timeDiff;
				this.y-=speed*timeDiff;
				this.rotation += turnSpeed*timeDiff;
				if(this.rotation>0){
					this.rotation=0;
				}
				
			}
			if(directionFrom=="up"&&directionTo=="up"){
				this.y-=speed*timeDiff;
				
			}
		
			if(directionFrom=="left"&&directionTo=="down"){
				this.x-=speed*timeDiff;
				this.y+=speed*timeDiff;
				this.rotation -= turnSpeed*timeDiff;
				if(this.rotation<90){
					this.rotation=90;
				}
				
			}
			/*action*/if(directionFrom=="left"&&directionTo=="up"){
				this.x-=speed*timeDiff;
				this.y-=speed*timeDiff;
				this.rotation+=turnSpeed*timeDiff;
				//trace(this.rotation);
				if(this.rotation>-90){
					this.rotation=-90;
				}
				
			}
			if(directionFrom=="left"&&directionTo=="left"){
				this.x-=speed*timeDiff;
			}
			
			if(directionFrom=="down"&&directionTo=="right"){
				this.x+=speed*timeDiff;
				this.y+=speed*timeDiff;
				this.rotation -= turnSpeed*timeDiff;
				if(this.rotation<0){
					this.rotation=0;
				}
				
			}
			
			if(directionFrom=="down"&&directionTo=="left"){
				this.x-=speed*timeDiff;
				this.y+=speed*timeDiff;
				this.rotation += turnSpeed*timeDiff;
				if(this.rotation<0){
					this.rotation=180;
				}
				
			}
			
			if(directionFrom=="down"&&directionTo=="down"){
				this.y-=speed*timeDiff;
			}
			
		}
		public function policeCarMove(timeDiff:Number,moveDirection:String){
			
			if(moveDirection=="right"){
				this.x+=speed*timeDiff;
				if(this.y>0&&this.y<120){
					this.y=60;
				}
			
				if(this.y>720&&this.y<840){
					this.y=780;
				}
			
				if(this.y>1440&&this.y<1560){
					this.y=1500;
				}
				if(this.y>2158&&this.y<2278){
					this.y=2218;
				}
			}else if(moveDirection=="left"){
				this.x-=speed*timeDiff;
			
				if(this.y>0&&this.y<120){
					this.y=60;
				}
			
				if(this.y>720&&this.y<840){
					this.y=780;
				}
			
				if(this.y>1440&&this.y<1560){
					this.y=1500;
				}
				if(this.y>2158&&this.y<2278){
					this.y=2218;
				}
			}else if(moveDirection=="up"){
				this.y-=speed*timeDiff;
			
				if(this.x>0&&this.x<120){
					this.x=60;
				}
				if(this.x>720&&this.x<840){
					this.x=780;
				}
				if(this.x>1440&&this.x<1560){
					this.x=1500;
				}
			
				if(this.x>2160.1&&this.x<2280.1){
					this.x=2220.1;
				}
			}else if(moveDirection=="down"){
				this.y+=speed*timeDiff;
			
				if(this.x>0&&this.x<120){
					this.x=60;
				}
				if(this.x>720&&this.x<840){
					this.x=780;
				}
				if(this.x>1440&&this.x<1560){
					this.x=1500;
				}
			
				if(this.x>2160.1&&this.x<2280.1){
					this.x=2220.1;
				}

			}
		}
		
	}
	
}
