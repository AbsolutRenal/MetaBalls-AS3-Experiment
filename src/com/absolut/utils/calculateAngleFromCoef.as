package com.absolut.utils{
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	
	/**
	 * @param perpendicularPoints : indicates whether the specified points comes from the line with coef or from perpendicular line from coef
	 */
	public function calculateAngleFromCoef(coef:Number, p1:Point, p2:Point, perpendicularPoints:Boolean = false):Number{
		var angleDeg:Number = radToDeg(Math.atan(coef));
		
		if(perpendicularPoints){
			if(coef < 0)
				angleDeg += 180;
			if(p1.x > p2.x)
				angleDeg = angleDeg - 180;
		} else {
			if(coef < 0 && p2.y > p1.y)
				angleDeg += 180;
			else if(coef > 0 && p1.y > p2.y)
				angleDeg -= 180;
				
		}
		
		return angleDeg;
	}
}
