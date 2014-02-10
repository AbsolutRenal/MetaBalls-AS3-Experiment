package com.absolut.utils{
	import com.absolut.metaballs.Metaball;

	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateIntersectionsFromMetaballCenter(ball:Metaball, angleRad:Number):Array{
		return [new Point(ball.x + Math.cos(angleRad) * ball.radius, ball.y + Math.sin(angleRad) * ball.radius), new Point(ball.x + Math.cos((angleRad - degToRad(180))) * ball.radius, ball.y + Math.sin((angleRad - degToRad(180))) * ball.radius)];
	}
}
