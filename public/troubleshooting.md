## Troubleshooting

This page will be helpful to you if you're having trouble using Caliper or one
of the Caliper Framework libraries.

### Nothing is appearing my dashboard

If nothing is appearing in Caliper then there are a few possibilities.

#### - Ensure correct load order

For us to correctly measure parts of your application, Caliper must be loaded after your framework has been initialized and before your code.

If it is loaded after your application your javascript objects will not be instiated with the Caliper instrumentation.

#### - Check the console for errors

It's unlikely but possible that there is an error loading resources.

Check to make sure that Caliper is being loaded correctly in your browsers
network request page, and check the console for any specific errors.

#### - Minimum Duration

Minimum Duration is a setting you can use to filter out very fast measurements for either routes or events.

The default is set to 10ms. It could be that your testing has not exceeded this duration.

### I see lots of Unnamed Views

This is because our library hasn't been able to determine the name correctly.
You can though add naming quite easily to you backbone views.


### Not everything is appearing in my dashboard

We have a couple of filters to optimize what is recorded and save on client bandwidth. It could be that this is preventing some data to appear in our dashboard.

Check out the [configuration variables](/configuration.html) on our library for more information and also enable debug if you would like to see more information.