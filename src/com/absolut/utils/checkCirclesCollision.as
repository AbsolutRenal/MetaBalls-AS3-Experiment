package com.absolut.utils{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function checkCirclesCollision(circle1:Sprite, circle2:Sprite):Boolean{
		return Point.distance(new Point(circle1.x, circle1.y), new Point(circle2.x, circle2.y)) <= (circle1.width + circle2.width) * .5;
	}
}
