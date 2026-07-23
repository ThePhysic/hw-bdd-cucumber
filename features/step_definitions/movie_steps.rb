# Add a declarative step here for populating the DB with movies.

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then(/(.*) seed movies should exist/) do |n_seeds|
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then(/^I should see "([^"]*)" before "([^"]*)"(?: in the movie list)?$/) do |e1, e2|
  first_position = page.body.index(e1)
  second_position = page.body.index(e2)

  expect(first_position).not_to be_nil
  expect(second_position).not_to be_nil
  expect(first_position).to be < second_position
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I check only the following ratings: PG, G, R"

When(/I check the following ratings: (.*)/) do |rating_list|
  ratings = rating_list.split(/\s*,\s*/)

  ratings.each do |rating|
    step %(I check "#{rating}")
  end
end

Then(/^I should (not )?see the following movies: (.*)$/) do |no, movie_list|
  movies = movie_list.split(/\s*,\s*/)

  movies.each do |movie|
    step %(I should #{no}see "#{movie}")
  end
end

Then(/^I should see all the movies$/) do
  rows = page.all('div[id^="movie_"]').count
  expect(rows).to eq Movie.count
end

### Utility Steps Just for this assignment.

Then(/^debug$/) do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"
  byebug
  1 # intentionally force debugger context in this method
end

Then(/^debug javascript$/) do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then(/complete the rest of of this scenario/) do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  raise "Remove this step from your .feature files"
end
