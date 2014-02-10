package com.absolut.utils{
	import com.absolut.metaballs.Metaball;

	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateMetaballIntersections(ball1:Metaball, ball2:Metaball):Vector.<Point>{
		return calculateCirclesIntersectionsFromPointRadius(ball1.position, ball1.radius, ball2.position, ball2.radius);
	}
}
