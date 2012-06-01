namespace "RO.Modules", (exports) ->
	class RO.Modules.Signup extends RO.Modules.LoginLogout
			tmp: '''			
			<div class="module ui-generic login">
				<div class="left">
					<h3 class="module title heading dotted">
						Signup
					</h3>
					{{{form}}}
				</div>
			</div>
			'''	

			class: "modal"
			id: "signupModal"

			constructor: ->
				@url = RO.Config[window.ROENV].signupURL
				@template = Handlebars.compile(@tmp)
				@getLoginForm()
				@triggerArray = ["[data-module=signup]"]
				@wrapper = ($ "<div class='"+@class+"' id='"+@id+"' style='width:981px; display: none;'>")

