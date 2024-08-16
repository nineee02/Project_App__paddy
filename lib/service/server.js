const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const cors = require('cors');
const MySQLStore = require('express-mysql-session')(session);

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const pool = mysql.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: 'root',
  database: 'paddy_app',
});

const sessionStore = new MySQLStore({}, pool.promise());

app.use(session({
  key: 'session_cookie_name',
  secret: 'session_cookie_secret',
  store: sessionStore,
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 1000 * 60 * 60 * 24 } // 1 day
}));

// Login route
app.post('/login', async (req, res) => {
    const { emailOrPhone, password } = req.body;

    try {
        const [rows] = await pool.promise().query(
            'SELECT id, password FROM users WHERE email = ? OR phone_number = ?',
            [emailOrPhone, emailOrPhone]
        );

        if (rows.length === 0) {
            return res.status(401).json({ message: 'Invalid email or phone number' });
        }

        const user = rows[0];
        const isPasswordCorrect = await bcrypt.compare(password, user.password);

        if (!isPasswordCorrect) {
            return res.status(401).json({ message: 'Incorrect password' });
        }

        res.status(200).json({ userId: user.id });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Signup route
app.post('/signup', async (req, res) => {
    const { name, surname, phone, email, password } = req.body;

    try {
        const [existingUsers] = await pool.promise().query(
            'SELECT * FROM users WHERE email = ? OR phone_number = ?',
            [email, phone]
        );

        if (existingUsers.length > 0) {
            return res.status(409).json({ message: 'Email or phone already exists' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        await pool.promise().query(
            'INSERT INTO users (name, surname, phone_number, email, password) VALUES (?, ?, ?, ?, ?)',
            [name, surname, phone, email, hashedPassword]
        );

        res.status(201).json({ message: 'User registered successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

// Route to get user profile by email
app.get('/profile', async (req, res) => {
    const { email } = req.query;

    try {
        const [rows] = await pool.promise().query(
            'SELECT name, surname, email, phone_number FROM users WHERE email = ?',
            [email]
        );

        if (rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        const user = rows[0];
        res.status(200).json(user);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

app.get('/profile/:userId', async (req, res) => {
    const userId = req.params.userId;
    const sql = 'SELECT name, surname, email, phone_number FROM users WHERE id = ?';
    pool.query(sql, [userId], (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            return res.status(500).send('Error on the server.');
        }
        if (results.length === 0) {
            return res.status(404).send('User not found');
        }
        const user = results[0];
        res.status(200).json(user);
    });
});

// Listen on port 3000
app.listen(port, '0.0.0.0', () => {
    console.log(`Server running on http://localhost:${port}`);
});
