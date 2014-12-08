console.log('Running spec(s):', process.env.npm_package_config_specs);
exports.config = {
  allScriptsTimeout: 11000,

  specs: [process.env.npm_package_config_specs],

  capabilities: {
    'browserName': 'firefox'
  },

  directConnect: true,

  framework: 'jasmine',

  jasmineNodeOpts: {
    isVerbose: true
  }
};