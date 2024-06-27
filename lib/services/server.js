const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');

const app = express();
const port = 3000;

let otps = {}; 

app.use(bodyParser.json());
app.use(session({ secret: 'my-secret-key', resave: false, saveUninitialized: false }));

let users = [
  { name: 'Apinya', surname: 'Buarung', email: 'apinya@gmail.com', phone: '0840876132', password: 'password123' }
];

// Middleware สำหรับตรวจสอบการเข้าสู่ระบบ
function isAuthenticated(req, res, next) {
  if (req.session && req.session.user) {
    return next();
  } else {
    return res.status(401).send('Unauthorized');
  }
}

// Route สำหรับการเข้าสู่ระบบ
app.post('/login', (req, res) => {
  const { emailOrPhone, password } = req.body;
  const user = users.find(u => u.email === emailOrPhone || u.phone === emailOrPhone);

  if (user) {
    if (user.password === password) {
      req.session.user = user; 
      res.status(200).send('Login successful');
    } else {
      res.status(401).send('Invalid password');
    }
  } else {
    res.status(404).send('User not found');
  }
});

// Route สำหรับการสมัครสมาชิก
app.post('/signup', (req, res) => {
  const { name, surname, email, phone, password } = req.body;
  const existingUser = users.find(u => u.email === email || u.phone === phone);

  if (existingUser) {
    return res.status(400).send('User already exists');
  }

  users.push({ name, surname, email, phone, password });
  res.status(200).send('User registered successfully');
});

app.post('/check_user_exists', (req, res) => {
  const { type, value } = req.body;
  let user = null;

  if (type === 'phone') {
    user = users.find(u => u.phone === value);
  } else if (type === 'email') {
    user = users.find(u => u.email === value);
  }

  if (user) {
    res.status(200).send('User exists');
  } else {
    res.status(404).send('User not found');
  }
});

// Route สำหรับส่ง OTP
app.post('/send_otp', (req, res) => {
  const { type, value } = req.body;
  const otp = Math.floor(100000 + Math.random() * 900000).toString(); // สร้าง OTP 6 หลัก

  otps[value] = otp; // Store OTP for later verification

  console.log(`Generated OTP for ${value}: ${otp}`); // Log OTP
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

  user.password = newPassword;
  res.status(200).send('Password changed successfully');
});

// Route สำหรับดึงข้อมูลโปรไฟล์ผู้ใช้
app.get('/profile', isAuthenticated, (req, res) => {
  if (req.session && req.session.user) {
    res.json(req.session.user);
  } else {
    res.status(401).send('Unauthorized');
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on http://localhost:${port}`);
});
