require 'sprite_factory'
require 'nokogiri'

desc "Package up the site"
task :packageprep do 
	`svn delete ../Website/assets` 
	`svn commit -m "Removing Assets"`
end

desc "Package up the site"
task :package do 
	`sprocketize`
	`mkdir ../Website/assets`
	`rm -rf ../Website/assets/coffee`
	`rm -rf ../Website/assets/css`
	`rm -rf ../Website/assets/images`
	`rm -rf ../Website/assets/js`
	`cp -rf assets/js ../Website/assets/js`
	`cp -rf assets/css ../Website/assets/css`
	`cp -rf assets/coffee ../Website/assets/coffee`
	`cp -rf assets/images ../Website/assets/images`
	`find ../Website/assets/coffee -name ".svn" | xargs rm -Rf`
	`find ../Website/assets/js -name ".svn" | xargs rm -Rf`
	`find ../Website/assets/css -name ".svn" | xargs rm -Rf`
	`find ../Website/assets/images -name ".svn" | xargs rm -Rf`
	`svn add ../Website/assets`
	`svn add ../Website/assets/js`
	`svn add ../Website/assets/images`
	`svn add ../Website/assets/css`
	`svn add ../Website/assets/coffee`
	`svn commit -m "Readding Assets"`
end


desc "Create sprites for the flat HTML files"
task :sprite do 
	if File.exists? "assets/css/modules.css"
		system %Q{rm "assets/css/modules.css"}
	end
	modules = ""
	Dir["./assets/images/\*/"].each do |dir|
		bdir = File.basename(dir)
		SpriteFactory.run!(dir, {:selector => ".", :hmargin => 20, :csspath => "../../images", :nocomments => true })
		system %Q{mv "assets/images/#{bdir}.css" "assets/css/modules/#{bdir}.css"}
		modules << "@import url(\"modules/#{bdir}.css\");\n"
	end
	file = File.new("assets/css/modules.css", "w")
	file.write(modules)
    file.close
end

desc "Create sprites for the flat HTML files"
task :module_pattern_test do 
	if Dir.exists? "views/"
		Dir["./views/*/**"].each do |file|
			
			doc = Nokogiri::HTML(File.open(file))
			doc.xpath("//*[contains(@class, 'module')]").each do |mod|
			  if mod["data-exclude"] != "true"
				  name = mod.attribute("class").to_s.gsub!(' ','_')	
				  
				  if mod["data-extension"]
				  	ext = mod["data-extension"]
				  	name = name + "_#{ext}"
				  	mod.remove_attribute("data-extension")
				  end

				  file = File.new("./test/modules/#{name}.html", "w")
				  file.write(mod)
				  file.close
			  end
			end
			
		end
	end
end