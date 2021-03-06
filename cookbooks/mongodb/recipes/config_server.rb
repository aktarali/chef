#
# Cookbook Name:: mongodb
# Recipe:: config_server
#
# Copyright 2015, Jonathan Klinginsmith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'mongodb::repo'

mongodb_config_server_port = node['mongodb']['config_server_port']

package 'mongodb-org-server' do
  action :install
end

template '/etc/mongod.conf' do
  source 'config_server.erb'
  mode '0644'
  variables(
    config_server_port: mongodb_config_server_port
  )
end

service 'mongod' do
  action [:enable, :start]
end
