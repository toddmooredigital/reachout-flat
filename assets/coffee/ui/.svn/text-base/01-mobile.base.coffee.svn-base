namespace "RO.MobileUI", (exports) ->
	class RO.MobileUI.Base extends Spine.Events
		attr: "data-role"
		globalWidth: ($ window).width()
		constructor: ->
			

		checkPageForAttr: ->
			@el = ($ "["+@attr+"="+@role+"]")
			if @el.length > 0
				return true

		registerForUpdateUponResize: (el1, el2 ,fn) ->
			($ window).resize( =>
				@globalWidth = ($ window).width()
				fn(el1, el2)
			)


			

