package com.absolut.metaballs{
	import com.absolut.datas.Config;
	import com.absolut.utils.calculateAngleFromCoef;
	import com.absolut.utils.calculateCoefFromPoints;
	import com.absolut.utils.calculateIntersectionsFromMetaballCenter;
	import com.absolut.utils.calculateLinesIntersection;
	import com.absolut.utils.calculateMetaballIntersections;
	import com.absolut.utils.calculateMetaballTangentePointFromPoint;
	import com.absolut.utils.degToRad;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author AbsolutRenal
	 */
	public class Metaball extends Sprite{
		private const MIN_RADIUS:int = 40;
		private const RADIUS_RANGE:int = 60;
//		private const MIN_RADIUS:int = 10;
//		private const RADIUS_RANGE:int = 20;
		private const COLOR:int = 0x000000;
		
		
		private var interactions:Vector.<Metaball>;
		private var container:Sprite;
		private var sx:Number;
		private var sy:Number;
		private var isDragging:Boolean = false;
		
		private var _radius:int;
		private var _circle:Sprite;
		
		public function Metaball(){
			init();
			
			if(Config.DEBUG)
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				
			addEventListener(MouseEvent.MOUSE_DOWN, start);
			stage.addEventListener(MouseEvent.MOUSE_UP, stop);
		}

		private function stop(event:MouseEvent):void{
			isDragging = false;
			stopDrag();
		}

		private function start(event:MouseEvent):void{
			isDragging = true;
			startDrag(true, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function getRightID(c1:Sprite, c2:Sprite):int{
			var idx:int = 0;
			if(c2.x < c1.x && c1.y == c2.y)
				idx = 1;
				
			return idx;
		}
		
		private function init():void{
			interactions = new Vector.<Metaball>();
			_radius = MIN_RADIUS + Math.random() * RADIUS_RANGE;
			
			_circle = new Sprite();
			_circle.graphics.beginFill(COLOR);
			_circle.graphics.drawCircle(0, 0, _radius);
			_circle.graphics.endFill();
			addChild(_circle);
			
			container = new Sprite();
			addChild(container);
		}
		
		private function draw(ball:Metaball):void{
			// COEF DIRECTEUR CENTER1-CENTER2
			var centersCoef:Number = calculateCoefFromPoints(position, ball.position);
			var angleCenters:Number = calculateAngleFromCoef(centersCoef, position, ball.position);
			var idx:int = getRightID(this, ball);
			var I1:Point = calculateIntersectionsFromMetaballCenter(this, degToRad(angleCenters))[idx];
			var I2:Point = calculateIntersectionsFromMetaballCenter(ball, degToRad(angleCenters))[1 - idx];

			// COEF DIRECTEUR PERPENDICULAIRE CENTER1-CENTER2 => INTERSECTION1-INTERSECTION2
			var coefPerpendicular:Number = -1/centersCoef;
			
			// ANGLE INTERSECTION1-INTERSECTION2
			var angleDeg:Number = calculateAngleFromCoef(coefPerpendicular, position, ball.position, true);
			var angleRad:Number = degToRad(angleDeg);
			
			var intersection:Array = calculateIntersectionsFromMetaballCenter(this, angleRad);
			var intersect1:Point = intersection[0] as Point;
			var intersect2:Point = intersection[1] as Point;
			intersection = calculateIntersectionsFromMetaballCenter(ball, angleRad);
			var intersect3:Point = intersection[0] as Point;
			var intersect4:Point = intersection[1] as Point;
			// FIRST STEP //
			
			var coef1:Number = calculateCoefFromPoints(intersect1, intersect3);
			var coef2:Number = calculateCoefFromPoints(intersect2, intersect4);
			var tangentesIntersections:Point = calculateLinesIntersection(intersect1, coef1, intersect2, coef2);
			
			// SECOND STEP //
			var circlesIntersect:Vector.<Point>;
//			if(checkCirclesCollisionButNotIncluded(this, ball)){
				circlesIntersect = calculateMetaballIntersections(this, ball);
				var tangentes1:Vector.<Point> = calculateMetaballTangentePointFromPoint(this, tangentesIntersections);
				var tangentes2:Vector.<Point> = calculateMetaballTangentePointFromPoint(ball, tangentesIntersections);
				
				var c1:Point = new Point(this.x, this.y);
				var curveUp1:Number = calculateAngleFromCoef(calculateCoefFromPoints(c1, circlesIntersect[0]), c1, circlesIntersect[0]);
				var curveRef1:Number = calculateAngleFromCoef(calculateCoefFromPoints(c1, I1), c1, I1);
				var angleCurve1:Number = curveRef1 - curveUp1;
//				trace("angleCurve1:", int(angleCurve1), "curveUp1:", int(curveUp1));
				var G1:Point;
				var G2:Point;

				//
				var c2:Point = new Point(ball.x, ball.y);
				var curveUp2:Number = calculateAngleFromCoef(calculateCoefFromPoints(c2, circlesIntersect[0]), c2, circlesIntersect[0]);
				var curveRef2:Number = calculateAngleFromCoef(calculateCoefFromPoints(c2, I2), c2, I2);
				var angleCurve2:Number = curveRef2 - curveUp2;
				var G3:Point;
				var G4:Point;
				
				if(c1.y == c2.y && c2.x < c1.x){
					G1 = new Point(c1.x + Math.cos(degToRad(curveUp1 - angleCurve1 - 180)) * (_radius * .5), c1.y + Math.sin(degToRad(curveUp1 - angleCurve1 - 180)) * _radius);
					G2 = new Point(c1.x + Math.cos(degToRad(curveRef1 + 2 * angleCurve1 - 180)) * _radius, c1.y + Math.sin(degToRad(curveRef1 + 2 * angleCurve1 - 180)) * _radius);
				} else {
					G1 = new Point(c1.x + Math.cos(degToRad(curveUp1 - angleCurve1)) * _radius, c1.y + Math.sin(degToRad(curveUp1 - angleCurve1)) * _radius);
					G2 = new Point(c1.x + Math.cos(degToRad(curveRef1 + 2 * angleCurve1)) * _radius, c1.y + Math.sin(degToRad(curveRef1 + 2 * angleCurve1)) * _radius);
				}
				//
				if(c1.y == c2.y && c2.x > c1.x){
					G3 = new Point(c2.x + Math.cos(degToRad(curveUp2 - angleCurve2 - 180)) * ball.radius, c2.y + Math.sin(degToRad(curveUp2 - angleCurve2 - 180)) * ball.radius);
					G4 = new Point(c2.x + Math.cos(degToRad(curveRef2 + 2 * angleCurve2 - 180)) * ball.radius, c2.y + Math.sin(degToRad(curveRef2 + 2 * angleCurve2 - 180)) * ball.radius);
				} else {
					G3 = new Point(c2.x + Math.cos(degToRad(curveUp2 - angleCurve2)) * ball.radius, c2.y + Math.sin(degToRad(curveUp2 - angleCurve2)) * ball.radius);
					G4 = new Point(c2.x + Math.cos(degToRad(curveRef2 + 2 * angleCurve2)) * ball.radius, c2.y + Math.sin(degToRad(curveRef2 + 2 * angleCurve2)) * ball.radius);
				}
				
				
				var P1:Point, P2:Point, P3:Point, P4:Point;
				
				var dist1:Number = Point.distance(G1, I1);
				var dist2:Number = Point.distance(tangentes1[0], I1);
				var dist3:Number = Point.distance(G3, I2);
				var dist4:Number = Point.distance(tangentes2[0], I2);
				
				if(dist2 >= dist1 && Point.distance(G1, tangentes1[0]) < Point.distance(G2, tangentes1[0])){
					P1 = G1;
					P2 = G2;
				} else {
					P1 = tangentes1[0];
					P2 = tangentes1[1];
				}
				
				
				if(dist3 < dist4 && Point.distance(G3, tangentes2[0]) < Point.distance(G4, tangentes2[0])){
					P3 = G3;
					P4 = G4;
				} else {
					P3 = tangentes2[0];
					P4 = tangentes2[1];
				}
				
				
				var coefTmp1:Number = -1 / calculateCoefFromPoints(position, P1);
				var coefTmp2:Number = -1 / calculateCoefFromPoints(ball.position, P3);
				var tmpIntersectP1:Point;
				
				var coefTmp3:Number = -1 / calculateCoefFromPoints(ball.position, P4);
				var coefTmp4:Number = -1 / calculateCoefFromPoints(position, P2);
				var tmpIntersectP2:Point;
				
				
				tmpIntersectP1 = calculateLinesIntersection(P1, coefTmp1, P3, coefTmp2);
				tmpIntersectP2 = calculateLinesIntersection(P4, coefTmp3, P2, coefTmp4);
				
				
//				trace("DRAW", this.name);
				container.graphics.beginFill(COLOR >> 2);
				container.graphics.moveTo(P1.x - x, P1.y - y);
				container.graphics.curveTo(tmpIntersectP1.x - x, tmpIntersectP1.y - y, P3.x - x, P3.y - y);
				container.graphics.lineTo(P4.x - x, P4.y - y);
				container.graphics.curveTo(tmpIntersectP2.x - x, tmpIntersectP2.y - y, P2.x - x, P2.y - y);
				container.graphics.lineTo(P1.x - x, P1.y - y);
				container.graphics.endFill();
//			}
		}
		
		
		//----------------------------------------------------------------------
		// P R O T E C T E D
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		public function clear():void{
			interactions = new Vector.<Metaball>();
			container.graphics.clear();
//			trace("CLEAR", this.name);
		}
		
		public function isInteractingWith(ball:Metaball):Boolean{
			return interactions.indexOf(ball) != -1;
		}
		
		public function collideWith(ball:Metaball):Boolean{
			var dist:uint = Point.distance(position, ball.position);
			return dist < (_radius + ball.radius) && dist > (Math.abs(_radius - ball.radius));
		}
		
		public function interactWith(ball:Metaball, update:Boolean):void{
//			trace(this.name + ".interactWith(ball:" + ball.name + ", " + update + ")");
			interactions.push(ball);
			
			if(update)
				draw(ball);
		}
		
		public function setSpeed(sx:Number, sy:Number):void{
			this.sx = sx;
			this.sy = sy;
		}
		
		public function update():void{
			if(!Config.DEBUG){
				x += sx;
				y += sy;
				
				if(x > stage.stageWidth || x < 0){
					sx *= -1;
				}
				if(y > stage.stageHeight || y < 0){
					sy *= -1;
				}
			}
		}
		
		
		//----------------------------------------------------------------------
		// G E T T E R  /  S E T T E R
		//----------------------------------------------------------------------
		
		public function get radius():int{
			return _radius;
		}
		
		public function get position():Point{
			return new Point(x, y);
		}
		
		public function get circle():Sprite{
			return _circle;
		}
	}
}
