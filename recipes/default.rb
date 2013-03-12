#
# Cookbook Name:: gpg
# Recipe:: default
#
# Copyright 2011, Venda Ltd
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'systemu' do
  action :nothing
end.run_action(:install)

require 'etc'
require 'systemu' # need to supply stdin, but Mixlib::ShellOut can't.

include_recipe "vt-gpg::library"

package "gnupg" do
  action :nothing
end.run_action(:upgrade)

user_home = Etc.getpwnam(node['gpg']['user']).dir
gpg_home = File.join(user_home, node['gpg']['homedir'])

directory gpg_home do
  owner node['gpg']['user']
  action :nothing
end.run_action(:create)

search(node[:gpg][:keys_data_bag]) do |key|

  # Import the key:

  status = systemu(
    "gpg --homedir #{gpg_home} --import",
    0 => key['public_key'],
    1 => stdout = '',
    2 => stderr = ''
  )
  if status != 0
    Chef::Log.error("vt-gpg: #{stdout} #{stderr}")
  end

  # Mark it as ultimately trusted:

  status = systemu(
    "gpg --homedir #{gpg_home} --import-ownertrust",
    0 => "#{key['fingerprint']}:6:\n",
    1 => stdout = '',
    2 => stderr = ''
  )
  if status != 0
    Chef::Log.error("vt-gpg: #{stdout} #{stderr}")
  end

end
