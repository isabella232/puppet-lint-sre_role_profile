require 'spec_helper'

describe 'sre_roles_include_profiles' do
  let(:msg) { 'roles must only `include profiles`' }
  context 'role without body' do
    let(:code) { 'class role() {}' }
    it 'should not be a problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'nested role without body' do
    let(:code) { 'class role::example() {}' }
    it 'should not be a problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'role including a profile' do
    let(:code) { 'class role() { include profile::example }' }
    it 'should not be a problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'role including a another role' do
    let(:code) { 'class role() { include role::example }' }
    it 'should be a problem' do
      expect(problems).to have(1).problem
    end
  end

  context 'role including a topscope profile' do
    let(:code) { 'class role() { include ::profile::example }' }
    it 'should be a problem' do
      expect(problems).to have(1).problem
    end
  end

  context 'role resource like profile' do
    let(:code) { "class role() { class { 'profile::example': } }" }
    it 'should be a problem' do
      expect(problems).to have(1).problem
    end
  end

  context 'role with profiles mixed include and resource-like' do
    let(:code) do
      <<-EOL
class role::test {
include profile::abc
class { 'profile::def': }
include profile::xyz
}
EOL
    end
    it 'should be a problem' do
      expect(problems).to have(1).problem
    end
  end

  context 'role with non profiles mixed include and resource-like' do
    let(:code) do
      <<-EOL
class role::test {
include profile::ssh
include ssh::abc
class { 'mysql::def': }
include profile::xyz
# include xyz
}
EOL
    end
    it 'should be a problem' do
      expect(problems).to have(2).problem
    end
  end

  context 'role with conditional logic' do
    let(:code) do
      <<-EOL
class role::test {
if $x == 1 {
  include profile::ssh
}
include profile::xyz
}
EOL
    end
    it 'should not be a problem' do
      expect(problems).to have(0).problem
    end
  end
end
