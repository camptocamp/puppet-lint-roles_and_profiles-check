require 'spec_helper'

describe 'roles_resource_declaration' do
  let(:msg) { 'expected no resource declaration' }

  context 'when class is not a role' do
    context 'with parameters' do
      let(:code) do
        <<-EOS
class foo(
  $bar = 'bar',
) {
  baz { 'baz': }
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'when class is a role' do
    context 'with no tokens' do
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

    context 'with profile declaration' do
      let(:code) do
        <<-EOS
class roles::foo {
  class { 'profiles::bar': }
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with ::profile declaration' do
      let(:code) do
        <<-EOS
class roles::foo {
  class { '::profiles::bar': }
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with any class declaration' do
      let(:code) do
        <<-EOS
class roles::foo {
  class { 'bar': }
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
      end
    end

    context 'with profile inclusion' do
      let(:code) do
        <<-EOS
class roles::foo {
  include profiles::bar
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with ::profile inclusion' do
      let(:code) do
        <<-EOS
class roles::foo {
  include ::profiles::bar
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'with any class inclusion' do
      let(:code) do
        <<-EOS
class roles::foo {
  include bar
}
        EOS
      end

      it 'should not detect any problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(2).in_column(3)
      end
    end

    context 'with one resource' do
      let(:code) do
        <<-EOS
class roles::foo {
  include profiles::bar
  bar { 'bar': }
}
        EOS
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(3)
      end
    end

    context 'with two resources' do
      let(:code) do
        <<-EOS
class roles::foo {
  include profiles::bar
  bar { 'bar': }
  quux { 'quux': }
}
        EOS
      end

      it 'should detect two problem' do
        expect(problems).to have(2).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(3).in_column(3)
        expect(problems).to contain_warning(msg).on_line(4).in_column(3)
      end
    end
  end
end
