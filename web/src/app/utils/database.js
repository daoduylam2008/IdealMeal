'use server';
import mongoose from 'mongoose';

// const url = 'mongodb://localhost:27017/idealmeal';
const url = process.env.MONGODB_URL;

if (!url) {
  throw new Error('Please define MONGO_URL environment');
}

const dbConnect = async () => {
  if (mongoose.connection.readyState !== 1) {
    try {
      await mongoose.connect(url);
      console.log('MongoDB is connected');
    } catch (error) {
      console.log('MongoDB is not connected');
    }
  } else {
    console.log('MongoDB is already connected');
  }
};

export default dbConnect;
