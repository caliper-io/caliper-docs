## How does Caliper work?

Caliper instruments web apps directly in the browser. We hook into the framework layer of your application so we can show you a meaningful representation of how your user interacts with your web application.

### What we trace

When building front end web applications, conventional page load times only reflects the loading time of an application.
While this number is critical, this only represents a small amount of the time spent with your application.

Caliper is built to provide a full view of runtime performance as your users interacts with your front end web applications.

Currently we are sending two types of traces:

#### <i class="ss-signpost"></i> Routes

A route change occurs when a user transitions from one part of the application to another.
This is analogous to switching from one page to another a conventional web application.

For Backbone.js applications, this is handled by the Backbone Router.
When the active route changes in the router, we monitor the time it takes for your application to respond (executing route handlers, callbacks, AJAX requests to backend services, additional views rendering etc - see the section on trace breakdown for details).

In Ember.js applications these are the routes delcared with the <a href="http://emberjs.com/guides/routing/">Ember.Router</a>.

#### <i class="ss-cursor"></i> Actions

An action occurs when your application handles user action (click, keypress, mouseover, etc) and perform some meaningful work in reponse to the user's requests. Examples include fetching extra posts for display when a user click on the "Load more..." button, or sending data back to the server when a user submits a form.

For Backbone.js applications, we monitor any custom event handles defined in your Views (defined under the `events` property of a Backbone View).

For Ember.js actions are the events handled by Controllers, Views or even Routes.

### Trace breakdown

In order to give you a better picture of your users' actual experience, we record the end-to-end time it takes to completely fufill the user's request for both types of traces (Routes and Actions). We also provide a breakdown on these traces to help you determine where a problem may lie.

Currently we take into account the time it takes for your application to interact with your backend services (AJAX requests) and javascript rendering time.

Consider the following example in a news reader application.

A user clicked on the "Load more..." button which triggered a custom event handler. The event handler dispatched an asynchronous backend request (an AJAX request) to fetch more news stories, rendered a "Loading..." view and returned control to the browser. At this point, although the custom event handler had finished execution, from the user's perspective their request had not yet been fufilled.

A few momnts later, the backend server completed the request and delivered the requested news stories. A callback on the request was triggered, which removed the "Loading..." view and rendered the the news stories on the screen before returning control to the browser. At this point, the user's requrst had been fufilled and an end-to-end response time could be calculated.

A "Action" trace would then be reported back to Caliper with this end-to-end response time, as well as a breakdown of the AJAX requests performed, views rendered and their respective duration.

### What else do we collect

Caliper collects other telemetry:

  - We store all traces against a unique visitor session to view all events and routes visited
  - A visitor is unique and we'll allow classification of them by email
  - Browser and OS is recorded on the incoming visitor session to help visualize device performance

### Our Javascript

We adhere to these design principles with our javascript library.

  - Keep it's footprint low and small
  - To not perform expensive computation
  - Always send Caliper the lowest amount of information to limit network utilization
  - Never take down your application

And to do this we run automated tests on our library across a number of browsers. Currently IE8 upwards, Firefox, Chrome, Safari and the iOS webkit browser.

### Data sent to Caliper

The data is sent asynchronously so that it does not interrupt your application.

We are constantly optimizing our library to ensure that the least amount of data is sent.
