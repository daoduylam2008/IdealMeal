const express = require("express");
const route = require("./routes");
const cookieParser = require("cookie-parser");
var cors = require("cors");

const app = express();
const port = 1111;
const corsOptions = {
  origin: "http://localhost:3000",
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(
  express.urlencoded({
    extended: true,
  })
);
app.use(express.json());
app.use(cookieParser());

app.listen(port, () => {
  console.log(`- Local: http://localhost:${port}`);
});

const middleware = (req, res, next) => {
  const token = req.cookies.token;
  next();
};
app.use(middleware);

route(app);

const db = require("./config/db");
db.connect();
