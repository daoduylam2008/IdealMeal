const express = require("express");
const router = express.Router();

const calendarController = require("../controllers/CalendarController");

router.get("/selection", calendarController.selection);
router.get("/", calendarController.show);

router.post("/create", calendarController.create);
router.post("/", calendarController.update);

module.exports = router;
