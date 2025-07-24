const express = require('express');
const rateLimiter = require('./middleware/rateLimiter');
const throttleCtrl = require('./controllers/throttleController');

const app = express();
app.use('/api', rateLimiter);
app.get('/api/throttle', throttleCtrl);
app.listen(process.env.PORT || 3000, () => {
  console.log('API listening on port', process.env.PORT || 3000);
});
