const User = require("../models/User");
const Meal = require("../models/Meal");

class CalendarController {
  async show(req, res) {
    const id = Number.parseInt(req.query.id);
    const meals = await User.aggregate([
      { $match: { student_id: id } },
      { $project: { "meals.date": 1, "meals.dish_id": 1 } },
    ])
      .limit(1)
      .exec()
      .then((data) => {
        const meals = {};

        if (data[0]) {
          data[0].meals.forEach((e) => {
            meals[
              `${e.date.getFullYear()}/${
                e.date.getMonth() + 1
              }/${e.date.getDate()}`
            ] = e.dish_id;
          });
        }

        return meals;
      });
    res.json(meals);
  }

  async selection(req, res) {
    const selection = await Meal.find({})
      .exec()
      .then((data) => {
        const selection = {};

        data?.forEach((e) => {
          selection[
            `${e.date.getFullYear()}/${
              e.date.getMonth() + 1
            }/${e.date.getDate()}`
          ] = e.dish_ids;
        });

        return selection;
      });
    res.json(selection);
  }

  async update(req, res) {
    const id = Number.parseInt(req.query.id);
    const user = await User.findOne({ student_id: id });

    req.query.orderList.forEach((e) => {
      user.meals[
        this.recursiveBinarySearch(user.meals, e, 0, user.meals.length - 1)
      ].dish_id = e.dish_id;
    });

    await user.save();
  }

  recursiveBinarySearch(arr, x, start, end) {
    if (start > end) return false;

    const mid = Math.floor((start + end) / 2);

    if (
      arr[mid].date.getDate() === x.date.getDate() &&
      arr[mid].date.getMonth() === x.date.getMonth() &&
      arr[mid].date.getFullYear() === x.date.getFullYear()
    )
      return mid;

    if (arr[mid].date > x.date)
      return recursiveBinarySearch(arr, x, start, mid - 1);
    else return recursiveBinarySearch(arr, x, mid + 1, end);
  }
}

module.exports = new CalendarController();
