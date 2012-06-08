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
			@offset = 65
			@target = ".ui-btn-inner"
			if @checkPageForAttr()
				for el in @el
					elements = ($ el).find(@target)
					for element in elements
						element = $(element)
						@updateTitleWidth(element)
						@registerForUpdateUponResize(element, {}, @updateTitleWidth)

		updateTitleWidth: (element) =>
			width = @globalWidth - @offset
			element.width(width)


	class RO.MobileUI.PagingListView extends RO.MobileUI.Base
		role: "paging-list-view"
		constructor: ->
			super
			if @checkPageForAttr()
				@parseTree()

		parseTree: ->
			new RO.MobileUI.TreeNode(@el.children(), 0) 

	class RO.MobileUI.TreeNode extends Spine.Controller
		_target: ($ "#menu")
		_node: '''
		 	<li class="ui-list-{{level}} ui-list-item" data-child="{{index}}">
		 		<a href="#"class="ui-btn ui-btn-icon-right {{#if theme}}ui-btn-{{theme}}{{/if}}">
		 			<span class="ui-btn-inner"><span class="ui-btn-text">
		 				{{#each body}}
		 					{{{this}}}
		 				{{/each}}
		 				</span>
		 				<span class="ui-icon {{#if icon}}ui-icon-{{icon}}{{/if}}">&nbsp;</span>
		 			</span>
		 		</a>
		 	</li>
		 '''
		_parent: '''
		 	<ul>
		 		{{#each nodes}}
		 			{{{this}}}
		 		{{/each}}
		 	</ul>
		 '''
		events: 
		 	"click .ui-list-item" : "clicked"
		constructor: (nodes, level) ->
			super
			if typeof nodes != "undefined"
		 		@nodes = nodes
		 		@nodeTMPL 	= Handlebars.compile(@_node)
		 		@parentTMPL	= Handlebars.compile(@_parent)
		 		@level = level
		 		@array = []
		 		@children = []
		 		@parseNodes()
		 		@parseParent()
		 		@render()
		
		clicked: (ev) ->
			child = ($ ev.currentTarget).attr("data-child")
			new RO.MobileUI.TreeNode(($ @children[child]).children(), 0) 

		render: ->
			($ @el).html(@parsedParent)
			@_target.html(@el)

		templateTheNode: ->
		 	console.log @node, @level

		parseNodes: ->
			index = 0
			for node in @nodes
				content = @convertContent(node) 
				obj =
					level : @level
					body  : content.body
					index: index
				template = @nodeTMPL(obj)
				@array.push template
				@children.push content.child
				index++

		parseParent: ->
			template = @parentTMPL(
					nodes: @array
				)

			@parsedParent = template
		convertContent: (nContent) ->
			
			n = ($ ($ nContent).html())
			elements = []
			child = {}

			t ='''
				<span {{#if class}}class="{{class}}"{{/if}}>{{text}}</span>
			'''
			tpl = Handlebars.compile(t)
			ge = (el) ->
					e = ($ el)
					_t = tpl(
						class: e.attr("class")
						text: e.text()
						)
					elements.push _t

			gc = (el) ->
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
			}


#
#  		 		if @node.children()
#		 			new RO.MobileUI.TreeNode($( li), level+1) for li in node.children("ul").children("li")
#		 		@templateTheNode()			
#
#
#