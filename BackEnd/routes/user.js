const router = require('express').Router();

let validator = require('validator');

const { sql, dbConnPoolPromise } = require('../database/db.js');

const SQL_SELECT_ALL = 'SELECT * FROM dbo.appUser for json path;';

const SQL_SELECT_BY_ID = 'SELECT * FROM dbo.appUser WHERE userId = @id for json path, without_array_wrapper;';

const SQL_INSERT = 'INSERT INTO dbo.appUser (firstName, lastName, email, password, role) VALUES (@firstName, @lastName, @email, @password, @role); SELECT * FROM dbo.AppUser WHERE UserId = SCOPE_IDENTITY();';

const SQL_UPDATE = 'UPDATE dbo.appUser SET firstName = @firstName, lastName = @lastName, email = @email, password = @password, role = @role WHERE userId = @id; SELECT * FROM dbo.appUser WHERE userId = @id;';

const SQL_DELETE = 'DELETE FROM dbo.appUser WHERE userId = @id;';


router.get('/',async (req, res) => {
        try {
            const pool = await dbConnPoolPromise;
            const result = await pool.request().query(SQL_SELECT_ALL);
            res.json(result.recordset[0]);

        } catch (err) {
            res.status(500);
            res.send(err.message);
        }
    });

router.get('/:id', async (req, res) => {
    const userId = req.params.id;

    if (!validator.isNumeric(userId, { no_symbols: true })) {
        res.json({ "error": "Invalid ID" });
        return false;
    }

    try {
        const pool = await dbConnPoolPromise;
        const result = await pool.request().input('id', sql.Int, userId).query(SQL_SELECT_BY_ID);
        res.json(result.recordset);

    } catch (err) {
        res.status(500);
        res.send(err.message);
    }
});

router.post('/', async (req, res) => {
    let errors = "";

    // First Name
    const firstName = validator.escape(req.body.firstName);
    if (firstName === "") {
        errors += "invalid firstName; ";
    }

    // Last Name
    const lastName = validator.escape(req.body.lastName);
    if (lastName === "") {
        errors += "invalid lastName; ";
    }

    // Email
    const email = validator.escape(req.body.email);
    if (email === "") {
        errors += "invalid email; ";
    }

    // Password
    const password = validator.escape(req.body.password);
    if (password === "") {
        errors += "invalid password; ";
    }

    // Role
    const role = validator.escape(req.body.role);
    if (role === "") {
        errors += "invalid role; ";
    }

    if (errors != "") {
        res.json({ "error": errors });
        return false;
    }

    try {
        const pool = await dbConnPoolPromise;
        const result = await pool.request()
            .input('firstname', sql.NVarChar, firstName)
            .input('lastName', sql.NVarChar, lastName)
            .input('email', sql.NVarChar, email)
            .input('password', sql.NVarChar, password)
            .input('role', sql.NVarChar, role)
            .query(SQL_INSERT);

        res.json(result.recordset[0]);

    }

    catch (err) {
        res.status(500);
        res.send(err.message);
    }
});

router.put('/', async (req, res) => {
    let errors = "";

    // User Id
    const userId = req.body.userId;
    if (!validator.isNumeric(userId, { no_symbols: true })) {
        errors += "invalid user id; ";
    }

    // First Name
    const firstName = validator.escape(req.body.firstName);
    if (firstName === "") {
        errors += "invalid firstName; ";
    }

    // Last Name
    const lastName = validator.escape(req.body.lastName);
    if (lastName === "") {
        errors += "invalid lastName; ";
    }

    // Email
    const email = validator.escape(req.body.email);
    if (email === "") {
        errors += "invalid email; ";
    }

    // Password
    const password = validator.escape(req.body.password);
    if (password === "") {
        errors += "invalid password; ";
    }

    // Role
    const role = validator.escape(req.body.role);
    if (role === "") {
        errors += "invalid role; ";
    }

    if (errors != "") {
        res.json({ "error": errors });
        return false;
    }

    try {
        const pool = await dbConnPoolPromise;
        const result = await pool.request()
            .input('id', sql.Int, userId)
            .input('firstname', sql.NVarChar, firstName)
            .input('lastName', sql.NVarChar, lastName)
            .input('email', sql.NVarChar, email)
            .input('password', sql.NVarChar, password)
            .input('role', sql.NVarChar, role)
            .query(SQL_UPDATE);

        res.json(result.recordset[0]);
    }
    catch (err) {
        res.status(500);
        res.send(err.message);
    }
});

router.delete('/:id', async (req, res) => {
    const userId = req.params.id;

    if (!validator.isNumeric(userId, { no_symbols: true })) {
        res.json({ "error": "invalid id parmeter" });
        return false;
    }

    try {
        const pool = await dbConnPoolPromise;
        const result = await pool.request().input('id', sql.Int, userId).query(SQL_DELETE);
        res.json(result.recordset);
    }
    catch (err) {
        res.status(500);
        res.send(err.message);
    }
});

//last line of user.js
module.exports = router;