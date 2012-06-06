namespace "RO.UI", (exports) ->
	class RO.UI.HomepageHeadings extends Spine.Model
		@extend(Spine.Events)
		constructor: ->
			@el = ($ ".module.list.ui-generic-list-icons .heading > h3")
			new RO.UI.HomepageHeadingHandler(($ element)) for element in @el

	class RO.UI.HomepageHeadingHandler extends Spine.Events
		
		constructor: (el) ->
			RO.UI.HomepageHeadingHandler.bind "change:all", =>
				if typeof @el != "undefined"
					@el.height(62)
			@el = el
			if el
				@height = el.height()
				if @height > 60
					setTimeout( =>
						RO.UI.HomepageHeadingHandler.trigger "change:all"
					, 10)
					




			
