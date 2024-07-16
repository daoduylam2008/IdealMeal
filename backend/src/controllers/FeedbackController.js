const Feedback = require("../models/Feedback");

class FeedbackController {
  async create(req, res) {
    res.json([]);
  }
  async queryStudent(req, res) {
    const querytParams = req.query;
    const id = Number.parseInt(querytParams.id);
    let data = [];
    if (querytParams.w) {
      const weekOfYear = Number.parseInt(querytParams.w) - 1;
      const year = Number.parseInt(querytParams.y);
      data = await Feedback.aggregate([
        { $match: { student_id: id } },
        {
          $match: {
            date: {
              $gte: new Date(
                new Date(year, 0, 1).getTime() +
                  weekOfYear * 7 * 24 * 60 * 60 * 1000
              ),
              $lte: new Date(
                new Date(year, 0, 1).getTime() +
                  weekOfYear * 7 * 24 * 60 * 60 * 1000 +
                  6 * 24 * 60 * 60 * 1000
              ),
            },
          },
        },
      ]);
    } else if (querytParams.m) {
      const year = Number.parseInt(querytParams.y);
      const month = Number.parseInt(querytParams.m);
      data = await Feedback.aggregate([
        { $match: { student_id: id } },
        {
          $match: {
            date: {
              $gte: new Date(year, month, 1),
              $lte: new Date(year, month + 1, 0),
            },
          },
        },
      ]);
    } else {
      const year = Number.parseInt(querytParams.y);
      data = await Feedback.aggregate([
        { $match: { student_id: id } },
        {
          $match: {
            date: {
              $gte: new Date(year, 1, 1),
              $lte: new Date(year, 11, 31),
            },
          },
        },
      ]);
    }
    res.json(data);
  }
  async queryDate(req, res) {
    const querytParams = req.query;
    let data = [];
    if (querytParams.w) {
      const weekOfYear = Number.parseInt(querytParams.w) - 1;
      const year = Number.parseInt(querytParams.y);
      data = await Feedback.aggregate([
        {
          $match: {
            date: {
              $gte: new Date(
                new Date(year, 0, 1).getTime() +
                  weekOfYear * 7 * 24 * 60 * 60 * 1000
              ),
              $lte: new Date(
                new Date(year, 0, 1).getTime() +
                  weekOfYear * 7 * 24 * 60 * 60 * 1000 +
                  6 * 24 * 60 * 60 * 1000
              ),
            },
          },
        },
      ]);
    } else if (querytParams.m) {
      const year = Number.parseInt(querytParams.y);
      const month = Number.parseInt(querytParams.m);
      data = await Feedback.aggregate([
        {
          $match: {
            date: {
              $gte: new Date(year, month, 1),
              $lte: new Date(year, month + 1, 0),
            },
          },
        },
      ]);
    } else {
      const year = Number.parseInt(querytParams.y);
      data = await Feedback.aggregate([
        {
          $match: {
            date: {
              $gte: new Date(year, 1, 1),
              $lte: new Date(year, 11, 31),
            },
          },
        },
      ]);
    }
    res.json(data);
  }
}

module.exports = new FeedbackController();
