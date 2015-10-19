#!/usr/bin/env ruby

# https://github.com/everbot/dotfiles

require 'io/console' # for STDIN.getch

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

def success(msg)
  puts "[ OK ] ".clrGreen + msg
end

# Create symlink from `source` to `target`
def linkFile(source, target)
  skip = false
  overwrite = false
  backup = false

  # broken symlink doesn't get detected by `File.exist?`
  if File.exist?(target) || File.symlink?(target)
    if File.exist?(target) && File.realpath(target) == source
      skip = true
    else
      if not (@skipAll || @overwriteAll || @backupAll)
        puts "[ ? ]".clrYellow + " File already exists: #{target}, what do you want to do?"
        print "      [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all? "

        selection = STDIN.getch
        puts
        case selection
        when "s"
          skip = true
        when "S"
          @skipAll = true
        when "o"
          overwrite = true
        when 'O'
          @overwriteAll = true
        when 'b'
          backup = true
        when 'B'
          @backupAll = true
        else
          skip = true
        end
      end # end checking no "*all" option is selected

      skip |= @skipAll
      overwrite |= @overwriteAll
      backup |= @backupAll

      if overwrite
        # TODO: optimize this
        File.delete(target)
        success("removed #{target}")
      end

      if backup
        File.rename(target, "#{target}.backup")
        success("moved #{target} to #{target}.backup")
      end

      if skip
        success("skipped #{source}")
      end
    end # end checking source == target
  end

  if !skip
    begin
      File.symlink(source, target)
      success("linked #{source} to #{target}")
    rescue => err
      fail("Exception: #{err}")
    end
  end
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
    fail("Exception: #{err}")
  end
end

def installDotfiles
  readConfigFile

  # loop through all the item with postfix "symlink"
  Dir.glob(File.join(SOURCE_DIR, "**/*.symlink"), File::FNM_DOTMATCH) do |source|
    # get the base name without postfix ".symlink"
    basename = File.basename(source).match(/(?:(?!\.symlink).)*/)[0]

    if @toSymlink.include?(basename)
      subDir = File.dirname(source).sub(SOURCE_DIR, '').delete("/")

      dest = (subDir.length == 0) ? File.join(TARGET, basename) :
                                    File.join(TARGET, subDir, basename)

      linkFile(source, dest)
      # puts basename + " " + dest
    end
  end
end

CONFIG_FILE = "config"
TARGET = File.expand_path('~') # user's home dir
# TARGET = "/home/tung/mytemp/test" # for testing

# get absolute path of the dotfiles repo
SOURCE_DIR = File.expand_path File.dirname(__FILE__)

@toSymlink = []
@skipAll = false
@overwriteAll = false
@backupAll = false

if ARGV.length > 0
  case ARGV[0]
  when 'overwrite'
    @overwriteAll = true
  when 'skip'
    @skipAll = true
  when 'backup'
    @backupAll = true
  end
end

installDotfiles
puts "Number of config files = #{@toSymlink.count}"

