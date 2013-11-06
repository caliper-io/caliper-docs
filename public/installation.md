## Installation

To install Caliper simply follow the instructions under the setup page from under your application in [Caliper](http://app.caliper.io).

### Packages using Bower

Caliper client libraries are packaged using bower.
You can optionally download the libraries directly from your application setup
page in the [Portal](https://app.caliper.io). The bower package includes
minified standard and AMD versions of the client library.

For Ember

    $ bower install caliper-ember

For Backbone
 
    $ bower install caliper-backbone

### Including Caliper in your app

As an overview you follow these three simple steps.

1. Configure your API key
2. Insert our framework adapter after your framework has been initialized and before your application code
3. Optionally add names to parts of your application so that the Caliper dashboard is better detailed

### AMD & RequireJS

If you are using AMD/RequireJS, follow the instructions [here](/amd-installation.html).

### Troubleshooting

If you are having trouble with the installation please check out our tips under [troubleshooting](/troubleshooting.html).
