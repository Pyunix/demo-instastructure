PROVIDER = :virtualbox
IMAGE = "ubuntu/xenial64"
PROVISONER = :ansible_local

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

#    config.vm.define "chef-server" do |chefserver|
#        chefserver.vm.box = IMAGE
#        chefserver.vm.network "private_network", ip: "192.168.50.15"
#        chefserver.vm.hostname = "chef-server.vagrant.com"
#        chefserver.vm.provider PROVIDER do |vbc|
#            vbc.customize ["modifyvm", :id, "--memory", "2048"]
#            vbc.customize ["modifyvm", :id, "--cpus", "1"]
#        end
#        chefserver.vm.provision PROVISONER do |ansible|
#            ansible.playbook = "chef-setup/chef-server.yml"
#        end
#    end

#    config.vm.define "jenkins-server" do |jenkins|
#        jenkins.vm.box = IMAGE
#        jenkins.vm.network "private_network", ip: "192.168.50.20"
#        jenkins.vm.hostname = "jenkins-server.vagrant.com"
#        jenkins.vm.provider PROVIDER do |vbc|
#            vbc.customize ["modifyvm", :id, "--memory", "1024"]
#            vbc.customize ["modifyvm", :id, "--cpus", "1"]
#        end
#        jenkins.vm.provision PROVISONER do |ansible|
#            ansible.playbook = "jenkins-setup/jenkins.yml"
#        end
#    end

    config.vm.define "nfs-server" do |nfs|
        nfs.vm.box = IMAGE
        nfs.vm.network "private_network", ip: "192.168.50.15"
       nfs.vm.hostname = "nfs-server.vagrant.com"
       nfs.vm.provider PROVIDER do |nfsc|
           nfsc.customize ["modifyvm", :id, "--memory", "1024"]
           nfsc.customize ["modifyvm", :id, "--cpus", "1"]
       end
           nfs.vm.provision "shell", path: "nfs-server/nfs-bootstrap.sh", privileged: true
    end

    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master.vagrant.com"
        master.vm.synced_folder "./kube-demo-deploy", "/home/vagrant/kube-test"
        master.vm.provider PROVIDER do |vbm|
            vbm.customize ["modifyvm", :id, "--memory", "2048"]
            vbm.customize ["modifyvm", :id, "--cpus", "2"]
        end
        master.vm.provision PROVISONER do |ansible|
            ansible.playbook = "kubernetes-setup/master-playbook.yml"
            ansible.extra_vars = { node_ip: "192.168.50.10", }
        end
    end

    (1..2).each do |i|
        config.vm.define "slave-node-#{i}" do |slave|
            slave.vm.box = IMAGE
            slave.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            slave.vm.hostname = "slave-node-#{i}.vagrant.com"
            slave.vm.provider PROVIDER do |vbs|
                vbs.customize ["modifyvm", :id, "--memory", "2024"]
                vbs.customize ["modifyvm", :id, "--cpus", "2"]
            end
            slave.vm.provision PROVISONER do |ansible|
                ansible.playbook = "kubernetes-setup/node-playbook.yml"
                ansible.extra_vars = { node_ip: "192.168.50.#{i + 10}", }
            end
        end
    end
end
