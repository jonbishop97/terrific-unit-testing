# Add a declarative step here for populating the DB with movies.
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #  Need to use a regex to test with the html string
  expect(/#{e1}(.*)#{e2}/m).to match page.body
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == "un"
    rating_list.split.each do |rating|
      step "I uncheck \"ratings[#{rating}]\""
    end
  else
    rating_list.split.each do |rating|
      step "I check \"ratings[#{rating}]\""
    end
  end
end

Then /I should see all (\d+) movies/ do |number|
  # Make sure that all the movies in the app are visible in the table
  expect(number).to eq "#{Movie.count}"
  Movie.all.each do |movie|
    step "I should see \"#{movie["title"]}\""
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  expect(Movie.find_by_title(arg1).director).to eq arg2
end