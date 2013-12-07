require 'lib/data_loaders'

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.add_import_path "bower_components/foundation/scss"
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:

# With alternative layout
page "/exemplars/*", :layout => :exemplar
# With no layout
page "*.css", :layout => false

# Meta redirects
# redirect 'index.html', to: 'prototypes/sample'

# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Custom helpers
# helpers do
#   def customer_helper
#   end
# end

helpers DataLoaders

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

set :css_dir, 'stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

sprockets.append_path "bower_components/foundation/js"
sprockets.append_path "bower_components/jquery"

configure :development do
  Slim::Engine.set_default_options :pretty => true

  activate :livereload
end

# Build-specific configuration
configure :build do
  # activate :directory_indexes

  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
