namespace "RO.UI", (exports) ->
	class RO.UI.Squeeze extends Spine.Events

		constructor: ->
			@el = ($ "[data-ui-squeeze]")
			RO.Main.ReachOut.bind "dom:change", =>
				@constrain ($ item) for item in @el when ($ item).attr("data-ui-squeeze") == "left"


		constrain: (el) ->
			offset = 20
			nextWidth = el.nextAll(($ "[data-ui-squeeze=right]")).width()
			parentWidth = el.parent().width()

			el.width(parentWidth - nextWidth - offset)
				

