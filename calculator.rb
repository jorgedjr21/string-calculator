class Calculator

  def add(str_numbers)

    case delimiter?(str_numbers)
    when true
      delimiter = get_delimiter(str_numbers)
      no_delimiter_numbers = str_numbers.split(%r{^\/{2}\W*\\n}).reject { |v| v == "" }[0]
      no_delimiter_numbers.split(delimiter).map(&:to_i).reduce(0, :+)
    else
      numbers = str_numbers.split(/[\\n]|,/).map(&:to_i)
      numbers.reduce(0, :+)
    end
  end

  def delimiter?(str_numbers)
    str_numbers.scan(%r{^\/{2}\W*\\n}).size.positive?
  end

  def get_delimiter(str_numbers)
    str_numbers.split(%r{[\/\/\\n]}).reject { |v| v == "" }[0]
  end
end
