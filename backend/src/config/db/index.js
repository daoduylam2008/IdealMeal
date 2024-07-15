const mongoose = require('mongoose');
async function connect() {
  try {
    mongoose
      .connect('mongodb://client:pass@127.0.0.1:27017/idealmeal')
      .then(() => console.log('Connected!'));
  } catch (error) {
    console.log('Connection failed!')
  }
}

module.exports = {connect}