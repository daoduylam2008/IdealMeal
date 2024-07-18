const express = require("express");
const route = require("./routes");
const cookieParser = require('cookie-parser')

const app = express();
const port = 1111;
app.use(
  express.urlencoded({
    extended: true,
  })
);
app.use(express.json());
app.use(cookieParser())

app.listen(port, () => {
  console.log(`- Local: http://localhost:${port}`);
});

const middleware = (req, res, next) => {
  const token = req.cookies.token
  next();
};
app.use(middleware);

route(app);

const db = require("./config/db");
db.connect();
