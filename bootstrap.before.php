<?php
/**
 * This file will make Vanilla use a different config depending on folder you're on.
 */
call_user_func(function () {
    $host = $_SERVER['HTTP_HOST'];
    [$host, $port] = explode(':', $host, 2) + ['', ''];

    // Whitelinst to a domain. This can probably get removed at some point.
    if (!in_array($host, ['vanilla.localhost'], true)) {
        return;
    }

    // This domain treats the root directory as its own virtual root.
    [$root, $_] = explode('/',ltrim($_SERVER['SCRIPT_NAME'], '/'), 2) + ['', ''];
    // Use a config specific to the site.
    $configPath = PATH_ROOT."/conf/$host/$root.php";
    if (!file_exists(dirname($configPath))) {
        mkdir(dirname($configPath), 0755, true);
    }

    define('PATH_CONF_DEFAULT', $configPath);
});