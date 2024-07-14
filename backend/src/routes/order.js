const express = require("express");
const router = express.Router();

const orderController = require("../controllers/OrderController");

router.get("/", orderController.show);

router.post("/", orderController.preorder);

module.exports = router;
