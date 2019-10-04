class Calculator
  def add(str_numbers)

    if delimiter?(str_numbers)
      delimiter = get_delimiter(str_numbers)
      no_delimiter_numbers = str_numbers.split(%r{^\/{2}\W*\\n}).reject { |v| v == '' }[0]
      numbers = no_delimiter_numbers.split(delimiter).map(&:to_i)
    else
      numbers = str_numbers.split(/[\\n]|,/).reject { |v| v == '' }.map(&:to_i)
    end
    neg_numbers = negatives(numbers)
    raise Exception.new, "Negatives not allowed: #{neg_numbers}" if neg_numbers.size > 0

    numbers.select{ |n| n < 1000 }.reduce(0, :+)
  end

  def delimiter?(str_numbers)
    str_numbers.scan(%r{^\/{2}\W*\\n}).size.positive?
  end

  def get_delimiter(str_numbers)
    str_numbers.split(%r{[\/\/\\n]}).reject { |v| v == "" }[0]
  end

  def negatives(numbers)
    numbers.select { |number| number < 0 }
  end
end
