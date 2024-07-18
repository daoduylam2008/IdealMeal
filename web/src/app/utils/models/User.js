import mongoose from 'mongoose';

const Schema = new mongoose.Schema({
  student_id: { type: Number, min: 100000, max: 129999 },
  meals: [
    {
      date: Date,
      dish_id: String,
    },
  ],
});

export default mongoose.models.User || mongoose.model('User', Schema);
