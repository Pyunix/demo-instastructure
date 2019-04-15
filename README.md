**DEMO-INFRASTRUCTURE**

BASIC USAGE:
    - vagrant up
    - vagrant ssh <vm-name>
    - vagrant halt
    - vagrant destroy -f

VM resources{CPU|RAM}:
    - chef-server    => 1|2
    - jenkins-server => 1|1
    - k8s-master     => 2|2
    - slave-nodes x3 => 3|3
    -   total        => 7|8
