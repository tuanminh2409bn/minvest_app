const admin = require('firebase-admin');
const path = require('path');
const serviceAccount = require(path.join(__dirname, 'functions', 'serviceAccountKey.json')) || {}; // Or whatever way
