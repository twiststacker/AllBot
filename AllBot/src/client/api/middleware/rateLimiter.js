const rateLimit = require('express-rate-limit');
const config = require('../../../config/default.json');

module.exports = rateLimit({
  windowMs: config.api.throttle.windowMs,
  max: config.api.throttle.max
});
