const mongoose = require("mongoose");

const Schema = new mongoose.Schema({
  date: Date,
  dish_ids: [String],
});

module.exports = mongoose.models.Meal || mongoose.model("Meal", Schema);
