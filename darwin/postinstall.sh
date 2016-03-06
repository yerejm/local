if ! grep cachier "$HOME/.vagrant.d/plugins.json" > /dev/null; then
  vagrant plugin install vagrant-cachier
fi
if ! grep hostsupdater "$HOME/.vagrant.d/plugins.json" > /dev/null; then
  vagrant plugin install vagrant-hostsupdater
fi
