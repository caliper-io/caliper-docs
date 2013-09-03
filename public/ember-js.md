## Ember.js

When building Ember.js applications, conventional real user monitoring (RUM) focusing on page load times (the `DOMContentLoaded` and `onload` event timestamps) only reflects the initial loading time of your application.
While this number is critical, this does not provide any indication of your users' experience as they continue to interact with the application once it's loaded, which is what they spend the majority of their time doing.

Caliper is built to provide a full view of runtime performance as your users interacts with your application.

### What do we trace?

It's our job to help you improve your user's experience when using your application.
We have all experienced the frustration when you clicked on a button on the screen and had to wait a long time for the computer to respond.
We would like to help you discover these problem areas in your application so that you can streamline the experience for your users.

To achieve this goal, we are focused on reporting "end-to-end" application response times of your application to give you a holistic view of your user's experience. Each trace Caliper sends correspond to the time spent between the user initiating the request (e.g. clicking on a link created with the `{{#link-to}}` helper or typing in a search field) to the requested data became fully avaialble and ready to be interacted with (models are loaded, views are updated, etc).

Currently we are collecting this timing information from two main entry points in your Ember app: route transitions and view/controller/route events.

#### <i class="ss-signpost"></i> Route transitions

A route transition in an single page application is analogous to moving from one page to another in conventional web application.

Whenever the Ember router enters a new route (or when the model of the current route changes), Caliper would start a new trace with the pattern of the route being entered (e.g. `/posts/:id`). Caliper would then wait until Ember has completed processing the new route, including all AJAX requests (e.g. loading models) and view renderes, before reporting it back to our server.

If another trace has already been started (e.g. when processing the parent route or the previous route that redirected to the current route), it will be renamed to point to the current route while preserving the original start timestamp, so that your traces will always be grouped under the "leaf" routes.

#### <i class="ss-cursor"></i> View/controller/route events

In an Ember.js app, there are two ways to handle user interactions &mdash; by handling the native browser events in a view (e.g. by implementing a `click` method) and by sending application events handled in the controllers and routes (e.g. by using the `{{action}}` helper or `controller.send()`).

In both cases, Caliper would start a new trace with the name of the view/controller/route as well as the name of the event (e.g. `PlayButtonView.click` or `HistogramView.didMakeSelection`). Similar to route transitions, Caliper would wait for Ember to complete any related processing before reporting it back to our server.

If one of the event handlers triggered a route transition when processing the event, the trace will be renamed to point the the route being entered while preserving the original start timestamp. For example, when a user clicks on a link created with the `{{#link-to}}` helper, you will see something like `/posts/:id` instead of `LinkView.click`.

### Trace breakdown

We also include a detailed breakdown of the time spent in each component for each trace to help you investigate the cause of a slowdown.
Currently we record the timing for any AJAX requests and any `Ember.View.render` calls within a trace.

### Caveats and known issues

  - In order to get a accurate timestamp as early as possible and to account for the time taken by your application to load additional modules and models, we reopened `Ember.Route` to implement the `beforeModel` hook. If you have implmented this hook in your routes, you should call `this._super()` at the top of your implementation to ensure an accurate timestamp.

  - If you have a custom `init` implementation in your routes, you make sure you are calling `this._super()`.

  - We currently only include timing breakdown for AJAX requests that goes through `jQuery.ajax()`.

  - Traces are sent at the end of the last Ember runloop to ensure all computed propoerties and view updates have been completed. However, this will not account for any asynchronous callbacks set with `window.setTimeout`. You should make sure your code are always scheduled to run inside an Ember runloop by using `Ember.run.*`.

### What else do we collect

Caliper collects other telemetry:

  - We associate all traces to a unique visitor. By default, we generate a random unique ID for each browser, but you can also supply a custom indentifier, such as an email address
  - We also group each visitor's traces into sessions
  - We also record the browser and OS for each visitor session to help visualize device performance

### Our Javascript

We adhere to these design principles with our javascript library.

  - Keep it's footprint low and small
  - Perform all expensive computation on our server
  - Always send the least amount of information needed to limit network utilization
  - Never take down your application

And to do this we run automated tests on our library across a number of browsers. Currently we support IE8+ (Caliper would disable itself on IE <= 7), Firefox, Chrome, Safari and the iOS WebViews.

We also send all data asynchronously so that it would not interrupt your application.
