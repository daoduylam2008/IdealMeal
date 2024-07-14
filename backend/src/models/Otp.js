const mongoose = require('mongoose');

const Schema = new mongoose.Schema({
    student_id: { type: Number, min: 100000, max: 129999 },
    code: { type: Number, min: 100000, max: 999999 },
    createdAt: { type: Date, default: new Date()},
  });

module.exports = mongoose.models.Otp || mongoose.model('Otp', Schema);
