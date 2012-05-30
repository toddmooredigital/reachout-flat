# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'sprockets', :destination => './assets/js/bin', :asset_paths => ['./assets/coffee', './assets/js/libs'] do
  watch(%r{^\./assets/coffee/.}) { |m| "application.js" }
end
