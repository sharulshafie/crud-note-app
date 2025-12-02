const express = require('express');
const cors = require('cors');
const notesRoutes = require('./routes/notes')

const app = express();

app.use(cors());
app.use(express.json());
app.use('/notes', notesRoutes);

module.exports = app;