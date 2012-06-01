namespace "RO.Modules", (exports) ->
	class RO.Modules.LoginLogout extends Spine.Model
		@extend(Spine.Events)

		tmp: '''			
			<div class="module ui-generic login">
				<div class="left">
					<h3 class="module title heading dotted">
						Login
					</h3>
					{{{form}}}
				</div>
				<div class="right">
					<h3>Not Registered</h3>
					<div class="module ui-generic break">
						<em>No Worries</em> 
					</div>
					<a class="btn orange">Sign Up</a>
				</div>
			</div>
		'''
		

		class: "modal"
		id: "loginModal"

		constructor: ->

			@url = RO.Config[window.ROENV].loginURL
			@template = Handlebars.compile(@tmp)
			@getLoginForm()
			@triggerArray = ["[data-module=login]", ".modal form#mainform"]
			@wrapper = ($ "<div class='"+@class+"' id='"+@id+"' style='width:981px; display: none;'>")

		handleAjaxCallback: ->

			@overlay = $("#"+@id).overlay(
				onClose: @close
				left: "center"
				top: "center"
				mask: 
					background: "rgb(0,0,0)"
			)

			@overlayApi = $(@overlay).data("overlay")
			@assignTriggers(@triggerArray)
			@.trigger "rendered"

		show: ->
			@overlayApi.load()
			
			

		close: (e) =>
			false

		assignTriggers: (targets) ->
			#handles the assignment of different elements and types
			for target in targets
				@triggers = ($ target)
				for trigger in @triggers
					trigger = ($ trigger)
					if target == "form#mainform"
						trigger["submit"]((e) =>
								@submit(e)
							)
					else
						trigger.click((e) =>
							e.preventDefault()
							@show()
						)

		
		submit: (e) ->
			e.preventDefault()
			data = ($ e.currentTarget).serialize()
			jQuery.ajax
				"url" 	: @url
				"type" 	: "POST"
				"data" 	: data
				"success" : (data, res) ->
					console.log data, res


		getLoginForm: ->
			jQuery.ajax
				"url"  : @url
				"type" : "GET"
				success : (data, res) =>
					## Sanitize this form
					template = ($ data)
					template.each((e) ->
							if ($ @).attr("id") == "mainform"
								template = ($ @)
								template = ($ "<div>").html(template)
						)

					template.find("script").remove()
					template.find("link").remove()
					template.find("h1").remove()
					template.find("header").remove()
					template.find("footer").remove()
					template.find("#main").attr("id", "")
					template.find("form").attr("onsubmit", "")
					template.find("input[type=submit]").attr("onclick", "").addClass("btn orange")
					template.find(".scfIntroBorder").remove()
					template.find(".scfRequired").remove()
					template.find("[onkeypress]").attr("onkeypress", "")


					@insertToDOM(@template({ form: template.html() }))
					@handleAjaxCallback()

		insertToDOM: (el) ->
			@rendered = el
			@rendered = ($ @wrapper).html(@rendered)

			#Make this method a registry so that all UI elements are updated
			($ "body").append(@rendered)
			RO.Main.ReachOut.trigger "dom:change"	





			







