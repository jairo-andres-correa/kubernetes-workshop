# Deployments #

1. Create a new namespace called `uat`
2. Create a new deployment called `front end` using the image `nginx`
3. Edit the deployment and modify the replicas to 3.
4. Check how many pods are running .
5. Log into the node 01. Use docker commands to stop one of the pods.
6. Go back to the master. How many pods are running?
7. Use other means, try to kill the pods in the node.
8. Use ` kubectl scale` to change the number of replicas to 5
9. Change the image of the deployment. Check all the objects that are created.