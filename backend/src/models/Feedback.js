const mongoose = require("mongoose");

const Schema = new mongoose.Schema({
  student_id: { type: Number, min: 100000, max: 129999 },
  date: Date,
  dish_id: String,
  rate: { type: Number, min: 1, max: 5 },
  text: String,
});

module.exports = mongoose.models.Feedback || mongoose.model("Feedback", Schema);
