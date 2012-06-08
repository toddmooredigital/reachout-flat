namespace "RO.UI", (exports) ->
	class RO.UI.Blockquote extends Spine.Events
		elements: ($ "blockquote")
		constructor: ->
			@addQuotes ($ element) for element in @elements

		addQuotes: (el) ->
			el.css("position", "relative")
			el.append("<em class='ui-generic-blockquote-top' style='position:absolute; top:0px; left:-25px;'>")
			el.append("<em class='ui-generic-blockquote-bottom' style='position:absolute; bottom:0px; right:-25px;'>")


namespace "RO.MobileUI", (exports) ->
	class RO.MobileUI.Blockquote extends RO.UI.Blockquote
		constructor: ->
			super		