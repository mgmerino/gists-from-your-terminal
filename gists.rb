require 'octokit'
#require 'json'
require 'colorize'
require "netrc"

client = Octokit::Client.new(:netrc => true)
starred = client.starred_gists

starred.reverse_each do |item|
    description = "Description: #{item[:description]}" 
    url = "Url: #{item[:html_url]}"
    description = description.slice(0, 32) if description.size > 100
    description.size > url.size ? box_width = description.size.to_i : box_width = url.size.to_i  
    box_width += 2 
    puts "💾  => #{item[:files]._fields.first} | 👤  => #{item[:owner][:login]}".colorize(:light_green)
    print '┌'
    box_width.times{|x| print "─"}
    print '┐'
    print "\n"
    puts "│ #{description}"
    puts "│ #{url}"
    print '└'
    box_width.times{|x| print "─"}
    print '┘'
    puts "\r"
end
