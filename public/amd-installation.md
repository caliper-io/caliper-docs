## AMD / RequireJS

For convenience we provide [RequireJS](http://requirejs.org/) builds of our adapters. Follow the following steps (Backbone.js adapter used in example):

1. Config your API key
2. Include `caliper.backbone.amd.min.js` on your page (or concatenate it to your asset bundle)
3. Add `caliper-backbone` as a dependency to all your modules that depends on Backbone, for example:

```javascript
define("marionette", ["underscore", "backbone", ..., "caliper-backbone"], ...);

define("MyView", ["backbone", "caliper-backbone"], function(Backbone){
  return Backbone.View.extend({
    __name__: "MyView",
    ...
  });
});

```

### Backbone.js Implementation Details

`caliper.backbone.amd.min.js` defines a named AMD module with the following signiture:

```javascript
define("caliper-backbone", [backbone", "underscore", "jquery"],
  function(Backbone, _, $){
    // Caliper's extensions to Backbone goes here
    return Backbone;
  });
```

As it lists "backbone", "underscore" and "jquery" as its dependencies, you should make sure the corresponding packages are defined with those IDs. If they are defined with a different ID, you can ["alias" them in your RequireJS config](http://requirejs.org/docs/api.html#config-paths):

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

To do this, you would typically add `caliper-backbone` as a dependency to your modules that depends on Backbone. For your convinence, the `caliper-backbone` package is setup to return the extended `Backbone` object. This means you may simply depend on `caliper-backbone` if you prefer:

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