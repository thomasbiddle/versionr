require 'yaml'

class Versionr

  attr_reader :major
  attr_reader :minor
  attr_reader :patch

  def initialize(version_dir = Dir.pwd)
    @version_dir = "#{version_dir}" + "/VERSION"
    version = YAML.load_file(@version_dir)
    @major = version['version']['major']
    @minor = version['version']['minor']
    @patch = version['version']['patch']
    rescue abort("Can't open %s" % version_dir)
  end

  def write_version
    data = {"version" => { "major" => @major, "minor" => @minor, "patch" => @patch } }
    File.open(@version_dir, 'w+') { |f| f.write(data.to_yaml) }
  end

  def full_version
    version =  "#{@major}.#{@minor}.#{@patch}"
    return version
  end

  def bump_major
    @major += 1
    @minor = 0
    @patch = 0
    write_version
  end

  def bump_minor
    @minor += 1
    @patch = 0
    write_version
  end

  def bump_patch
    @patch += 1
    write_version
  end

end
