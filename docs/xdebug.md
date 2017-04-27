# Make PhpStorm work with Xdebug

`Languages & Frameworks` > `PHP` > `Debug` > `DBGp Proxy`

- `IDE Key`: PHPSTORM
- `Host`: machinehost
- `Port`: 9000

Install an [Xdebug helper](https://confluence.jetbrains.com/display/PhpStorm/Browser+Debugging+Extensions)
on your browser and set the key to PHPSTORM.

You can now click on the `Start listening for PHP Debug connection` button in PhpStorm and enable the browser extension.
On the first run it will ask you to map your local directories to the docker directories, 
but after that nothing will be required anymore.

Have fun!
