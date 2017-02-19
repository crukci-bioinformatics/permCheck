require "etc"
require "fileutils"
require "find"
require "mail"
require "socket"

require "permCheck/version"
require "modeBits"

# Check permissons and group ownership of files.
#
# @author Gord Brown
module PermCheck

  # Top-level class to carry out an audit.
  class PermCheck

    # Set up for audit.
    def initialize(umask,smask,group)
      @umask = ModeBits.txt2num(umask)
      @smask = ModeBits.txt2num(smask)
      @group = group
      @gid = Etc.getgrnam(group).gid
      @messages = []
    end

    # Run the audit.
    def audit(root)
      count = 0
      Find.find(root) do |path|
        bad = false
        if !File.readable?(path)
          @messages << "unreadable: #{path}"
          bad = true
        else
          stat = File.stat(path)
          if stat.gid != @gid
            gp = Etc.getgrgid(stat.gid)
            @messages << "#{gp.name} != #{@group}: #{path}"
            bad = true
          end
          if (stat.mode&@umask != 0) || (stat.mode&@smask == 0)
            modestr = ModeBits.num2txt(stat.mode)
            @messages << "mode violation #{modestr}: path '#{path}'"
            bad = true
          end
        end
        if bad
          count += 1
          Find.prune
        end
      end
      return count
    end

    # Report on the audit.
    def report(mailto)
      text = formatMsg()
      if mailto.nil?
        STDOUT.puts(text)
      else
        targets = mailto.split(",")
        Mail.deliver do
          from    "audit@#{Socket.gethostname}"
          to      targets
          subject "file permissions check"
          body    text
        end
      end
    end

    def formatMsg()
      host = Socket.gethostname
      strs = ["Permissions check: #{host}\n"]
      strs << "umask: #{ModeBits.num2txt(@umask)}"
      strs << "smask: #{ModeBits.num2txt(@smask)}"
      strs << "group: #{@group}\n"
      strs << "MESSAGES:"
      @messages.each do |m|
        strs << m
      end
      return strs.join("\n")
    end

  end

end
