#!/usr/bin/env ruby
require 'nokogiri'
require 'json'

path, output_file = ARGV[0], ARGV[1] || "output.json"

if ARGV.length == 0
    puts "Please specify a path!"
    exit
end

files = Dir.glob(File.join(path, '**', '*.html'))
puts "Found #{files.length} files."

items, skipped_files = [], 0

skipped_files =0

files.each do |f|
    begin
        raw_html = File.read(f)
        page = Nokogiri::HTML(raw_html)

        # Remove GH link:
        gh_link = page.css('.container-github')
        if gh_link.length > 0
            gh_link[0].remove
        end

        h1_tag = page.css('h1')
        if h1_tag.length > 0
          h1_tag.remove
        end

        item = {
          title: page.css('title').text.strip().chomp(' - Tyk Documentation'),
          article: page.css('#main-content').text.strip.gsub("\n", " "),
          path: f.gsub(path, "").chomp("index.html")
        }
        items << item
    rescue
        puts "Skipping: #{f}"
        skipped_files+=1
    end
end

puts "Skipped files: #{skipped_files} of #{files.length}"
puts "Writing output to #{output_file}..."

output_json = JSON.dump(items)
File.write(output_file, output_json)
