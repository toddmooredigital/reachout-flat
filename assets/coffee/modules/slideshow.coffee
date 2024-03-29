namespace "RO.Modules", (exports) ->
	class RO.Modules.Slideshow extends Spine.Events
		tmp: '''
		      {{title}}
              <b>{{subsection}}</b>
              <span>{{description}} <a href="{{link}}">Learn more</a>
              </span>
		'''
		constructor: ->

			@parentWidth = ($ "[data-slideshow=\"parent\"]").width()

			if typeof @parentWidth == "number"
				@changeSlideShowPosition()
				($ window).resize( =>
					@parentWidth = ($ "[data-slideshow=\"parent\"]").width()
					@changeSlideShowPosition()
				)

			@template = Handlebars.compile(@tmp)
			($ @el).cycle(
					fx : "fade"  
					before: @before
						
				)

		heading: ($ "[data-slideshow-heading]")

		el: ($ "[data-slideshow=cycle]")

		changeSlideShowPosition: ->
			@slideshow = ($ "[data-slideshow=\"cycle\"]")
			@leftoverlay = ($ "[data-slideshow=\"left\"] .slideshow-overlay-tl")
			@slideshow.css("left", @parentWidth - 250)
			@leftoverlay.css("right", - (@parentWidth + 575))


		before: (currentEl, nextSlide, options) =>
			el = ($ nextSlide)
			data = 	
				title 		: el.attr("data-slideshow-title")
				subsection 	: el.attr("data-slideshow-subsection")
				description : el.attr("data-slideshow-description")
				link 		: el.attr("data-slideshow-link")

			
			@heading.html(@template(data))





