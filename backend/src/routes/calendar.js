const express = require("express");
const router = express.Router();

const calendarController = require("../controllers/CalendarController");

router.get("/", calendarController.show);
router.get("/selection", calendarController.selection)

router.post('/', calendarController.update)

module.exports = router;