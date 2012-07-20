#
# Cookbook Name:: gpg
# Recipe:: default
#
# Copyright 2011, Venda Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe "gpg::library"

package "gnupg" do
  action :nothing
end.run_action(:upgrade)

search(node[:gpg][:keys_data_bag]) do |key|

  # Import the key:

  IO.popen(['gpg', '--homedir', '/root/.gnupg', '--import'], 'w') do |io|
    io.puts key['public_key']
  end

  # Mark it as ultimately trusted:

  IO.popen(['gpg', '--homedir', '/root/.gnupg', '--import-ownertrust'], 'w') do |io|
    io.puts "#{key['fingerprint']}:6:"
  end

end
