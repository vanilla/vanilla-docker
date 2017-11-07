## Make unit tests work within PhpStorm

### Configure PhpStorm

`PhpStorm` > `Preferences` > `Build, Execution, Deployment` > `Docker`

Add a new docker instance and choose "Docker for Mac"

`PhpStorm` > `Preferences` > `Languages & Frameworks` > `PHP`

Click on `...` which is located beside "CLI Interpreter".

Add a new instance with the following configuration:

![CLI Interpreter Configurations](./images/unittests-cli-interpreter.png)

### PHPUnit configuration

This example works to run the unit tests of Vanilla.

.....


#### Export environment variable

Export TEST_DB_HOST=database so that unit tests know the host for the database inside the php-fpm container.

If you are using bash (that's the default on Mac OSX) you can do:
```bash
echo "export TEST_DB_HOST=database" >> ~/.bash_profile
```

