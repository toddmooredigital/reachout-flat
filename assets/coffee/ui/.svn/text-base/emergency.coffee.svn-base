namespace "RO.UI", (exports) ->
	class RO.UI.Emergency extends Spine.Events
		elements: ($ "[data-ui=emergency]")
		constructor: ->
			for element in @elements
				@checkHeight ($ element)

		checkHeight: (el) ->	
			left_height = el.find(".left").height()
			right_height = el.find(".right").height()
			
			obj = new RO.UI.EmergencyHeight({
					left_height : left_height
					right_height : right_height
					el : el
				})


			obj.calculatePaddingDifference()

	class RO.UI.EmergencyHeight extends Spine.Model
		@extend(Spine.Events)

		constructor: (obj = {}) ->
			@offset = 20
			@matchingHeights = true
			@leftHeight = obj.left_height
			@rightHeight = obj.right_height
			@el = obj.el

			if @leftHeight != @rightHeight
				@matchingHeights = false


		calculatePaddingDifference: ->
			@difference = @leftHeight - @rightHeight
			@padding = @difference / 2 + @offset
			setTimeout( =>
				@el.find(".right .inner").css({"paddingTop" : @padding + "px", "paddingBottom" : @padding + "px" })
			, 10)
			
			





