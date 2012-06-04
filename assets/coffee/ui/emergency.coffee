namespace "RO.UI", (exports) ->
	class RO.UI.Emergency extends Spine.Events
		elements: ($ "[data-ui=emergency]")
		constructor: ->
			console.log @elements
			@checkHeight ($ element) for element in @elements

		checkHeight: (el) ->
			left_height = el.find(".left").height()
			right_height = el.find(".right").height()
			obj = new RO.UI.EmergencyHeight(
					left_height : left_height
					right_height : right_height
				)

			if !obj.matchingHeights
				padding = obj.calculatePaddingDifference()
				el.find(".right .inner").css({"paddingTop" : padding + "px", "paddingBottom" : padding + "px" })

	class RO.UI.EmergencyHeight extends Spine.Model
		@extend(Spine.Events)

		constructor: (obj) ->
			@offset = 20
			@matchingHeights = true
			@leftHeight = obj.left_height
			@rightHeight = obj.right_height

			if @leftHeight != @rightHeight
				@matchingHeights = false

		calculatePaddingDifference: ->
			@difference = @leftHeight - @rightHeight
			@padding = @difference / 2 + @offset
			return @padding





