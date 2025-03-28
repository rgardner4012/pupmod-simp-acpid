require 'spec_helper_acceptance'

test_name 'acpid class'

describe 'acpid class' do
  let(:manifest) do
    <<-EOS
      include '::acpid'
    EOS
  end

  hosts.each do |host|
    context "on #{host}" do
      # Using puppet_apply as a helper
      it 'works with no errors' do
        apply_manifest(manifest, catch_failures: true)
      end

      it 'is idempotent' do
        apply_manifest(manifest, { catch_changes: true })
      end

      describe package('acpid') do
        it { is_expected.to be_installed }
      end

      describe service('acpid') do
        it { is_expected.to be_enabled }
        it { is_expected.to be_running }
      end
    end
  end
end
