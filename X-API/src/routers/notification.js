const express = require("express");
const auth = require("../middleware/auth");
const Notification = require("../models/notification");

const router = express.Router();

// Post a notification

router.post("/notification", auth, async (req, res) => {
  const notification = new Notification({
    ...req.body,
    user: req.user._id,
  });
  try {
    await notification.save();
    res.status(201).send(notification);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Get all notifications

router.get("/notification", async (req, res) => {
  try {
    const notifications = await Notification.find({});
    res.send(notifications);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Get a user's notifications

router.get("/notification/:id", async (req, res) => {
  try {
    const notifications = await Notification.find({
      notiReceiverId: req.params.id,
    });
    res.send(notifications);
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
