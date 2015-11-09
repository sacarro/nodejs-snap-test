# nodejs-snap-test
Testing node-snapper / snappy to create a nodejs microservice

_This information is recorded from a Ubuntu GNOME 15.10 (xenial) development environment_

##Setup node-snapper##
_This assumes a standard Ubuntu development environment where .profile adds $HOME/bin to $PATH_


 1. mkdir ~/bin
 2. cd ~/bin
 3. bzr branch lp:node-snapper
 4. source ~/.profile
 5. sudo apt-get install distro-info
 6. sudo ~/bin/node-snapper express
 7. tar xf amd64-dir.tgz
   
   _Note that there is an armh.tgz here too I just don't have an env to support it_
   
 8. rm *.tgz
 9. vi server.js

    ```
    var express = require('express');
    var app = express();

    app.get('/', function (req, res) {
        res.send('Hello World!');
    });

    var server = app.listen(3000, function () {
        var host = server.address().address;
        var port = server.address().port;
        console.log('Example app listening at http://%s:%s', host, port);
    });
    ```
    
12. mkdir meta
13. cd meta
14. vi package.yaml
    
    ```
    name: nodejs-snap-test
    vendor: Sam Carroll <samuel.carroll@inficon.com>
    architecture: [amd64, armhf]
    version: 0.0.1
    services:
    - name: microservice
        description: "A simple example of a microservice."
        start: start-service.sh
        ports:
            external:
                ui:
                    port: 6565/tcp
                    negotiable: no
    ```
    
15. vi readme.md
    
    ```
    Simple microservice that responds with "hello world"
    ```
    
16. cd ../
17. snappy build
18. vi Vagrantfile # assumes vagrant setup for ubuntu core snappy 
    
    ```
    ...
    # Add this line inside of the Vagrant.configure(2) do |config| section
    config.vm.network "forwarded_port", guest: 6565, host: 6565
    ...
    ```
    
19. vagrant up  
20. snappy-remote --url=ssh://127.0.0.1:2222 install nodejs-snap-test\_0.0.1\_multi.snap # This assumes the vargrant machine is running and has started ssh on port 2222
