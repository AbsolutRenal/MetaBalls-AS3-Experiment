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
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function calculateCirclesIntersections(circle1:Sprite, circle2:Sprite):Vector.<Point>{
		return calculateCirclesIntersectionsFromPointRadius(new Point(circle1.x, circle1.y), circle1.width * .5, new Point(circle2.x, circle2.y), circle2.width * .5);
	}
}
