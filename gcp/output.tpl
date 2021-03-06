
Bastion Public IP (for DNS): ${bastion_ip}

Region: ${region}
Zone: ${zone}
Network: ${network}
STATEPATH: ${kenzan_statepath}

Execute the following steps, in this order, to create a tunnel to the spinnaker instance and an example pipeline:

1.	Start up the Spinnaker tunnel:
	--- cut ---
	cd support ; ./tunnel.sh -a start -s ${kenzan_statepath}
	--- end cut ---

2.	Go to http://localhost:9090/ (This is Jenkins) in your browser and login with the credentials you set in terraform.tfvars.

3.	Go to http://localhost:9000/ (This is Spinnaker) in a separate tab in your browser. This is the tunnel to the new Spinnaker instance.

4.	On Jenkins, choose the job "TestJob2" and "build now"
	NOTE: sometimes the build fails with gradle errors about being unable to download dependencies. If that happens try building again.

5.	When the Jenkins build is done, go to the spinnaker instance in your browser, select 'appname', and then 'Pipelines'. The pipeline should automatically start after the jenkins job is complete.
	It will bake an image, then deploy that image.

6.	Run the following command and it will give you a URL where you can access the example app that was launched in the previous step (if it was deployed successfully):
	--- cut ---
	cd support ; ./get_lb_url.py gcp testappname-test 7070
	--- end cut ---
	NOTE: it may take a few minutes before the instance is available in the load balancer.