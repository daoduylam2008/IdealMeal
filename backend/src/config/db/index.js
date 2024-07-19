const mongoose = require('mongoose');
async function connect() {
  try {
    mongoose
      .connect('mongodb://localhost:27017/idealmeal')
      .then(() => console.log('\n- Mongodb: Connected!'));
  } catch (error) {
    console.log('\n- Mongodb: Connection failed!')
  }
}

module.exports = {connect}