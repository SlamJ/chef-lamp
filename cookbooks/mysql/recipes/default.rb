#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "mariadb-server" do
end

package "mariadb" do
end

service "mariadb" do
	action [:start, :enable]
end
