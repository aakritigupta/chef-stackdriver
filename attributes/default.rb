# Cookbook Name:: stackdriver
# Attributes:: default
#
# Copyright (C) 2013-2014 TABLE_XI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

default[:stackdriver][:action] = :upgrade
default[:stackdriver][:api_key] = ''
default[:stackdriver][:config_collectd] = true
default[:stackdriver][:enable] = true
default[:stackdriver][:gen_hostid] = false
default[:stackdriver][:tags] = {}
default[:stackdriver][:gpg_key] = 'https://app.stackdriver.com/RPM-GPG-KEY-stackdriver'

case node[:platform]
when 'amazon'
  if node[:platform_version].to_f > 2012.09
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/stackdriver-amazonlinux.repo'
  else
    default[:stackdriver][:repo_url] = 'https://repo.stackdriver.com/stackdriver-el6.repo'
  end
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'centos', 'redhat', 'scientific'
  default[:stackdriver][:repo_url] = "https://repo.stackdriver.com/stackdriver-el#{node['platform_version'].to_i}.repo"
  default[:stackdriver][:config_path] = '/etc/sysconfig/stackdriver'
when 'ubuntu'
  case node[:platform_version]
  when '10.04'
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
    default[:stackdriver][:repo_dist] = 'lucid'
  when '12.04', '12.10', '13.10'
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
    default[:stackdriver][:repo_dist] = 'precise'
  when '14.04'
    default[:stackdriver][:repo_url] = 'http://repo.stackdriver.com/apt'
    default[:stackdriver][:repo_dist] = 'trusty'
  end
  default[:stackdriver][:config_path] = '/etc/default/stackdriver-agent'
end
