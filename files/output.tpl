
Bastion Public IP (for DNS): ${bastion_public_ip}
Jenkins Public IP (for DNS): ${jenkins_public_ip}

Execute the following steps, in this order, to create a tunnel to the spinnaker instance and an example pipeline:

1.	In a separate window, start up the Spinnaker tunnel:
	--- cut ---
	ssh -o IdentitiesOnly=yes -i ${private_key} -L 9000:localhost:9000 -L 8084:localhost:8084 -L 8087:localhost:8087 ${ssh_user}@${bastion_public_ip} 'ssh -o IdentitiesOnly=yes -i /home/${ssh_user}/.ssh/id_rsa -L 9000:localhost:9000 -L 8084:localhost:8084 -L 8087:localhost:8087 -A ${ssh_user}@${spinnaker_private_ip}'
	--- end cut ---

2.	If the previous command fails with this message:
	--- cut ---
	Host key verification failed.
	--- end cut ---

	Run this command and then re-run the tunnel command:
	--- cut ---
	ssh -o IdentitiesOnly=yes -i ${private_key} ${ssh_user}@${bastion_public_ip} 'ssh-keyscan -H ${spinnaker_private_ip} >> ~/.ssh/known_hosts'
	--- end cut ---

3.	Go to http://${jenkins_public_ip}/ (This is Jenkins) in your browser and login with the credentials you set in terraform.tfvars.

4.	Go to http://localhost:9000/ (This is Spinnaker) in a separate tab in your browser. This is the tunnel to the new Spinnaker instance.

5.	On Jenkins, choose the job "Package_example_app" and "build now"
	NOTE: sometimes the build fails with gradle errors about being unable to download dependencies.

6.	When the Jenkins build is done, go to the spinnaker instance in your browser, select 'appname', and then 'Pipelines'. The pipeline should automatically start after the jenkins job is complete.
	It will bake an AMI, then deploy that AMI.

7.	Instructions here about how to view that fancy example app you just launched.