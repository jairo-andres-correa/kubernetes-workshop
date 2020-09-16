# Pods exploration

## Creation and inspection ##

1. Create the namespace `lab2`.
2. In the namespace `lab2` create a new Pod named `webserver` with the image `nginx:2.3.11`. Expose the port 80.
3. There is an error. Identify the issue with creating the container. Write down the root cause of issue in a file named `web-error.log`.
4. Change the image of the Pod to `nginx:1.15.12`.
5. List the Pod and ensure that the container is running.
6. Log into the container and run the `ls` command. Write down the output. Log out of the container.
7. Retrieve the IP address of the Pod `webserver`.
8. Run a temporary Pod using the image `busybox`, shell into it and run a `wget` command against the `nginx` Pod using port 80.
9. Render the logs of Pod `webserver`.
10. Delete the Pod and the namespace.