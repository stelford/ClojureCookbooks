execute "git clone git://github.com/stelford/ClojureSkeleton.git"
  cwd "/home/vagrant"
end

execute "nohup lein2 trampoline run"
  cwd "/home/vagrant/ClojureSkeleton"
end
