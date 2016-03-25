# Sandbox

A base Vagrant setup, powered by [PuPHPet](https://puphpet.com/), for developing stuff.

## Requirements

* Vagrant >= 1.81
* VirtualBox >= 4.3.28

## Packages

* Vim
* Git
* Htop
* Memcached
* Nginx
* PHP (7)
* Drush
* Ruby
* Python
* NodeJS
* MySQL
* CouchDB
* MailHog

## Installation

Clone the repo down into a folder of your choice:

```
git clone git@github.com:danmrichards/sandbox.git myproject
```

Start up Vagrant:

```
vagrant up
```

Add the following entry to your hosts file; this will add the default vhost:

```
192.168.56.111 sandbox.dev www.sandbox.dev
```

## Usage

### Web server

The box is configured to use [Nginx](http://nginx.org/) as the web server. So the best place to go is their [documentation](http://nginx.org/en/docs/).

All web projects/sites need to be placed in the `shared/var/www/html` folder.

But basically you set up new virtual hosts in the following manner:

Copy the default vhost file.
```
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
```

Edit the copied vhost file to set up the new vhost:

```
sudo vi /etc/nginx/sites-available/example.com
```

Changes to make:
```
server {
        listen   80; ## listen for ipv4; this line is default and implied
        #listen   [::]:80 default ipv6only=on; ## listen for ipv6

        root /var/www/example.com/public_html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name example.com;
}
```

* Uncomment "listen 80" so that all traffic coming in through that port will be directed toward the site
* Change the root extension to match the directory that we made in Step One. If the document root is incorrect or absent you will not be able to set up the virtual host.
* Change the server name to your DNS approved domain name or, if you don't have one, you can use your IP address

Link the 'available' vhost to the enable vhost:

```
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
```

### Mailhog

This catches outgoing mail from any web projects. This can be managed by viewing the following URL in a browser - http://sandbox.dev:8025

### MySQL

Connect using SSH tunnel, username `vagrant` and SSH key generated at `puphpet/files/dot/ssh/id_rsa`.

### CouchDB

CouchDB is a NoSQL database that 'embraces the web', fancy! You can access the database endpoints at this URL - http://sandbox.dev:5984. And the configuration UI can be found here - http://sandbox.dev:5984/_utils
