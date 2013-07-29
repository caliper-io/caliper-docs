## Configuration Variables

The Caliper library has several configuration settings.
The only required setting is the `apiKey` which must be present.
All other settings are outlined below. All configuration values are set in the `Caliper.config` object. For example:

```javascript
Caliper.config = {
  enableAjaxFilter: true
}
```

### Ajax Filter
Key: `enableAjaxFilter`
Default: `false`
Type: `Boolean`

Ignore traces that are not associated with an AJAX request. If the value is set to `true` and a trace did not include an AJAX request, then the trace will not be reported back to the Caliper servers.

### Minimum Duration
Key: `minDuration`
Default: `50`
Type: `Integer`

Minimum trace duration in ms. If the duration of a trace is below this value, then the trace will be dropped and will not be reported back to the Caliper servers. A setting of `0` means use the default.

The default has been set to 50 so that Caliper focuses on showing you only things that are slow for visiting users. This also limits the amount of data sent from your visitor's devices.

### API Key
__required__

Key: `apiKey`
Default: n/a
Type: `UUID`

The API key is the unique identifier for your project. This setting is required. Your API key can be retrieved by logging into [app.caliper.io](https://app.caliper.io) and looking at the settings for your application.

### Beacon URL

Key: `beaconURL`
Default: `//b.caliper.io/_.gif`
Type: `URL`

The beacon URL setting is used to determine where traces are sent to. You'll probably never want to change this setting.

### Debug Mode

Key: `debug`
Default: `false`
Type: `Boolean`

Turning debug mode on will enable console logging. This can be useful when troubleshooting potential issues or missed traces when using settings like `enableAjaxFilter` and `minDuration`.
