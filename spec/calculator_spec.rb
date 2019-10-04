require './calculator'

RSpec.describe Calculator do
  let!(:calculator) { Calculator.new }
  describe '#add' do
    context "when numbers are \e[34mseparated by comas\e[0m" do
      let!(:numbers) { Array.new(rand(3..10)) { rand(1..50) } }
      it 'must sum the numbers correctly' do
        expected_result = numbers.reduce(0, :+)
        expect(calculator.add(numbers.join(','))).to be(expected_result)
      end

      it 'must be integer result' do
        expect(calculator.add(numbers.join(','))).to be_an(Integer)
      end
    end

    context "when numbers \e[34mhas linebreak\e[0m" do
      let!(:test_number1) { '1\n,2,3' }
      let!(:test_number2) { '1,\n2,4' }
      let!(:test_number3) { '3,3,4\n' }

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

    context "when numbers has \e[34mcustom delimiter\e[0m" do
      let!(:test_number1){ '//$\n1$2$3' }
      let!(:test_number2){ '//@\n2@3@8' }
      let!(:test_number3){ '//,\n3,3,3' }

      it 'must sum the numbers correctly' do
        expect(calculator.add(test_number1)).to be(6)
        expect(calculator.add(test_number2)).to be(13)
        expect(calculator.add(test_number3)).to be(9)
      end

      it 'must be integer result' do
        expect(calculator.add(test_number1)).to be_an(Integer)
        expect(calculator.add(test_number2)).to be_an(Integer)
        expect(calculator.add(test_number3)).to be_an(Integer)
      end
    end
  end
end
