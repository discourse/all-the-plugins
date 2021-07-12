# All the plugins

A meta repository with links to every Discourse plugin that kind of works and that we know about.

### Why this repo exists?

Occasionally we need to deprecate extensibility interfaces or migrate to newer and better patterns. We use this meta repository to search through all plugins when doing such work.

### Getting started with the meta repo

```
git clone https://github.com/discourse/all-the-plugins.git
cd all-the-plugins
git submodule update --init --recursive
```

### Contributing your own plugin

If you have a plugin you would like included in the meta repo create a PR with the new submodule.

To add it

```
git submodule add -b main https://github.com/your-user/your-plugin plugins/your-plugin
```

Ensure the submodule is cloned into the `plugins` directory. Also, please make sure you publish your plugin at:

https://meta.discourse.org/c/plugin

### Updating a plugin

Once in a while we will run

```
git submodule update --recursive --remote
```

If you would like to speed up our update process, submit a PR with updated submodules

### Update from meta script

At the root of the repo we have the `update_from_meta.rb` script, this can be used to pull all the github repos in the #plugins category in meta.
