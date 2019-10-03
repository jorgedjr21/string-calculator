class Calculator

  def add(str_numbers)
    numbers = str_numbers.split(',').map(&:to_i)

    return numbers.reduce(0, :+)
  end
end
