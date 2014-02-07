package com.absolut.utils{
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function middleFromPoints(p1:Point, p2:Point):Point{
		return new Point((p1.x + p2.x) * .5, (p1.y + p2.y) * .5);
	}
}
