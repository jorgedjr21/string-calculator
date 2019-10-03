require './calculator'

RSpec.describe Calculator do
  describe '#add' do
    context 'when numbers are separated by comas' do
      let!(:numbers) { Array.new(rand(3..10)) { rand(1..50) } }
      it 'must sum the numbers correctly' do
        calculator = Calculator.new
        expected_result = numbers.reduce(0, :+)


        expect(calculator.add(numbers.join(','))).to be(expected_result)
      end

      it 'must be integer result' do
        calculator = Calculator.new
        expected_result = numbers.reduce(0, :+)

        expect(calculator.add(numbers.join(','))).to be_an(Integer)
      end
    end
  end
end
