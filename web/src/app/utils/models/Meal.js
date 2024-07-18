import mongoose from 'mongoose';

const Schema = new mongoose.Schema({
  date: Date,
  dish_ids: [String],
});

export default mongoose.models.Meal || mongoose.model('Meal', Schema);
