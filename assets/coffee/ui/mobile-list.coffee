namespace "RO.MobileUI", (exports) ->
	class RO.MobileUI.MobileList extends RO.MobileUI.Base
		role: "mobile-list"  
		constructor: ->
			@offset = 55
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
				width = @globalWidth - icon.width() - @offset
				title.width(width)
	
	class RO.MobileUI.CollapsableSet extends RO.MobileUI.Base
		role: "collapsible-set"
		constructor: ->
			super
			@offset = 0
			@target = ".ui-btn-inner"
			if @checkPageForAttr()
				for el in @el
					elements = ($ el).live(@target)
					for element in elements
						element = $(element)
						@updateTitleWidth(element)
						@registerForUpdateUponResize(element, {}, @updateTitleWidth)

		updateTitleWidth: (element) =>
			width = @globalWidth - @offset
			element.width(width)


	class RO.MobileUI.PagingListView extends RO.MobileUI.Base
		role: "paging-list-view"
		@backTPL: '''
			<a id="#back" data-role="button" data-theme="white" data-icon="blue-left-arrow" data-iconpos="right" data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span" class="ui-btn ui-shadow ui-btn-corner-all ui-btn-icon-left ui-btn-up-orange back">
				<span class="ui-btn-inner ui-btn-corner-all">
					<span class="ui-btn-text">{{#if title}}{{title}}{{/if}}</span>
					<span class="ui-icon ui-icon-white-right-arrow ui-icon-shadow">&nbsp;</span>
				</span>
			</a>
		'''
		@setCurrentObj: (currentObj) ->
			@current = currentObj

		@backButtonClick: (e) ->
			@current.back(e)


		constructor: ->
			super
			if @checkPageForAttr()
				console.log "test"
				@createTarget()
				@assignOpenEvent()
				RO.MobileUI.PagingListView.generateBack(@target)
				@parseTree()

		@generateBack: (target, title="Browse Reach Out") ->

			@backTemplate = Handlebars.compile(@backTPL)
			
			if @back
				@back.remove()
			@back = ($ @backTemplate({
					title : title
				}))
			@back.click((e)->
				RO.MobileUI.PagingListView.backButtonClick(e)
			)
			target.prepend(@back)

		createTarget: ->
			prev = @el.prev()
			id = @el.attr("data-target-id") || "menu"
			@el.remove()
			if ($ "#"+id).length < 1
				css = 
					"position" : "relative"
					"overflow" : "hidden"
					"width" : "100%"
				@target = ($ prev).after(($ "<div id='"+id+"'>")).css(css)
				
			else
				@target = ($ "#"+id)
				


		parseTree: ->
			for element in @el
				new RO.MobileUI.TreeNode(($ element).children(), 0, undefined, @target) 

		assignOpenEvent: ->
			ref = @el.attr("data-open-target") || "browse"
			el = ($ "#"+ ref)
			console.log el
			el.click((e)=>
				console.log "test"
				if @target.hasClass("ui-browse-open")
					@target.css("display", "none")
					el.find(".ui-icon").removeClass("ui-icon-blue-down-arrow")
					el.find(".ui-icon").addClass("ui-icon-blue-left-arrow")
					@target.removeClass("ui-browse-open")
				else
					@target.css("display", "block")
					el.find(".ui-icon").addClass("ui-icon-blue-down-arrow")
					el.find(".ui-icon").removeClass("ui-icon-blue-left-arrow")
					@target.addClass("ui-browse-open")
			)	

	class RO.MobileUI.TreeNode extends Spine.Controller
		_css: 
			"position" : "absolute"
			"top" : "52px"
			"left": "100%"
			"width" : "100%"
			"list-style-type": "none"
			"padding" : "0px"
			"background" : "white"
			"margin" : "0"
			"z-index" : 10

		_node: '''
		 	<li class="ui-list-{{level}} ui-list-item" data-child="{{index}}" data-title="{{title}}">
		 		<a href="#"class="ui-btn ui-btn-icon-right {{#if theme}}ui-btn-{{theme}}{{/if}}">
		 			<span class="ui-btn-inner">
		 				<span class="ui-btn-text">
		 				{{#each body}}
		 					{{{this}}}
		 				{{/each}}
		 				</span>
		 				{{#if icon.length}}<span class="ui-icon ui-icon-{{icon.class}} ui-icon-shadow">&nbsp;</span>{{/if}}
		 			</span>
		 		</a>
		 	</li>
		 '''
		_parent: '''
		 	<ul class="module ui-paging-list">
		 		{{#each nodes}}
		 			{{{this}}}
		 		{{/each}}
		 	</ul>
		 '''
		events: 
		 	"click .ui-list-item" : "clicked"
		 	"swipeleft .ui-list-item" : "clicked"
		constructor: (nodes, level, parent=undefined, target=undefined) ->
			super
			if typeof nodes != "undefined"

		 		@nodes = nodes
		 		@nodeTMPL 	= Handlebars.compile(@_node)
		 		@parentTMPL	= Handlebars.compile(@_parent)
		 		@level = level
		 		@array = []
		 		@children = []
		 		@width = undefined
		 		@left = undefined
		 		@_target = target
		 		

		 		if parent
		 			@parentObject = parent


		 		@parseNodes()
		 		@parseContainer()
		 		@render()

		clicked: (ev) =>
			child = ($ ev.currentTarget).attr("data-child")
			c = ($ @children[child])
			

			#if we are at the bottom of the tree, stop
			if c.children("li").length > 0
				title = ($ ev.currentTarget).attr("data-title")
				RO.MobileUI.PagingListView.generateBack(@_target, title)
				@title = title

				new RO.MobileUI.TreeNode(($ c).children(), @level+1, @, @_target) 

		render: ->
			($ @el).html(@parsedContainer)
			@_target.append(@el)

			($ @_target).height(($ @parsedContainer).height() + 56)
			

		parseNodes: ->
			index = 0
			for node in @nodes
				content = @convertContent(node) 
				obj =
					level : @level
					body  : content.body
					index: index
					title : content.title
					icon: 
						length : ($ node).children("ul").length
						class : ($ node).parent().attr("data-icon") || "blue-left-arrow"
					theme : ($ node).parent().attr("data-theme") || false
				template = @nodeTMPL(obj)
				@array.push template
				@children.push content.child
				index++
		back: (e) ->
			if @parentObject
				if @parentObject.parentObject
					title =	@parentObject.parentObject.title
				else 
					title = "Browse Reach Out"

				RO.MobileUI.PagingListView.generateBack(@_target, title)
				


				($ @parentObject.el).css("display","block")
				cb = =>
					window.location.hash = "#back"
					($ @el).css("display","none")
				TweenLite.to(@parsedContainer, .8, { css:{ left: "100%" }, onComplete: cb, ease:Power2.easeOut} )
				

				TweenLite.to(@parentObject.parsedContainer, .8, { css:{ left: 0 }, ease:Power2.easeOut} )
				RO.MobileUI.PagingListView.setCurrentObj(@parentObject)	
				
			else
				@_target.css("display", "none")	
				@_target.prev().find(".ui-icon").removeClass("ui-icon-blue-down-arrow")
				@_target.prev().find(".ui-icon").addClass("ui-icon-blue-left-arrow")
				@_target.removeClass("ui-browse-open")

		parseContainer: ->
			template = @parentTMPL(
					nodes: @array
				)
			height = RO.MobileUI.PagingListView.back.height() || 32
			@_css.top = height + 20 + "px" 
			console.log @_css.top
			@parsedContainer = ($ template).css(@_css)
			target = @parsedContainer
			if @parentObject
				cb = =>
					window.location.hash = "#back"
					($ @parentObject.el).css("display","none")
				TweenLite.to(@parentObject.parsedContainer, .8, { css:{ left: "-100%" }, onComplete: cb, ease:Power2.easeOut } )
			TweenLite.to(@parsedContainer, .8, { css:{ left: 0 }, ease:Power2.easeOut} )
			
			RO.MobileUI.PagingListView.setCurrentObj(@)				

		convertContent: (nContent) ->
			
			n = ($ ($ nContent).html())
			elements = []
			child = {}
			title = ""
			t ='''
				<span {{#if class}}class="{{class}}"{{/if}}>{{text}}</span>
			'''
			tpl = Handlebars.compile(t)

			count = 0
			ge = (el) =>
					e = ($ el)
					_t = tpl(
						class: e.attr("class")
						text: e.text()
						)
					if count == 0
						title = e.text()

					count++
					elements.push _t

			gc = (el) =>
				child = ($ el)
				
			ge(el) for el in n.filter(->
					return !(this.nodeName == "UL")
				)
			gc(el) for el in n.filter(->
						return this.nodeName == "UL"
					)

			return {
				body 	: 	elements
				child 	:	child
				title : title
			}


#
#  		 		if @node.children()
#		 			new RO.MobileUI.TreeNode($( li), level+1) for li in node.children("ul").children("li")
#		 		@templateTheNode()			
#
#
#