![](https://raw.githubusercontent.com/GeoQuiz-v2/documents/master/client_app_logo/logo_128.png)

# GeoQuiz


TBD


## Docker
[![](https://raw.githubusercontent.com/GeoQuiz-v2/documents/master/res/docker.png)](https://docs.docker.com/)

An Docker image with the required environment is provided. Not exhaustively, this image contains :
- Android SDK and tools
- Flutter SDK
- Jenkins

You can use this image to **build** the application but also to **develop** inside a running container environment with VSCode. A script is provided to launch a container with the application project directory mounted inside this container file system.

##### Download the image
The image is available in [Docker Hub](https://hub.docker.com/repository/docker/romainguillot/geoquiz) :
```
docker pull romainguillot/geoquiz-app
```

##### Launch a container
Create a container named *geoquiz-app-container* :
```
./docker-create.sh
```
Note: It will mount the application folder into `home/developer/app`, it will mount the folder `/dev/bus/usb` at the same location, and expose the container on the 8080 port.

Start the container previously created (in an interactive mode here)  :
```
docker start -i geoquiz-app-container
```

Then, the application folder if mount into `/home/developer/app`, so for example, to run the application :
```
cd app
flutter pub get
flutter run
```

If the error message *No connected devices* appear, refer you to the **Others > Troubleshooting : no connected devices** part above.


##### Developing inside a container environment (VSCode Remote - Container)

1. Install the extension **[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)**
2. Launch a container (see above)
3. Open VSCode
4. In the command palette execute the following command : `>remote-Containers:Attach to Running Container...`
5. Select the running container

VSCode is now running in the container environment, you can so open the app folder inside the VSCode : `/home/developer/app/`.

Refer to **Other > Troubleshooting : VSCode, unable to find packages** if you vscode cannot find some packages.

##### Others
**Build image from the Dockerfile**  
```
cd [APP DIRECTORY]
docker build -t geoquiz-app .
```

**Troubleshooting : *no connected devices***
⚠️  If *No connected devices* appear, it's probably because the device is already connected to the host adb server. Disconnect the device from your host machine :
```
adb kill-server   # run the command on the host machine !
```

**Troubleshooting : VSCode, unable to find packages**  
In the terminal (in the container):
```
flutter clean
flutter pub get
```
Restart vscode.

**Useful commands**  
```
docker images   # list all images
```
