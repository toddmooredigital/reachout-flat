(function(){var a=function(a,b){return function(){return a.apply(b,arguments)}},b=Object.prototype.hasOwnProperty,c=function(a,c){function e(){this.constructor=a}for(var d in c)b.call(c,d)&&(a[d]=c[d]);return e.prototype=c.prototype,a.prototype=new e,a.__super__=c.prototype,a};namespace("RO.Modules",function(b){return RO.Modules.Slideshow=function(b){function d(){this.before=a(this.before,this),this.template=Handlebars.compile(this.tmp),$(this.el).cycle({fx:"fade",before:this.before})}return c(d,b),d.prototype.tmp='{{title}}\n              <b>{{subsection}}</b>\n              <span>{{description}} <a href="{{link}}">Learn more</a>\n              </span>',d.prototype.heading=$("[data-slideshow-heading]"),d.prototype.el=$("[data-slideshow=cycle]"),d.prototype.before=function(a,b,c){var d,e;return e=$(b),d={title:e.attr("data-slideshow-title"),subsection:e.attr("data-slideshow-subsection"),description:e.attr("data-slideshow-description"),link:e.attr("data-slideshow-link")},this.heading.html(this.template(d))},d}(Spine.Events)})}).call(this);