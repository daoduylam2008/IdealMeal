const express = require("express");
const router = express.Router();

const verifyController = require("../controllers/VerifyController");

router.get("/", verifyController.sendOTP);

router.post("/", verifyController.verifyOTP);

module.exports = router;