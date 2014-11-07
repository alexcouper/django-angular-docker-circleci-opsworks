exports.config = {
  allScriptsTimeout: 11000,

  specs: ['*.js'],

  capabilities: {
    'browserName': 'firefox'
  },

  directConnect: true,

  framework: 'jasmine'
};