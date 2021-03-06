# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  position_e1 = page.body.index(e1)  
  position_e2 = page.body.index(e2)
  if position_e1.should_not > position_e2
    fail "Wrong order"
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do | rating |
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table#movies tbody tr').length
  rows.should eq Movie.count
end
