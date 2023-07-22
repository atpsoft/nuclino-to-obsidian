#!/usr/bin/env ruby
require 'optparse'
require './lib/nuclino'
require './lib/obsidian'

options = {
  :output_dir => 'obsidian_output'
}
OptionParser.new do |opts|
  opts.banner = "Usage: nto.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
  opts.on("-i", "--input-dir dir", "directory from nuclino export, unzipped") do |dir|
    options[:input_dir] = dir
  end
  opts.on("-o", "--output_dir dir", "directory to write obsidian files to, defaults to obsidian_output") do |dir|
    options[:output_dir] = dir
  end
  opts.on("-d", "--dir dir", "directory in Downloads to convert into same dir in output_dir") do |dir|
    options[:dir] = dir
    options[:input_dir] = "#{ENV['HOME']}/Downloads/#{dir}"
  end
end.parse!

if options[:dir]
  options[:output_dir] = "#{options[:output_dir]}/#{options[:dir]}"
end

puts options

workspace = Nuclino.parse_input(options[:input_dir])
obsidian_converter = ObsidianFlatConverter.new(options[:output_dir])
obsidian_converter.convert(workspace)
