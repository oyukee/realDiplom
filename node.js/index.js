const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries')
const dbOrder = require('./order')
const port = 3000

app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.get('/', (request, response) => {
  response.json({ info: 'Node.js, Express, and Postgres API' })
})

app.get('/cart/:id', db.getCart)
app.get('/cart', db.getCarts)
app.post('/addCart', db.createCart)
app.post('/getTotalAmt', db.getTotalAmt)
app.delete('/cart/:id', db.deleteCart)
app.get('/getTotalAmt', db.getTotalAmt)
app.get('/prods', db.getProd)
app.get('/prods/:id', db.getProdById)
app.post('/saveProd', db.createProd)
app.put('/saveProd/:id', db.updateProd)
app.get('/category', db.getCategory)
app.get('/prodbycategory/:id', db.getProdByCategory)
app.get('/groupUsers/:id', db.getGroupUsers)
app.get('/prodGroups/:id', db.getProdGroups)

app.get('/orders/:id', dbOrder.getUserOrders)
app.get('/order/:id', dbOrder.getOrderId)
//app.post('/order', dbOrder.createOrder)
app.post('/order', async (req, res) => {
  try {
    return await dbOrder.createOrder(req, res); 
  } catch(e) {
    // handle errors
  }
});

app.put('/order/:id', dbOrder.updateOrder)
app.delete('/order/:id', dbOrder.deleteOrder)

app.get('/users', db.getUsers)
app.get('/users/:id', db.getUserById)
app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)

app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})