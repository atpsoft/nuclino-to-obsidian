
module Nuclino

def self.parse_input(input_dir)
  result = []
  mdfiles = Dir.glob("#{input_dir}/*.md")
  allfiles = Dir.glob("#{input_dir}/*")
  unhandled_files = allfiles - mdfiles
  #puts "got md files: #{mdfiles.join("\n")}"
  puts "**********got unhandled files: #{unhandled_files.inspect}"

  return get_md_filenames(mdfiles)
end

def self.get_md_filenames(mdfiles)
  result = {}
  mdfiles.each do |mdfile|
    if mdfile =~ /(.*)( [0-9a-f]{8}).md/
      key = File.basename($1)
      values = [mdfile, $2]
    elsif File.basename(mdfile) == 'index.md'
      key = "index"
      values = [mdfile, '']
    else
      raise "unexpected md filename #{mdfile}"
    end
    if result[key]
      raise "duplicate name: #{key}"
    end
    result[key] = values
  end
  return result
end

end