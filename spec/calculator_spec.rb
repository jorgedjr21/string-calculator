require './calculator'

RSpec.describe Calculator do
  let!(:calculator) { Calculator.new }
  describe '#add' do
    context 'when numbers are separated by comas' do
      let!(:numbers) { Array.new(rand(3..10)) { rand(1..50) } }
      it 'must sum the numbers correctly' do
        expected_result = numbers.reduce(0, :+)
        expect(calculator.add(numbers.join(','))).to be(expected_result)
      end

      it 'must be integer result' do
        expect(calculator.add(numbers.join(','))).to be_an(Integer)
      end
    end

    context 'when numbers have linebreak' do
      let!(:test_number1){ '1\n,2,3' }
      let!(:test_number2){ '1,\n2,4' }
      let!(:test_number3){ '3,3,4\n' }

      it 'must sum the numbers correctly' do
        expect(calculator.add(test_number1)).to be(6)
        expect(calculator.add(test_number2)).to be(7)
        expect(calculator.add(test_number3)).to be(10)
      end

      it 'must be integer result' do
        expect(calculator.add(test_number1)).to be_an(Integer)
        expect(calculator.add(test_number2)).to be_an(Integer)
        expect(calculator.add(test_number3)).to be_an(Integer)
      end
    end
  end
end
