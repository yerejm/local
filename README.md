# Local

## OS X
```
curl -s -L https://github.com/yerejm/local/archive/master.zip | bsdtar -xvf- && caffeinate bash local-master/setup.sh
```

# Linux (Debian)
```
sudo apt-get install -y bsdtar
curl -s -L https://github.com/yerejm/local/archive/master.zip | bsdtar -xvf- && bash local-master/setup.sh
```
