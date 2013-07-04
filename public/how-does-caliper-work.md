## How does Caliper work?

Caliper instruments from your users browser. We hook into the framework that your application is built with so that we can show you a meaningful representation of how your user interacts with your web application.

### What we measure

When building front end applications that run in a browser conventional page load times only provide developers a the loading time of an application.

Caliper is built to provide a full view of a front end application.

Currently we measure two parts of your application.

#### <i class="ss-signpost"></i> Routes

A route is when a user switches from one part of the application to another. For example in BackboneJS the Backbone Router handles this.

We calculate the best human readable name for this route and measure how long it took to load for the user.

#### <i class="ss-cursor"></i> Events

An event is when a user clicks or hovers on something that in turn performs some javascript work. This could be for example when a user fills in a form in your application and submits the data.

### Measurement breakdown

In both types of measurements (routes and events) we record the time it takes your application to interact with backend services (AJAX) and javascript rendering (views).

This can help you determine where a problem may lie with your application.

### What else do we collect

We collect a number of other things that will soon help what are soon to release.

  - We store all measurements against a unique visitor session to view all events and routes visited
  - A visitor is unique and we'll allow classification of them by email
  - Browser and OS is recorded on the incoming visitor session to help visualize device performance

### Our Javascript

We follow these design principles with our javascript library.

  - Keep it's footprint low and small
  - To not perform expensive computation
  - Always send Caliper the lowest amount of information to ensure low bandwidth on Mobiles
  - Never take down your application

And to do this we run automated tests on our library across a number of browsers. Currently IE8 upwards, Firefox, Chrome, Safari and the iOS webkit browser.

### Data sent to Caliper

The data is sent asynchronously so that it does not interrupt your application.

We are constantly optimizing our library to ensure that the least amount of data is sent.