#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Gennaro
  attr_accessor :template, :classname, :appname, :path

  def initialize(template, classname, path, force = false)
    @template  = template
    @classname = classname
    @appname   = classname.downcase
    @path      = File.join path, @appname

    delete_dir @path if force
    raise ArgumentError, "#{@path} already exists." if     Dir.exists? @path
    raise ArgumentError, "#{@template} not found."  unless Dir.exists? @template
  end

  def get_random_string(length = 8)
    dict = (?a..?z).to_a + (?A..?Z).to_a + (0..9).to_a
    (0..length).map { dict.sample}.join
  end

  def generate!
    mkdir @path
    copy  @template, @path
  end

  def replace_tags!
    each_file(@appname) { |f|
      rename f, /_class_name_/, @appname
    }

    each_file(@appname) { |f|
      s = File.read f
      File.open(f, ?w) { |f|
        s.gsub! '${ClassName}',      @classname
        s.gsub! '${GenerateString}', get_random_string(36)
        f.write s
      }
    }
  end

  def self.get_templates(path)
    Dir.glob("#{path}/*").map { |f| File.basename f}
  end

  def self.template_exists?(path, template)
    self.get_templates(path).include? template
  end
end