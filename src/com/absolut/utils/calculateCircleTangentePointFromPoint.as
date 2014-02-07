package com.absolut.utils{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateCircleTangentePointFromPoint(circle:Sprite, O:Point):Vector.<Point>{
		var p1:Point = new Point(circle.x, circle.y);
		var p0:Point = new Point(O.x + (p1.x - O.x) * .5, O.y + (p1.y - O.y) * .5);
		var r0:Number = Point.distance(p1, O) * .5;
		var r1:Number = circle.width * .5;
		
		return calculateCirclesIntersectionsFromPointRadius(p0, r0, p1, r1);
	}
}
