const mongoose = require('mongoose');
async function connect() {
  try {
    mongoose
      .connect('mongodb://client:pass@127.0.0.1:27017/idealmeal')
      .then(() => console.log('\n- Mongodb: Connected!'));
  } catch (error) {
    console.log('\n- Mongodb: Connection failed!')
  }
}

module.exports = {connect}