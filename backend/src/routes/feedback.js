const express = require("express");
const router = express.Router();

const feedbackController = require("../controllers/FeedbackController");

router.get("/student", feedbackController.queryStudent);
router.get("/date", feedbackController.queryDate);
router.get("/statistics", feedbackController.statistics);

router.post("/", feedbackController.create);

module.exports = router;
