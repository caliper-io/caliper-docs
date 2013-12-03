## Error Reporting

Error Reporting is an experimental feature in Caliper that helps you monitor
runtime JavaScript errors in your application. For the time being, you would
need to opt-in by adding `captureErrors: true` to your Caliper config. See the
[configuration section](/configuration.html) for details.

If you enable this feature, we will try to collect the following information
when an error occurs:

* The error type (e.g. `ReferenceError`)
* The error message (e.g. `nothere is not defined`)
* Stacktrace (when availalbe)
* Browser and OS
* Session information, such as the page URL, visitor, etc

In addition to uncaught JavaScript errors, we will also record any failed AJAX
requests (anything with a 4XX or 5XX response code) made through jQuery to help
you catch unexpected server errors. This might result in some false positives,
but you can use the "Ignore" feature to filter them out.

You will also receive email alerts when errors are detected. You can change your
notification preferences in your app's Settings screen.

### FAQ & Trouble Shooting

1. Where can I see the errors collected by Caliper?

  When you have enabled this feature and we have received **at least one
  error** from your application, you will see "Errors" section.

2. What are "Unresolved", "Resolved" and "Ignored" errors?

   When a new error is submitted to Caliper it will be marked as "Unreolved".

   Once your team has identified and addressed the problem, you can mark it as
   "Resolved". When an similar error happens again, we will "reopen" the error
   by marking it as "Unresolved" again.

   On the other hand, if your team decided that a particular error is not
   important (e.g. errors caused by buggy browser extensions or third-party
   scripts), you can mark it as "Ignored". Once you ignored an error, it will
   not be "reopened" by Caliper when it reoccurs.

3. What notifications will I get?

   You will receive an email alert whenever a new error is reported or when a
   resolved error has regressed.

4. What is a "ScriptError"? I don't see any actionable information.

   As a security measure, browsers will prevent access to the details of errors
   throw by scripts serverd from a [different origin](http://en.wikipedia.org/wiki/Same-origin_policy).
   Most browsers redact the type, message and stcktrace for these errrors and
   report a generic "ScriptError" instead.

   This could be problematic if you serve your assets from an extenral domain
   (e.g. a CDN). To work around this, you can whitelist your external scripts
   by using [CORS](https://developer.mozilla.org/en/docs/HTTP/Access_control_CORS).

   In additional to configuring your server (or your CDN), you also need to add
   the `crossorigin` attribute to the `<script>` tags you use to load the page.

   For example, if your users are visiting your app from `https://www.myapp.com`:

   ```
   <!-- Errors from the following script are santatized -->
   <script src="//connect.facebook.net/en_US/all.js"></script>
   
   <!-- Errors from the following script are not santatized -->
   <script src="//cdn.myapp.com/app.js" crossorigin="anonymous"></script>
   ```

   **Note**: your assets server must be configured properly to resopnd to the
   CORS requests with the proper `Access-Control-*` headers. Otherwise,
   browsers will refuse to load the scripts with the `crossorigin` attribute
   added.

5. Why does Caliper say a stacktrace is not available for my error?

   Stacktraces can only be collected for errors originated from browsers that
   supports them, specifically Chrome, Firefox and recent versions of IE (10+)
   and Safari (6+).

   You might also need to need to setup CORS, see the previous question for
   more details.