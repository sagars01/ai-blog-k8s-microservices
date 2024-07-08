// Import necessary modules
const express = require('express');

// Initialize the app
const app = express();

// Set the port for the application
const PORT = process.env.PORT || 3000;

// Health check endpoint
app.get('/health', (req, res) => {
    res.status(200).json({
        status: 'UP AUTH SERVICE',
        timestamp: new Date().toISOString()
    });
});

// Middleware to handle 404 errors
app.use((req, res, next) => {
    res.status(404).json({
        error: 'Not Found'
    });
});

// Middleware to handle other errors
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({
        error: 'Something went wrong!'
    });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
