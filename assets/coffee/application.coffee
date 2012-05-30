#=require_tree ../js/libs
#=require ./namespace.coffee
#=require ./spine/src/spine.coffee
#=require ./router.coffee
#=require_tree ./modules
#=require_tree ./ui
namespace "RO.Main", (exports) ->
    class RO.Main.ReachOut extends Spine.Events
        constructor: ->  
            @UI = {} 

            #Activate all UI Classes
            @activateUI(key, uiObject) for key, uiObject of RO.UI      

            router = new RO.Route.Router

            RO.Main.ReachOut.bind "dom:change", =>
                ($ "*:last-child").addClass("last-child")

            RO.Main.ReachOut.trigger "dom:change"


        activateUI: (key, obj) ->
            new obj


    $ ->
        window.RO["i"] = new RO.Main.ReachOut     

