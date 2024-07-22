const express = require("express");
const router = express.Router();

const orderController = require("../controllers/OrderController");

router.get("/", orderController.show);


router.post('/create', orderController.create)
router.post('/', orderController.preorder)

module.exports = router;