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
      let!(:test_numbers1) { '1\n,2,3' }
      let!(:test_numbers2) { '1,\n2,4' }
      let!(:test_numbers3) { '3,3,4\n' }

      it 'must sum the numbers correctly' do
        expect(calculator.add(test_numbers1)).to be(6)
        expect(calculator.add(test_numbers2)).to be(7)
        expect(calculator.add(test_numbers3)).to be(10)
      end

      it 'must be integer result' do
        expect(calculator.add(test_numbers1)).to be_an(Integer)
        expect(calculator.add(test_numbers2)).to be_an(Integer)
        expect(calculator.add(test_numbers3)).to be_an(Integer)
      end
    end

    context "when numbers has \e[34mcustom delimiter\e[0m" do
      let!(:test_numbers1) { '//$\n1$2$3' }
      let!(:test_numbers2) { '//@\n2@3@8' }
      let!(:test_numbers3) { '//,\n3,3,3' }

      it 'must sum the numbers correctly' do
        expect(calculator.add(test_numbers1)).to be(6)
        expect(calculator.add(test_numbers2)).to be(13)
        expect(calculator.add(test_numbers3)).to be(9)
      end

      it 'must be integer result' do
        expect(calculator.add(test_numbers1)).to be_an(Integer)
        expect(calculator.add(test_numbers2)).to be_an(Integer)
        expect(calculator.add(test_numbers3)).to be_an(Integer)
      end
    end

    context "when numbers has \e[34mcustom arbitrary length delimiter\e[0m" do
      let!(:test_numbers1) { '//$$$\n1$$$2$$$3' }
      let!(:test_numbers2) { '//@@@@@@@\n2@@@@@@@3@@@@@@@8' }
      let!(:test_numbers3) { '//,,,,,,,,,,,,,,,,\n3,,,,,,,,,,,,,,,,3,,,,,,,,,,,,,,,,3' }

      it 'must sum the numbers correctly' do
        expect(calculator.add(test_numbers1)).to be(6)
        expect(calculator.add(test_numbers2)).to be(13)
        expect(calculator.add(test_numbers3)).to be(9)
      end

      it 'must be integer result' do
        expect(calculator.add(test_numbers1)).to be_an(Integer)
        expect(calculator.add(test_numbers2)).to be_an(Integer)
        expect(calculator.add(test_numbers3)).to be_an(Integer)
      end
    end

    context "when has \e[34mnegative numbers\e[0m" do
      let!(:test_numbers1) { '1,-2,3,-4,5' }
      let!(:test_numbers2) { '1,\n2,-3,4,-10' }
      let!(:test_numbers3) { '//@\n2@-5@3@8@-1' }

      it 'must throw an exception' do
        expect { calculator.add(test_numbers1) }.to raise_exception(Exception)
        expect { calculator.add(test_numbers2) }.to raise_exception(Exception)
        expect { calculator.add(test_numbers3) }.to raise_exception(Exception)
      end

      it 'must have the correct message' do
        expect { calculator.add(test_numbers1) }.to raise_error('Negatives not allowed: [-2, -4]')
        expect { calculator.add(test_numbers2) }.to raise_error('Negatives not allowed: [-3, -10]')
        expect { calculator.add(test_numbers3) }.to raise_error('Negatives not allowed: [-5, -1]')
      end
    end

    context "when has \e[34mnumbers biggers than 1000\e[0m" do
      let!(:test_numbers1) { '1,2,3000,3' }
      let!(:test_numbers2) { '1,\n2,1001,4' }
      let!(:test_numbers3) { '//@\n999@1@1000' }

      it 'must sum only numbers < 1000' do
        expect(calculator.add(test_numbers1)).to be(6)
        expect(calculator.add(test_numbers2)).to be(7)
        expect(calculator.add(test_numbers3)).to be(1000)
      end

      it 'must be integer result' do
        expect(calculator.add(test_numbers1)).to be_an(Integer)
        expect(calculator.add(test_numbers2)).to be_an(Integer)
        expect(calculator.add(test_numbers3)).to be_an(Integer)
      end
    end
  end
end
