# Directory Based Development on vanilla.localhost

With this configuration option, you can develop against [https://vanilla.localhost/dev](https://vanilla.localhost/dev). You can also replace the `/dev` directory with any directory name to create a new development site.

## Installation

This is a newer config so you will have to go through the steps of enabling the nginx config again.

1. Symlink [bootstrap.before.php](../bootstrap.before.php) into Vanilla's `/conf` directory. If you have your own custom bootstrap.before.php then you can symlink this version as a different name and require it inside yours.
2. Restart docker or call `docker container exec nginx nginx -s reload` to load the new config.
3. Browse to [https://vanilla.localhost/dev](https://vanilla.localhost/dev). You should see Vanilla's setup page.

## Upgrading

If you want to switch your current development site from [https://dev.vanilla.localhost](https://dev.vanilla.localhost) you can copy its config to `/conf/vanilla.localhost/dev.php`.

## Multiple sites

Every time you browse to a different root directory on [https://vanilla.localhost](https://vanilla.localhost) you will get a new installation page. This allows you to have multiple sites on your localhost without having to configure a new host each time.

Multiple sites are supported by the `bootstrap.before.php` that is shipped in this repo. All it does is change the config path for the site to a file based on the directory the site is in. If you want to change your site's config then browse to `/conf/vanilla.localhost` and look for the appropriate file there.