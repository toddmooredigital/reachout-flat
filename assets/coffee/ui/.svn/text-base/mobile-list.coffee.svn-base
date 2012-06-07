namespace "RO.MobileUI", (exports) ->
	class RO.MobileUI.MobileList extends RO.MobileUI.Base
		role: "mobile-list"  
		constructor: ->
			if @checkPageForAttr()
				for el in @el
					li = ($ el).find("li")
					@getLinks li
					for l in li
						title = ($ ($ l).find(".title"))
						icon = ($ title.prev())
						@updateTitleWidth(title, icon)
						@registerForUpdateUponResize(title, icon, @updateTitleWidth)

		getLinks: (el) ->
			for li in el
				($ li).click( (e) ->
					anchor = ($ e.currentTarget).find("a")
					window.location = ($ anchor).attr("href")
				)

		updateTitleWidth: (title, icon) =>
				width = @globalWidth - icon.width() - 55
				title.width(width)
				





			
			

