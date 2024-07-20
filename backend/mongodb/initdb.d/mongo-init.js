db = db.getSiblingDB("idealmeal");

db.createUser({
  user: "client",
  pwd: "pass",
  roles: [
    {
      role: "readWrite",
      db: "idealmeal",
    },
  ],
});

db.createCollection("meals");
db.createCollection("users");
db.createCollection("feedbacks");

db.meals.createIndex({ date: 1 });
db.users.createIndex({ student_id: 1, "meals.date": 1 });
db.feedbacks.createIndex({ student_id: 1, date: 1 });

const specificMeals = [
  "Xúc xích lúc lắc",
  "Gà chiên nước mắm",
  "Cơm chiên dương châu",
  "Gà nướng mật ong",
  "Cá file kho sốt chua ngọt",
  "Bún gạo",
  "Phở bò",
  "Bún chả cá",
  "Bánh bột lọc",
  "Bún mọc",
  "Bánh canh cua",
  "Bún măng vịt",
  "Bánh bột lọc lá",
  "Bún cá",
];
const randomData = [];
const users = [];
const feedback = [];

function shuffleArray(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

function getRandomMeals(array) {
  return array.map((e) => {
    return {
      date: e.date,
      dish_id: e.dish_ids[Math.floor(Math.random() * e.dish_ids.length)],
    };
  });
}

for (let i = 1; i < 1000; i++) {
  const day = new Date(2024, 5, i);
  if (day.getDay() !== 0 && day.getDay() !== 6) {
    const dishes = [];
    if (Math.round(Math.random())) {
      const randomArray = shuffleArray(specificMeals);
      for (let j = 0; j < 3; j++) {
        dishes.push(randomArray[j]);
      }
      randomData.push({ date: day, dish_ids: dishes });
    } else {
      const randomArray = shuffleArray(specificMeals);
      for (let j = 0; j < 2; j++) {
        dishes.push(randomArray[j]);
      }
      randomData.push({ date: day, dish_ids: dishes });
    }
  } else {
    continue;
  }
}

for (let i = 1; i < 24; i++) {
  for (let j = 1; j < 40; j++) {
    users.push({
      student_id: 100000 + i * 100 + j,
      meals: getRandomMeals(randomData),
    });
  }
}

for (let i = 0; i < 1; i++) {
  for (let j = 0; j < users[i].meals.length; j++) {
    feedback.push({
      student_id: users[i].student_id,
      date: users[i].meals[j].date,
      dish_id: users[i].meals[j].dish_id,
      rate: Math.floor(Math.random() * 5 + 1),
      text: "",
    });
  }
}

db.meals.insertMany(randomData);
db.users.insertMany(users);
db.feedbacks.insertMany(feedback);

db.createCollection("otps", {
  timeseries: {
    timeField: "expireAt",
    metaField: "student_id",
    granularity: "seconds",
  },
  expireAfterSeconds: 0,
});

// db.createCollection("selections");
// db.selections.insertOne({
//   student_id: 100101,
//   dish_id: "Xúc xích lúc lắc",
//   date: new Date(2024, 5, 3),
// });

// db.createCollection("dishes");
// db.dishes.insertOne({
//   _id: "Xúc xích lúc lắc",
//   nutrients: "",
// });
