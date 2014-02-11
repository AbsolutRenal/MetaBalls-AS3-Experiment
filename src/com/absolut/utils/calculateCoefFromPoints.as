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
	public function calculateCoefFromPoints(p1:Point, p2:Point):Number{
		var coef:Number;
		if(p1.x != p2.x && p1.y != p2.y)
			coef = (p2.y - p1.y)/(p2.x - p1.x);
		else if(p1.x == p2.x)
			coef = 999999999999999;
		else
			coef = 0;
			
		return coef;
	}
}
