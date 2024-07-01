const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const cors = require('cors');
const MySQLStore = require('express-mysql-session')(session);

const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'root',
  database: 'paddy_rice'
});

connection.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL');
});

app.use(cors());
app.use(bodyParser.json());
app.use(session({ secret: 'my-secret-key', resave: false, saveUninitialized: false, cookie: { secure: false }  }));

let otps = {}; // Object to store OTPs

// Middleware สำหรับตรวจสอบการเข้าสู่ระบบ
function isAuthenticated(req, res, next) {
  if (req.session && req.session.user) {
    return next();
  } else {
    console.log('Unauthorized access attempt');
    return res.status(401).send('Unauthorized');
  }
}

// Route สำหรับการเข้าสู่ระบบ
app.post('/login', (req, res) => {
  const { emailOrPhone, password } = req.body;
  const sql = 'SELECT * FROM user_information WHERE Email = ? OR PhoneNumber = ?';
  connection.query(sql, [emailOrPhone, emailOrPhone], (err, results) => {
    if (err) {
      return res.status(500).send('Error on the server.');
    }
    if (results.length === 0) {
      return res.status(404).send('User not found');
    }
    const user = results[0];
    bcrypt.compare(password, user.Password, (err, isMatch) => {
      if (err) {
        return res.status(500).send('Error on the server.');
      }
      if (isMatch) {
        req.session.user = user;
        res.status(200).send('Login successful');
      } else {
        res.status(401).send('Invalid password');
      }
    });
  });
});

// Route สำหรับการสมัครสมาชิก
app.post('/signup', (req, res) => {
  const { name, surname, email, phone, password } = req.body;
  const sql = 'SELECT * FROM user_information WHERE Email = ? OR PhoneNumber = ?';
  connection.query(sql, [email, phone], (err, results) => {
    if (err) {
      console.error('Database query error:', err);
      return res.status(500).send('Error on the server.');
    }
    if (results.length > 0) {
      return res.status(400).send('User already exists');
    }
    bcrypt.hash(password, 10, (err, hash) => {
      if (err) {
        console.error('Bcrypt hash error:', err);
        return res.status(500).send('Error on the server.');
      }
      const insertSql = 'INSERT INTO user_information (Name, Surname, Email, PhoneNumber, Password) VALUES (?, ?, ?, ?, ?)';
      connection.query(insertSql, [name, surname, email, phone, hash], (err, results) => {
        if (err) {
          console.error('Database insert error:', err);
          return res.status(500).send('Error on the server.');
        }
        res.status(200).send('User registered successfully');
      });
    });
  });
});

// Route สำหรับตรวจสอบผู้ใช้ที่มีอยู่
app.post('/check_user_exists', (req, res) => {
  const { type, value } = req.body;
  let sql = '';
  if (type === 'PhoneNumber') {
    sql = 'SELECT * FROM user_information WHERE Phonenumber = ?';
  } else if (type === 'email') {
    sql = 'SELECT * FROM user_information WHERE Email = ?';
  }
  connection.query(sql, [value], (err, results) => {
    if (err) {
      return res.status(500).send('Error on the server.');
    }
    if (results.length > 0) {
      res.status(200).send('User exists');
    } else {
      res.status(404).send('User not found');
    }
  });
});

// Route สำหรับส่ง OTP
app.post('/send_otp', (req, res) => {
  const { type, value } = req.body;
  const otp = Math.floor(100000 + Math.random() * 900000).toString(); // สร้าง OTP 6 หลัก

  otps[value] = otp; // Store OTP for later verification

  console.log(`Generated OTP for ${value}: ${otp}`); // Log OTP
  res.status(200).send('OTP sent successfully');
});

// Route สำหรับตรวจสอบ OTP
app.post('/verify_otp', (req, res) => {
  const { otp, contact, type } = req.body;

  if (otps[contact] && otps[contact] === otp) {
    delete otps[contact]; // OTP ใช้แล้วจะถูกลบ
    res.status(200).send('OTP verified successfully');
  } else {
    res.status(400).send('Invalid OTP');
  }
});

// Route สำหรับเปลี่ยนรหัสผ่าน
app.post('/change_password', isAuthenticated, (req, res) => {
  const { newPassword, confirmPassword } = req.body;

  if (newPassword !== confirmPassword) {
    return res.status(400).send('Passwords do not match');
  }

  const user = req.session.user;

  if (!user) {
    return res.status(401).send('Unauthorized');
  }

  const sql = 'UPDATE user_information SET Password = ? WHERE UserID = ?';
  connection.query(sql, [newPassword, user.UserID], (err, results) => {
    if (err) {
      return res.status(500).send('Error on the server.');
    }
    res.status(200).send('Password changed successfully');
  });
});

// Route สำหรับดึงข้อมูลโปรไฟล์ผู้ใช้
app.get('/profile', isAuthenticated, (req, res) => {
  const userId = req.session.user.UserID;
  const sql = 'SELECT Name, Surname, Email, PhoneNumber FROM user_information WHERE UserID = ?';
  connection.query(sql, [userId], (err, results) => {
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

app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on http://localhost:${port}`);
});
