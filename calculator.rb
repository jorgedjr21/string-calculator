class Calculator

  def add(str_numbers)
    numbers = str_numbers.split(/[\\n]|,/).map(&:to_i)
    numbers.reduce(0, :+)
  end
end
