# All the plugins

A meta repository with links to every Discourse plugin that kind of works and the we know about.

### Why this repo exists?

Occationally we need to deperecate extensibility interfaces or migrate to newer and better patterns. We use this meta repository to search through all plugins when doing such work.

### Getting started with the meta repo

```
git clone https://github.com/discourse/all-the-plugins.git
cd all-the-plugins
git submodule init
git submodule update
```

### Contributing your own plugin

If you have a plugin you would like included in the meta repo create a PR with the new submodule.

To add it

```
git submodule add https://github.com/your-user/your-plugin.git plugins/your-plugin
```

Ensure the submodule is cloned into the `plugins` directory. Also, please make sure you publish your plugin at:

https://meta.discourse.org/c/plugin

