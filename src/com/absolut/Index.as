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

package com.absolut{
	import flash.events.Event;
	import com.absolut.metaballs.MetaballManager;
	import com.absolut.metaballs.Metaball;
	import flash.display.Sprite;

	/**
	 * @author AbsolutRenal
	 */
	
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="1280", height="1024")]
	public class Index extends Sprite{
		private const NB_METABALLS:int = 30;
		
		private var metaballsManager:MetaballManager;
		
		public function Index(){
			init();
		}
		
		
		//----------------------------------------------------------------------
		// E V E N T S
		//----------------------------------------------------------------------

		private function onRender(event:Event):void{
			metaballsManager.render();
		}
		
		
		//----------------------------------------------------------------------
		// P R I V A T E
		//----------------------------------------------------------------------
		
		private function init():void{
			metaballsManager = MetaballManager.getInstance();
			
			var b:Metaball;
			for(var i:int = 0; i < NB_METABALLS; i++){
				b = metaballsManager.add();
				b.x = Math.random() * stage.stageWidth;
				b.y = Math.random() * stage.stageHeight;
				b.setSpeed(Math.random() * 3, Math.random() * 3);
				addChild(b);
			}
			
			start();
		}
		
		private function start():void{
			addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		
		//----------------------------------------------------------------------
		// P R O T E C T E D
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// P U B L I C
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		// G E T T E R  /  S E T T E R
		//----------------------------------------------------------------------
		
		
	}
}
