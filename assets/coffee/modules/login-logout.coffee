namespace "RO.Modules", (exports) ->
	class RO.Modules.LoginLogout extends Spine.Events
		
		tmp: '''			
			<div class="module ui-generic login">
				<div class="left">
					<h3 class="module heading dotted">Sign In</h3>
					<form data-module="login:form" data-event-type="submit" data-event-handler="submit">
						<div class="content">
							<div class="field">
								<label for="email">Email Address</label>
								<input type="text" name="email" />
							</div>
							<div class="field">
								<label for="password">Password</label>
								<input type="password" name="password" />
							</div>
						</div>
						<br style="clear:both;" />
						<button class="btn orange">Submit</button>
					</form>
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
			@template = Handlebars.compile(@tmp)
			@insertToDOM(@template)
			@overlay = $("#"+@id).overlay(
				onClose: @close
				left: "center"
				top: "center"
				mask: 
					background: "rgb(0,0,0)"
			)

			@overlayApi = $(@overlay).data("overlay")
			@assignTriggers(["login", "login:form"])
			

		show: ->
			@overlayApi.load()
			

		close: (e) =>
			false

		assignTriggers: (targets) ->
			#handles the assignment of different elements and types
			for target in targets
				@triggers = ($ '[data-module="'+target+'"]')
				for trigger in @triggers
					trigger = ($ trigger)
					if trigger.attr("data-event-type")
						
						trigger[trigger.attr("data-event-type")]((e) =>
								@[trigger.attr("data-event-handler")](e)
							)
					else
						trigger.click((e) =>
							e.preventDefault()
							@show()
						)

		
		submit: (formElement) ->
			formElement.preventDefault()
			alert("Ajax request")

		insertToDOM: (el) ->
			@rendered = el()
			@wrapper = ($ "<div class='"+@class+"' id='"+@id+"' style='width:981px; display: none;'>")
			@rendered = ($ @wrapper).html(@rendered)

			#Make this method a registry so that all UI elements are updated
			($ "body").append(@rendered)
			RO.Main.ReachOut.trigger "dom:change"	





			







