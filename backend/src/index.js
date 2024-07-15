const express = require("express");
const route = require("./routes")
const app = express();
const port = 1111;
app.use(express.urlencoded({
  extended: true
}))
app.use(express.json())

app.listen(port, () => {
  console.log(`- Local: http://localhost:${port}`);
});

const middleware = (res, req, next) => {
    next()
};
app.use(middleware);

route(app)

const db = require('./config/db')
db.connect()
