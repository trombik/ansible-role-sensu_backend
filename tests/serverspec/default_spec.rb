require "spec_helper"
require "serverspec"

package = "sensu-go-backend"
service = "sensu-backend"
config  = "/etc/sensu/backend.yml"
user    = "sensu"
group   = "sensu"
ports   = [3000, 8080, 8081]
log_dir = "/var/log/sensu"
db_dir  = "/var/lib/sensu"
cache_dir = "/var/cache/sensu/sensu-backend"
extra_packages = %w{sensu-go-cli}

case os[:family]
when "freebsd"
  config = "/usr/local/etc/sensu_backend.conf"
  db_dir = "/var/db/sensu_backend"
  extra_packages = []
end

describe package(package) do
  it { should be_installed }
end

extra_packages.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("Managed by ansible") }
  its(:content) { should match(/log-level: info/) }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 750 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(cache_dir) do
  it { should exist }
  it { should be_mode 750 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/sensu_backend") do
    it { should be_file }
  end
when "ubuntu"
  describe file("/etc/default/sensu-backend") do
    it { should be_file }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
