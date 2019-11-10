<?php

require_once __DIR__ . "/resources/sphinx/sphinxapi.php";

/**
 * This file will make Vanilla use a different config depending on folder you're on.
 */
call_user_func(function () {
    $host = $_SERVER['HTTP_HOST'];
    [$host, $port] = explode(':', $host, 2) + ['', ''];

    // Whitelist to a domain. This can probably get removed at some point.
    if (in_array($host, ['dev.vanilla.localhost'], true)) {
        // This is the default conf/config.php based install.
        return;
    } elseif (!in_array($host, ['vanilla.localhost'], true)) {
        // This is a conf/{$host}.php based install.
        $configPath = PATH_ROOT . "/conf/$host.php";
    } else {
        // This domain treats the root directory as its own virtual root.
        [$root, $_] = explode('/', ltrim($_SERVER['SCRIPT_NAME'], '/'), 2) + ['', ''];
        // Use a config specific to the site.
        $configPath = PATH_ROOT . "/conf/$host/$root.php";
    }

    if (!file_exists(dirname($configPath))) {
        mkdir(dirname($configPath), 0755, true);
    }

    define('PATH_CONF_DEFAULT', $configPath);
});
