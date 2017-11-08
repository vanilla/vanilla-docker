## Make unit tests work within PhpStorm

### Configure Docker

`PhpStorm` > `Preferences` > `Build, Execution, Deployment` > `Docker`

Add a new docker instance and choose "Docker for Mac"

`PhpStorm` > `Preferences` > `Languages & Frameworks` > `PHP`

Click on `...` which is located beside "CLI Interpreter".

Add a new instance with the following configuration:

![CLI Interpreter Configurations](./images/unittests-cli-interpreter.png)

### Add Test Framework configuration

This example works to run the unit tests of Vanilla.

`PhpStorm` > `Preferences` > `Languages & Frameworks` > `PHP` > `Test Frameworks`

- Add a new instance and choose: PHPUnit by Remote Interpreter
- Select vanilladocker_php

![Test framework](./images/unittests-test-framework.png)

### Export environment variable

Export TEST_DB_HOST=database so that unit tests know the host for the database inside the php-fpm container.

If you are using bash (that's the default on Mac OSX) you can do:
```bash
echo "export TEST_DB_HOST=database" >> ~/.bash_profile
```

### Running the tests

- Open [https://github.com/vanilla/vanilla](vanilla/vanilla) with PhpStorm
- `Run` > `Edit Configurations...`
- Add a new `PHPUnit` by clicking on the `+` button.
- Name it "Vanilla tests" and, under `Test Runner`, choose `Defined in the configuration file`
