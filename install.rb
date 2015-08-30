# help to print colorized string to terminal
class String
  def colorize(clrCode)
    "\e[#{clrCode}m#{self}\e[0m"
  end

  def clrGreen
    colorize(32)
  end

  def clrRed
    colorize(31)
  end

  def clrYellow
    colorize(33)
  end
end

def fail(msg)
  puts "[ FAILED ] ".clrRed + msg
end

def readConfigFile
  begin
    file = File.new(File.join(SOURCE_DIR, CONFIG_FILE), "r")
    while (line = file.gets)
      line = line.strip
      if line.length > 0 && line[0] != "#"
        @toSymlink << line.match(/[^#]*/)[0].strip
      end
    end
    file.close
  rescue => err
    puts "Exception: #{err}"
    err
  end
end

def installDotfiles
  readConfigFile

  # loop through all the item with postfix "symlink"
  Dir.glob(File.join(SOURCE_DIR, "**/*.symlink"), File::FNM_DOTMATCH) do |item|
    # get the base name without postfix ".symlink"
    basename = File.basename(item).match(/(?:(?!\.symlink).)*/)[0]

    if @toSymlink.include?(basename)
      subDir = File.dirname(item).sub(SOURCE_DIR, '').delete("/")

      dest = (subDir.length == 0) ? File.join(TARGET, basename) : 
                                    File.join(TARGET, subDir, basename)

      puts basename + " " + dest
    end
  end
end

CONFIG_FILE = "config"

# get absolute path of the dotfiles repo
SOURCE_DIR = File.expand_path File.dirname(__FILE__)

TARGET = "/home/mytemp/"

@toSymlink = []
installDotfiles

puts "Number of config files = #{@toSymlink.count}"
# @toSymlink.each do |str|
#   puts str
# end

