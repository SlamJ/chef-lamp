default["apache"]["sites"]["samueljjennings-gmail-com2"] = { "site_title" => "Sam2s website coming soon", "port" => 80, "domain" => "samueljjennings-gmail-com2.mylabserver.com" } 
default["apache"]["sites"]["samueljjennings-gmail-com2b"] = { "site_title" => "Sam2sb website be here soon mane", "port" => 80, "domain" => "samueljjennings-gmail-com2b.mylabserver.com"}
default["apache"]["sites"]["samueljjennings-gmail-com3.mylabserver.com"] = { "site_title" => "Site of da ubuntu", "port" => 80, "domain" => "samueljjennings-gmail-com3.mylabserver.com" }

default["author"]["name"] = "sam"

case node["platform"]
when "centos"
	default["apache"]["package"] = "httpd"
when "ubuntu"
	default["apache"]["package"] = "apache2"
end
