#
# Cookbook Name:: gpg
# Recipe:: library
#
# Copyright 2011, Venda Ltd
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'gpgme' do
  action :nothing
end.run_action(:install)

require 'gpgme'
