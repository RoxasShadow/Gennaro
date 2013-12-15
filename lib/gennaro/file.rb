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
  def delete_dir(path)
    FileUtils.rm_r path if Dir.exists? path
  end
  
  protected
  def mkdir(path)
    Dir.mkdir path unless Dir.exists? path
  end

  protected
  def copy(what, where)
    FileUtils.copy_entry what, where
  end

  protected
  def each_file(path, &block)
    Dir.glob("#{path}/**/*").each { |f|
      next if File.directory? f
      yield f
    }
  end

  protected
  def rename(file, first, after)
    new_file = file.gsub(first, after)
    FileUtils.mv file, new_file if file != new_file
  end
end