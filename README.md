Vagrant Box for Apache2 and PHP5.3
=================================

Introduction
------------

Running an old version of PHP can be a little tricky without a virtual machine. Since PHP5.3 is no longer
supported i've created this Vagrant Box to facilite the developpement of apps who need 5.3 and don't support >=5.4

Installation
------------

```
host $ git clone git@github.com:yadomi/apache2-php53.git
host $ cd apache2-php53
host $ vagrant up
```

What's In The Box
-----------------

- Ubuntu 12.04 (Precise64)
- Apache2 (2.2.22)
- PHP 5.3 (5.3.10-1ubuntu3.15)

MySQL 5.5 is not installed by default. You can enabled by uncomment the lines in [bootstrap.sh](https://github.com/yadomi/apache2-php53/blob/master/bootstrap.sh)

You may also take look in the [bootstrap.sh](https://github.com/yadomi/apache2-php53/blob/master/bootstrap.sh) for more informations.