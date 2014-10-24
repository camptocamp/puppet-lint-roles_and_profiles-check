require 'spec_helper'

describe 'roles_class_params' do
  let(:msg) { 'expected no class parameters' }

  context 'when class is not a role' do
    context 'with parameters' do
      let(:code) do
        <<-EOS
class foo(
  $bar = 'bar',
) {
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'when class is a role' do
    context 'with no parameters' do
      let(:code) do
        <<-EOS
class roles::foo {
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with empty parenthesis' do
      let(:code) do
        <<-EOS
class roles::foo(
) {
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with one parameter' do
      let(:code) do
        <<-EOS
class roles::foo(
  $bar = 'bar',
) {
}
        EOS
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
      end
    end

    context 'with two parameters' do
      let(:code) do
        <<-EOS
class roles::foo(
  $bar = 'bar',
  $baz = 'baz',
) {
}
        EOS
      end

      it 'should detect two problems' do
        expect(problems).to have(2).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
        expect(problems).to contain_warning(msg).on_line(3).in_column(3)
      end
    end
  end
end
