package com.absolut.utils{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateIntersectionsFromCircleCenter(circle:Sprite, angleRad:Number):Array{
		return [new Point(circle.x + Math.cos(angleRad) * (circle.width * .5), circle.y + Math.sin(angleRad) * (circle.width * .5)), new Point(circle.x + Math.cos((angleRad - degToRad(180))) * (circle.width * .5), circle.y + Math.sin((angleRad - degToRad(180))) * (circle.width * .5))];
	}
}
