#=require ./application.coffee
#=require ../js/mobile/TweenLite.min.js
#=require ../js/mobile/CSSPlugin.min.js
#=require ../js/mobile/EasePack.min.js

namespace "RO.Main", (exports) ->
	class RO.Main.ReachOutMobile extends RO.Main.ReachOut
		constructor: ->  
			@UI = {}
			@setGlobalHost()

			@activateUI(key, uiObject) for key, uiObject of RO.MobileUI   

			#initiate slideshow
			new RO.Modules.Slideshow