const orderRouter = require('./order');
const calendarRouter = require('./calendar');

function route(app) {
  app.use('/order', orderRouter);
  app.use('/calendar', calendarRouter);
}

module.exports = route;
