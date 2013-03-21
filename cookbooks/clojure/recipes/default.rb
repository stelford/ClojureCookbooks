#
# Cookbook Name:: clojure
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

u = node[:clojure][:user]
g = node[:clojure][:group]
home_dir = node[:clojure][:home_dir]
clp = node[:clojure][:classpath]

directory "#{home_dir}/bin" do
   owner u
   group g
end

directory "#{home_dir}/.clojure_libs" do
   owner u
   group g
end

%w{lein2}.each do |bin_file|
  cookbook_file "#{home_dir}/bin/#{bin_file}" do
    source "#{bin_file}"
    owner u
    group g
    mode "0755"
  end
end

%w{clojure-1.4.0.zip}.each do |bin_file|
  cookbook_file "#{home_dir}/.clojure_libs/#{bin_file}" do
    source "#{bin_file}"
    owner u
    group g
    mode "0755"
  end
end

execute "Update Java Classpath" do
   command "echo '#{clp}' >> #{home_dir}/.bashrc"
   action :run
   not_if "grep 'CLASSPATH=' #{home_dir}/.bashrc"
end

execute "Installing Lein2" do
   command "su #{u} -l -c '#{home_dir}/bin/lein2 self-install'"
   action :run
   not_if do File.directory?"#{home_dir}/.lein" end
end

