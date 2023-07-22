

class ObsidianConverter
  @output_dir = nil
  def initialize(output_dir)
    @output_dir = output_dir
    if File.exists?(@output_dir)
      raise "output directory #{@output_dir} already exists, remove it first"
    end
    `mkdir -p #{@output_dir}`
  end
  def convert(workspace)
    raise "unimplemented base class method"
  end
end

class ObsidianFlatConverter < ObsidianConverter
  def convert(workspace)
    internal_link_regexp = /\[([^\]]*)\]\(<[^\)]*\)/
    diff_workspace_regexp = /\[([^\]]*)\]\((https:\/\/app.nuclino.com[^\)]*)\)/
    workspace.keys.each do |key|
      short_filename = key
      orig_filename, id = workspace[key]
#      puts "processing #{orig_filename} #{short_filename} #{id}"
      content = File.read(orig_filename)
      while content =~ internal_link_regexp
        content = content.sub(internal_link_regexp, "[[#{$1}]]")
      end
      if content =~ diff_workspace_regexp
        puts "got external link to different workspace: #{$1} #{$2}"
      end
      File.open("#{@output_dir}/#{short_filename}.md", 'w') do |f|
        f.write(content)
      end
    end
  end
end