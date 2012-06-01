namespace "RO.Route", (exports) ->
  class RO.Route.Router
    
    constructor: ->
        @loginModule = new RO.Modules.LoginLogout
        @signupModule = new RO.Modules.Signup

        # Homepage
        RO.Route.Router.add "/", =>
            new RO.Modules.Slideshow

        #Login Function
        RO.Route.Router.add "#login", =>
          @loginModule.bind "rendered", =>
            @loginModule.show()        #Login Function
        
        RO.Route.Router.add "#signup", =>
          @signupModule.bind "rendered", =>
            @signupModule.show()

        RO.Route.Router.process()  


    @add: (path, callback) ->
      @routes ||= []
      @routes.push { 
        path: new RegExp(path.replace(/\//g, "\\/").replace(/:(\w*)/g,"(\\w*)")), 
        callback: callback 
      }  


    @process: ->
      for route in @routes
        params = window.location.pathname.match(route.path) || window.location.hash.match(route.path)
        if params?
          route.callback(params)


