require 'open-uri'

# Allow keys dot syntax
class Hash
  def method_missing(method, *opts)
    m = method.to_s
    if self.has_key?(m)
      return self[m]
    elsif self.has_key?(m.to_sym)
      return self[m.to_sym]
    end
    super
  end
end

module DataLoaders
  def pwd
    "#{source}/#{current_page.path.sub(/\/[\w\-\.]+$/, '')}"
  end

  def load_json(path)
    # `source` location
    if path.start_with? '~/'
      location = source
      path = path.sub(/^~\//, '')
    # project root
    elsif path.start_with? '/'
      location = root
      path = path.sub(/^\//, '')
    else
      location = pwd
    end

    # remote JSON
    if path.start_with? 'http'
      json = open(path).read
    else
      json = IO.read("#{File.expand_path(path, location)}.json")
    end

    JSON.parse(json)
  end

  def load_yaml(path)
    # ~ refers to `source`
    # / refers to project root
    if path.start_with? '~/'
      location = source
      path = path.sub(/^~\//, '')
    elsif path.start_with? '/'
      location = root
      path = path.sub(/^\//, '')
    else
      location = pwd
    end

    file_path = "#{File.expand_path(path, location)}"

    if File.exists? "#{file_path}.yaml"
      full_path = "#{file_path}.yaml"
    elsif File.exists? "#{file_path}.yml"
      full_path = "#{file_path}.yml"
    else
      raise "No such file - #{file_path}.y(a)ml"
    end

    YAML.load_file(full_path)
  end
end
