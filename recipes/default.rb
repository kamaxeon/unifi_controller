#
# Cookbook Name:: unifi_controller
# Recipe:: default
#
# Copyright (C) 2016  The Authors
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


# CentOS 6.x

include_recipe 'yum'

## Install java

package 'java-1.8.0-openjdk-headless.x86_64'

## Install mongo repo

yum_repository 'mongodb' do
  description 'MongoDB Repository'
  baseurl 'http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/'
  gpgcheck false
  action :create
end

%w(mongo-10gen mongo-10gen-server).each do |pkg_name|
  package pkg_name
end

package 'mongo-10gen-server' do
  notifies :restart, 'service[mongod]', :immediately
end



## Download the Unifi Controller Software

package 'unzip'
package 'rsync'

version = '4.8.15'
ark 'unifi' do
  url "https://www.ubnt.com/downloads/unifi/#{version}/UniFi.unix.zip"
  version version
  home_dir '/opt/UniFi'
  append_env_path false
  action :install
end

## Create Unifi Service 
template 'UniFi Service' do
  source 'CentOS6_UniFi_Service.erb'
  path '/etc/init.d/unifi'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[unifi]', :immediately
end


## Services

service 'unifi' do
    supports status: true, restart: true, reload: true
      action [:enable, :start]
end

service 'mongod' do
    supports status: true, restart: true, reload: true
      action [:enable, :start]
end
