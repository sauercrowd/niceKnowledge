# Gogs
## Ubuntu Installatiom
do things as proposed here https://packager.io/gh/pkgr/gogs/install?bid=413#ubuntu-14-04-gogs

edit /etc/gogs/conf/app.ini. important:
```
    DOMAIN=     //the domain of your server
    ROOT_URL=   //specifies where your gogs server is running, important if your proxying it in a suburl
    HTTP_ADDR=  //the address where the server is reachable
    HTTP_PORT= //the port where your server is running on
```
