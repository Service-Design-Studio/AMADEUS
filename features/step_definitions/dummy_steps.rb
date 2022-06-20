Given(/^There is a string we wish to return$/) do
  @cukes = "Cukes are running wild"
end

Then(/^Cucumber will return the string$/) do
  puts @cukes
end