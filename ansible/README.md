## Deploying with Ansible

This ansible script creates the VCL application on a remote server. The remote server is AWS-EC2 machine. The application is python-django based and the code for the application is on github: https://github.com/UMD-DCIC/vcl-dashboard.git

To change the host IP address, edit vcl-webservers group in your ansible hosts file and put in the IP address of the remote server you want the application to be installed on.


The ansible playbook site.yml includes 3 roles - base, db, and web. Each role is in its respective folder in the ‘roles’ folder. The value of the variables can be changed from env_vars folder.

In order to run the unusable script run the following command:

    ansible-playbook -i /path/to/host/file site.yml
