/**
 *
 * MetaBalls
 *
 * https://github.com/AbsolutRenal
 *
 * Copyright (c) 2012 AbsolutRenal (Renaud Cousin). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
**/

package com.absolut.utils{
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateLinesIntersection(p1:Point, coef1:Number, p2:Point, coef2:Number):Point{
		return new Point((((p2.y - p2.x * coef2) - (p1.y - p1.x * coef1)) / (coef1 - coef2)), (coef1 * (((p2.y - p2.x * coef2) - (p1.y - p1.x * coef1)) / (coef1 - coef2)) + (p1.y - p1.x * coef1)));
	}
}
