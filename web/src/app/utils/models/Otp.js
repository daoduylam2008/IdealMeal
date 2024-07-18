import mongoose from 'mongoose';

const Schema = new mongoose.Schema(
  {
    student_id: { type: Number, min: 100000, max: 129999 },
    code: { type: Number, min: 100000, max: 999999 },
    expireAt: { type: Date, default: new Date() },
  },
  {
    timeseries: {
      timeField: 'expireAt',
    },
  },
);

export default mongoose.models.Otp || mongoose.model('Otp', Schema);
