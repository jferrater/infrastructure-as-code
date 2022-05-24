Sample App for Learning Kubernetes
==================================
Create the configuration for the Counter App. We are going to start with the simplest possible configuration. Of course, it's far from perfect, but then we will improve it to achieve a fully highly available app.

v1 - simplest possible configuration - all in one
-------------------------------------------------
- create deployment called counter and run inside two containers using the following images: registry.kamilbaran.pl/training/kubernetes/httpd:latest and registry.kamilbaran.pl/training/kubernetes/mongo:latest

- use single label app = counter for all resources
- expose the app by creating a NodePort service called counter; both containers are using standard ports (httpd = 80, mongo = 27017)
- verify that you can connect to the app and identify at least two weak points of this configuration

v2 - run both containers in separated pods
------------------------------------------
- create two deployments and two services called counter-httpd and counter-mongo

- use two labels app and component for all resources (app = counter, component = httpd or mongo)
- set MONGO_CS environment variable for the httpd container, this variable defines the connection string to the database
- allow MongoDB to listen on all network interfaces (not only on the local loopback)
- verify that you can connect to the app, then scale httpd to 3 instances and identify at least one weak point of this configuration

v3 - expose the app using ingress
---------------------------------
- create ingress called counter that exposes the app using your-name.counter.local domain
- use proper labels
- verify that you can connect to the app by using curl and web browser (you may need to add an entry into /etc/hosts)

v4 - configure persistent volume to MongoDB container
----------------------------------------------------
- create 1GB volume and mount it as /data/db directory
- use the best type of volume available in the training cluster
- verify that your data is safe even if you destroy the mongo pod

v5 - configure secrets and configmaps
-------------------------------------
- create a secret called mongo-cs and put there a connection string that allows httpd to connect to the database
- consume the secret in the httpd pod as env variable

v6 - replace mongo deployment with StatefulSet
----------------------------------------------
- use the same names and labels as the deployment
- make sure that it will have properly configured persistent volume

v7 - configure MongoDB as a 3 node replica set
----------------------------------------------

v8 - add scheduling rules
-------------------------
- make sure that mongo pods will always run on different workers
- configure httpd to prefer to run on different workers

v9 - add network policies
-------------------------
- create policy default-deny-ingress that deny all ingress traffic
- create policy counter-httpd that allows connections on port 80 to all httpd pods
- create policy counter-mongo that allows connections on port 27017 from all mongo (needed for data replication) and all httpd pods