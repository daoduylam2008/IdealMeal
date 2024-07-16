const orderRouter = require('./order');
const feedbackRouter = require('./feedback');
const calendarRouter = require('./calendar');

function route(app) {
  app.use('/order', orderRouter);
  app.use('/calendar', calendarRouter);
  app.use('/feedback', feedbackRouter)
}

module.exports = route;
