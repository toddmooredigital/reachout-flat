#=require_tree ../js/libs
#=require ./namespace.coffee
#=require ./config.coffee
#=require ./spine/src/spine.coffee
#=require ./router.coffee
#=require_tree ./modules
#=require_tree ./ui
namespace "RO.Main", (exports) ->
    class RO.Main.ReachOut extends Spine.Events
        constructor: ->  
            @UI = {} 

            @setGlobalHost()

            #Activate all UI Classes
            @activateUI(key, uiObject) for key, uiObject of RO.UI      

            router = new RO.Route.Router

            RO.Main.ReachOut.bind "dom:change", =>
                ($ "*:last-child").addClass("last-child")

            RO.Main.ReachOut.trigger "dom:change"


        activateUI: (key, obj) ->
            new obj

        setGlobalHost: ->

            if window.location.hostname == "0.0.0.0"
                window.ROENV = "Flat"
            else if window.location.hostname == "inspire.local"
                window.ROENV = "Development"
            else 
                window.ROENV = "Staging"



    $ ->
        window.RO["i"] = new RO.Main.ReachOut     

