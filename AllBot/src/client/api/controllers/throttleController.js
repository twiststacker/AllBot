module.exports = (req, res) => {
  res.json({ message: 'Request allowed', timestamp: Date.now() });
};
