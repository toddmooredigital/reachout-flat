namespace "RO.Modules", (exports) ->
	class RO.Modules.Slideshow extends Spine.Events
		tmp: '''
		      {{title}}
              <b>{{subsection}}</b>
              <span>{{description}} <a href="{{link}}">Learn more</a>
              </span>
		'''
		constructor: ->
			@template = Handlebars.compile(@tmp)
			($ @el).cycle(
					fx : "fade"  
					before: @before
						
				)

		heading: ($ "[data-slideshow-heading]")

		el: ($ "[data-slideshow=cycle]")

		before: (currentEl, nextSlide, options) =>
			el = ($ nextSlide)
			data = 	
				title 		: el.attr("data-slideshow-title")
				subsection 	: el.attr("data-slideshow-subsection")
				description : el.attr("data-slideshow-description")
				link 		: el.attr("data-slideshow-link")

			
			@heading.html(@template(data))





