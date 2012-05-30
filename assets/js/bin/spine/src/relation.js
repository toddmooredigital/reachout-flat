(function(){var Collection,Instance,Singleton,isArray,singularize,underscore,__hasProp=Object.prototype.hasOwnProperty,__extends=function(a,b){function d(){this.constructor=a}for(var c in b)__hasProp.call(b,c)&&(a[c]=b[c]);return d.prototype=b.prototype,a.prototype=new d,a.__super__=b.prototype,a};if(typeof Spine=="undefined"||Spine===null)Spine=require("spine");isArray=Spine.isArray;if(typeof require=="undefined"||require===null)require=function(value){return eval(value)};Collection=function(a){function b(a){var b,c;a==null&&(a={});for(b in a)c=a[b],this[b]=c}return __extends(b,a),b.prototype.all=function(){var a=this;return this.model.select(function(b){return a.associated(b)})},b.prototype.first=function(){return this.all()[0]},b.prototype.last=function(){var a;return a=this.all(),a[a.length-1]},b.prototype.find=function(a){var b,c=this;b=this.select(function(b){return b.id+""==a+""});if(!b[0])throw"Unknown record";return b[0]},b.prototype.findAllByAttribute=function(a,b){var c=this;return this.model.select(function(c){return c[a]===b})},b.prototype.findByAttribute=function(a,b){return this.findAllByAttribute(a,b)[0]},b.prototype.select=function(a){var b=this;return this.model.select(function(c){return b.associated(c)&&a(c)})},b.prototype.refresh=function(a){var b,c,d,e,f,g,h;h=this.all();for(d=0,f=h.length;d<f;d++)b=h[d],delete this.model.records[b.id];c=this.model.fromJSON(a),isArray(c)||(c=[c]);for(e=0,g=c.length;e<g;e++)b=c[e],b.newRecord=!1,b[this.fkey]=this.record.id,this.model.records[b.id]=b;return this.model.trigger("refresh",c)},b.prototype.create=function(a){return a[this.fkey]=this.record.id,this.model.create(a)},b.prototype.associated=function(a){return a[this.fkey]===this.record.id},b}(Spine.Module),Instance=function(a){function b(a){var b,c;a==null&&(a={});for(b in a)c=a[b],this[b]=c}return __extends(b,a),b.prototype.exists=function(){return this.record[this.fkey]&&this.model.exists(this.record[this.fkey])},b.prototype.update=function(a){return a instanceof this.model||(a=new this.model(a)),a.isNew()&&a.save(),this.record[this.fkey]=a&&a.id},b}(Spine.Module),Singleton=function(a){function b(a){var b,c;a==null&&(a={});for(b in a)c=a[b],this[b]=c}return __extends(b,a),b.prototype.find=function(){return this.record.id&&this.model.findByAttribute(this.fkey,this.record.id)},b.prototype.update=function(a){return a instanceof this.model||(a=this.model.fromJSON(a)),a[this.fkey]=this.record.id,a.save()},b}(Spine.Module),singularize=function(a){return a.replace(/s$/,"")},underscore=function(a){return a.replace(/::/g,"/").replace(/([A-Z]+)([A-Z][a-z])/g,"$1_$2").replace(/([a-z\d])([A-Z])/g,"$1_$2").replace(/-/g,"_").toLowerCase()},Spine.Model.extend({hasMany:function(a,b,c){var d;return c==null&&(c=""+underscore(this.className)+"_id"),d=function(d){return typeof b=="string"&&(b=require(b)),new Collection({name:a,model:b,record:d,fkey:c})},this.prototype[a]=function(a){return a!=null&&d(this).refresh(a),d(this)}},belongsTo:function(a,b,c){var d;return c==null&&(c=""+singularize(a)+"_id"),d=function(d){return typeof b=="string"&&(b=require(b)),new Instance({name:a,model:b,record:d,fkey:c})},this.prototype[a]=function(a){return a!=null&&d(this).update(a),d(this).exists()},this.attributes.push(c)},hasOne:function(a,b,c){var d;return c==null&&(c=""+underscore(this.className)+"_id"),d=function(d){return typeof b=="string"&&(b=require(b)),new Singleton({name:a,model:b,record:d,fkey:c})},this.prototype[a]=function(a){return a!=null&&d(this).update(a),d(this).find()}}})}).call(this);