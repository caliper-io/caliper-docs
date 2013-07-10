## AMD / RequireJS

Since `caliper.backbone.js` v0.3.0, [AMD](https://github.com/amdjs/amdjs-api/wiki/AMD) is officially supported, allowing you to convinently load Caliper using [RequireJS](http://requirejs.org/). Follow the following steps:

1. Config your API key
2. Include `caliper.backbone.min.js` on your page (or concatenate it to your asset bundle)
3. Add `caliper-backbone` as a dependency to all your modules that depends on Backbone, for example:

```javascript
define("marionette", ["underscore", "backbone", ..., "caliper-backbone"], function(_, Backbone){
  ...
  return Mationette;
});

define("MyView", ["backbone", "caliper-backbone"], function(Backbone){
  return Backbone.View.extend({
    __name__: "MyView",
    ...
  });
});

```

### Implementation Details

When included, `caliper.backbone.js` checks for the presence of the `define` function, if it is absent, Caliper will be loaded immediately just like the previous versions. When `define` is found, it defines two modules with the following signitures instead:

```javascript
define("caliper-core", [], function(){
  ...
  return Caliper;
});

define("caliper-backbone", ["caliper-core", "backbone", "underscore", "jquery"],
  function(Caliper, Backbone, _, $){
    ...
    return Backbone;
  });
```

The first module, `caliper-core` contains some Caliper utility functions. Typically you would not have to require this directly.

The second module, `caliper-backbone` contains the Caliper extensions to Backbone. As it lists "backbone", "underscore" and "jquery" as its dependencies, you should make sure the corresponding packages are defined with those IDs. If they are defined with a different ID, you can ["alias" them in your RequireJS config](http://requirejs.org/docs/api.html#config-paths):

```javascript
require.config({
  paths: {
    "underscore": "vendor/underscore",
    "backbone": "vendor/backbone",
    "jquery": "vendor/jquery"
  }
});
```

You should make sure this module is loaded before you define your Backbone views and routers. This includes libaries such as [Marionette](http://marionettejs.com/) that extends core Backbone classes.

To do this, you would typically add `caliper-backbone` as a dependency to your modules that depends on Backbone. For your convinence, the `caliper-backbone` package is setup to return the extended `Backbone` object. This means you may directly depend on `caliper-backbone` if you prefer:

```javascript
define("MyView", ["caliper-backbone"], function(Backbone){
  ...
});

// ...is equivilent to...

define("MyView", ["backbone", "caliper-backbone"], function(Backbone){
  ...
});

```

Since the `caliper-backbone` extension only needs to be loaded once, you could also just require it before loading your app:

```javascript
require('caliper-backbone', function(){
  require('my-app', function(MyApp){
    new MyApp().initialize();
  });
});
```

If you do this, be extra careful with the actual load order! If you end up defining a view or a router before `caliper-backbone` is loaded, Caliper will not be able to measure them!

### Troubleshooting

If you are having trouble with the installation please check out our tips under [troubleshooting](/troubleshooting.html).