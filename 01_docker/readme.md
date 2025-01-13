# A simple static website
The sample.sh bash script simply creates a simple static website using the docker container and hosts the website on the local machine using nginx on port 7777. To run the script, simply run the following command:
```bash
chmod +x sample.sh
./sample.sh
```
The script will hold on "Do you want to clean up the resources after testing? (y/n): "
While testing, you can access the website by visiting http://localhost:7777. After testing, you can clean up the resources by typing "y" and pressing enter. If you want to keep the resources, type "n" and press enter.
