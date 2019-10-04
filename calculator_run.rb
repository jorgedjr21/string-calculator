require './calculator'

numbers = ARGV[0]

if numbers.nil?
  print "Error: \e[31m No numbers are given.\e[0m \n"
  print "Usage: \e[34m ruby calculator_run.rb '1,2,3,4'\e[0m for example\n\n"
else
  calculator = Calculator.new
  p calculator.add(numbers)
end
