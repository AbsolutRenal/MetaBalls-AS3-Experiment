package com.absolut.utils{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * @author AbsolutRenal
	 */
	public function drawPoint(container:Sprite, p:Point, radius:int, color:uint):void{
		container.graphics.beginFill(color);
		container.graphics.drawCircle(p.x, p.y, radius);
		container.graphics.endFill();
	}
}
