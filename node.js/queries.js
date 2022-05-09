const pgp1 = require('pg-promise')();
// Database connection details;
const cn1 = {
    host: 'localhost', // 'localhost' is the default;
    port: 5432, // 5432 is the default;
    database: 'api',
    user: 'me',
    password: 'sa',

    // to auto-exit on idle, without having to shut-down the pool;
    // see https://github.com/vitaly-t/pg-promise#library-de-initialization
    allowExitOnIdle: true
};
const db1 = pgp1(cn1); // database instance;

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'api',
  password: 'sa',
  port: 5432,
})

const getCart = (request, response) => {
  console.log(request) 
  const id = parseInt(request.params.id)
  pool.query('SELECT * FROM public."Cart" WHERE "Cart_ID"  = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}


const getCarts = (request, response) => {
  console.log(request.body) 
  pool.query('SELECT * FROM public."Cart_item" ORDER BY "ID" ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createCart = (request, response) => {
  console.log(request.body) 
  const {ProductID} = request.body

  pool.query('INSERT INTO "Cart_item" '+
  ' ( "ProductID", "Cart_ID", '+
  '   "sku", "price", "discount", '+
  '   "quantity", "active", "createdAt", '+ 
  '   "updatedAt", "content", "image_url" '+
  '  ) '+
  ' SELECT "ProductID", 1 as "Cart_ID",'+
  '   "content" as Sku, "product_price" as price, "discount", '+
  '   "quantity", 1 as active, current_date, '+
  '   current_date, "content", "image_url" '+
  ' FROM "Product" where "ProductID" = $1', [ProductID], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const deleteCart = (request, response) => {
  console.log(request) 
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM "Cart_item" WHERE "ID" = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`Cart deleted with ID: ${id}`)
  })
}

const getProd = (request, response) => {
  console.log(request.body) 
  pool.query('SELECT * FROM public."Product" ORDER BY "ProductID" ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getProdById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT "Product".*, cat.CategoryID '+
  'FROM "Product" '+
  '  LEFT JOIN '+
  '  (SELECT "ProductID", MAX("CategoryID") CategoryID FROM "Product_Category" GROUP BY  "ProductID") as cat '+
  'ON "Product"."ProductID" = cat."ProductID" '+
  'WHERE "Product"."ProductID"  = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createProd = (request, response) => {
  try {
    const { User_ID,	prodcut_title, metaTitle,
      summary,	product_price, discount,
      quantity,	group_qty, status,
      content,	serial_no, image_url, CategoryID } = request.body
    
      console.log(request.body) 
      var prodID
      
      db1.one(''+
      '  INSERT INTO public."Product" ("User_ID",	"prodcut_title", "metaTitle", '+
      '   "summary",	"product_price", "discount", '+
      '   "quantity",	"group_qty", "status", '+
      '   "content",	"serial_no", "image_url", '+
      '   "current_order_qty","createdAt") '+
      '  VALUES ($1, $2, $3, ' +
      '           $4, $5, $6, ' +
      '           $7, $8, $9, ' +
      '           $10, $11, $12, 0, current_date)  RETURNING "ProductID"', [User_ID,	prodcut_title, metaTitle,
        summary,	product_price, discount,
        quantity,	group_qty, status,
        content,	serial_no, image_url])
      .then(data => {
          console.log('DATA:', data); // print data;
          if (data === undefined)
            prodID = 0
          else
            prodID = data.ProductID

          console.log('prodID:', prodID);
          
          db1.none('INSERT INTO public."Product_Category" ("ProductID","CategoryID") VALUES ($1, $2)',
          [prodID, CategoryID])
          .then(() => { 
              // success;            
            response.status(200).send() //results.rows[0].ProductId)    
            })
          .catch(error => {
              console.log('ERROR - Product_Category :', error); // print error;
          }
          ); 
      }) 
    
} catch (err) {
    console.error(err.message)
}
}

const updateProd = (request, response) => {
  try{
    const {ProductId, User_ID,	prodcut_title, metaTitle,
      summary,	product_price, discount,
      quantity,	group_qty, status,
      content,	serial_no, image_url } = request.body
    
    console.log(request.body) 
    console.log(ProductId) 

    var sql = 'UPDATE public."Product" SET ' +
    '  "User_ID" = $1,	"prodcut_title" = $2, "metaTitle" =$3,' +
    '	"summary" = $4,	"product_price" = $5, "discount" = $6,' +
    '	"quantity" = $7,	"group_qty" = $8, "status" = $9,	' +
    '  "content" = $10,	"serial_no" = $11, "image_url" = $12, "updatedAt" = current_date  WHERE "ProductID" = $13' 

    pool.query(sql
      , [User_ID,	prodcut_title, metaTitle,
      summary,	product_price, discount,
      quantity,	group_qty, status,
      content,	serial_no, image_url, ProductId], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200)
    })
}
  catch (err) {
    console.error(err.message)
}
}

const getCategory = (request, response) => {
  pool.query('SELECT * FROM public."Category"', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getTotalAmt = (request, response) => {
  pool.query('SELECT sum("price") FROM public."Cart_item"', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getProdByCategory = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query(''+
  'select "Product".* from "Product" '+
	' inner join "Product_Category" on "Product_Category"."ProductID" = "Product"."ProductID" '+
  ' inner join "Category" on "Product_Category"."CategoryID" = "Category"."CategoryID"'+
  'WHERE "Category"."CategoryID" = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}
/*Багцын жагсаалт */
const getProdGroups = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query(''+
  ' select "order_group".* from "order_group" '+
  'inner join "Product" on "Product"."ProductID" = "order_group"."ProductID"  '+
  'where "order_group"."ProductID" = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

/*Багцад байгаа харилцагч */
const getGroupUsers = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query(''+
  ' select "order_person".* from "order_group" '+
  ' inner join "order_person" on "order_person"."order_group_ID" = "order_group"."order_group_ID"  '+
  ' where "order_group"."order_group_ID"  = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getUsers = (request, response) => {
    pool.query('SELECT * FROM users ORDER BY id ASC', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const getUserById = (request, response) => {
    const id = parseInt(request.params.id)
  
    pool.query('SELECT * FROM users WHERE id = $1', [id], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const createUser = (request, response) => {
    const { name, email } = request.body
  
    pool.query('INSERT INTO users (name, email) VALUES ($1, $2)', [name, email], (error, results) => {
      if (error) {
        throw error
      }
      response.status(201).send(`User added with ID: ${result.insertId}`)
    })
  }

  const updateUser = (request, response) => {
    const id = parseInt(request.params.id)
    const { name, email } = request.body
  
    pool.query(
      'UPDATE users SET name = $1, email = $2 WHERE id = $3',
      [name, email, id],
      (error, results) => {
        if (error) {
          throw error
        }
        response.status(200).send(`User modified with ID: ${id}`)
      }
    )
  }

  const deleteUser = (request, response) => {
    const id = parseInt(request.params.id)
  
    pool.query('DELETE FROM users WHERE id = $1', [id], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User deleted with ID: ${id}`)
    })
  }

  module.exports = {
    getCart,
    getCarts,
    createCart,
    deleteCart,
    getGroupUsers,
    getProdGroups,
    getProd,
    getProdById,
    createProd,
    updateProd,
    getCategory,
    getProdByCategory,
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    getTotalAmt,
  }