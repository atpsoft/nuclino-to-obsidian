

def convert_workspace(workspace, obsidian_output)
  puts "Converting workspace #{workspace['name']} with #{obsidian_output}"
  obsidian_output.convert(workspace)
end