#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Defines package and then package_name will install based off of apache package
if node["platform"] == "ubuntu"
	execute "apt-get update -y" do
	end
end

package "apache2" do
	package_name node["apache"]["package"]
end

#Set the document root 
node["apache"]["sites"].each do |sitename, data|
	document_root = "/content/sites/#{sitename}"

	directory document_root do
		mode "0755"
		recursive true
	end

#If node is ubuntu here is the /etc where it should edit
if node["platform"] == "ubuntu"
	template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
elsif node["platform"] == "centos"
	template_location = "/etc/httpd/conf.d/#{sitename}.conf"
end

#This sets takes the vhost.erb attribute and pushes it based off of the document root defined above and the port and domain located within the data hash in the attribute file.
template template_location do
	source "vhost.erb"
	mode "0644"
	variables(
		:document_root => document_root,
		:port	 => data["port"],
		:domain  => data["domain"]
	)
	notifies :restart, "service[httpd]"	
end
#This puts index.html in the document root based off of what is in the index.html.erb file and sets the title and the message
template "/content/sites/#{sitename}/index.html" do
	source "index.html.erb"
	mode "0644"
	variables(
		:site_title => data["site_title"],
		:comingsoong => "coming soon!"	
	)	
end
end
#This removes the welcome.conf message in the apache folder
execute "rm /etc/httpd/conf.d/welcome.conf" do
	only_if do
		File.exist?("/etc/httpd/conf.d/welcome.conf")
	end
end
#This removes the README file if it exists from the conf.d folder 
execute "rm /etc/httpd/conf.d/README" do
	only_if do
		File.exist?("/etc/httpd/conf.d/README")
	end

end


service "httpd" do
	service_name node["apache"]["package"]
	action [:enable, :start]
end


#include_recipe "php::default"
