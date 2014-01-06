require 'lib/data_loaders'

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.add_import_path 'bower_components/foundation/scss'
  # For Style Guide CSS sources
  # config.output_style = :expanded
end

Slim::Engine.set_default_options :pretty => true

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:

# With alternative layout
page '/exemplars/**', :layout => 'exemplar-page'
# With no layout
page "/partials/*", :layout => false
page '*.css', :layout => false
page '*.js', :layout => false

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
helpers do
  def subpages_for(dir, exclude_index = true)
    sitemap.resources.select do |resource|
      if exclude_index && ['/', "/#{dir}/"].include?(resource.url)
        false
      elsif resource.path.start_with?(dir) && resource.ext == '.html'
        true
      end
    end
  end

  def exemplar_for(component_name=nil, options={})
    meta = {
      title: options.delete(:title),
      description: options.delete(:description),
      component_path: component_name ? "components/#{component_name}" : nil
    }

    options.reverse_merge!(meta: meta)

    if data = options.delete(:data)
      options.merge!(data)
    end

    partial('exemplars/exemplar', :locals => options)
  end

  def exemplar(options={}, &block)
    if block_given?
      options[:content] = capture_html(&block)
    else
      raise "Exemplar ‘#{options[:title]}’: No HTML block given"
    end

    exemplar_for nil, options
  end

  # Use in layouts, in templates either Frontmatter or this method can be used
  def append_class(block_name, appended_classes='')
    current_page_classes = current_page.data[block_name] || ''
    existing_classes_a = current_page_classes.split(' ')
    appended_classes_a = appended_classes.split(' ')
    classes = existing_classes_a.concat(appended_classes_a).reverse.join(' ')
    content_for(block_name, classes)
  end
end

helpers DataLoaders

activate :syntax, css_class: 'codehilite'

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

set :css_dir, 'stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :relative_links, true

ready do
  sprockets.append_path 'bower_components/foundation/js'
  sprockets.append_path 'bower_components/jquery'
  sprockets.append_path 'bower_components'
end

configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  compass_config do |config|
    config.sass_options = { :line_comments => false }
  end

  # Middleman Livereload fails to reload CSS only with Sass partials.
  # It works correctly with non-underscore-prefixed
  # https://github.com/middleman/middleman-livereload/issues/3

  # Ignore partials for build
  ignore 'stylesheets/components/**'
  ignore 'bower_components/modernizr/**'

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

# Simple launcher for local evaluation build
# Double click `build/launch.command` (Mac)
after_build do |builder|
  file = "#{build_dir}/launch.command"
  open(file, 'w') do |f|
    f << "#!/bin/bash\n"
    f << 'cd `dirname $0` && open "http://localhost:8000" && python -m SimpleHTTPServer'
  end
  File.chmod(0555, file)
end

activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  # deploy.remote = "custom-remote" # remote name or git url, default: origin
  # deploy.branch = "custom-branch" # default: gh-pages
end
