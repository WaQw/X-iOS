const express = require("express");
const User = require("../models/user");

// Original Router

const router = new express.Router();

// Endpoints

// Create a user

router.post("/users", async (req, res) => {
  const user = new User(req.body);
  try {
    // await need to be combined with trycatch block
    await user.save(); // save to mongodb
    res.status(201).send(user);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Fetch users

router.get("/users", async (req, res) => {
  try {
    const users = await User.find({});
    res.status(200).send(users);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Login

router.post("/users/login", async (req, res) => {
  try {
    const user = await User.findByCredentials(
      req.body.email,
      req.body.password
    );
    const token = await user.generateAuthToken();
    res.send({ user, token });
  } catch (error) {
    res.status(500).send(error);
  }
});

// Delete user

router.delete("/users/:id", async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) {
      res.status(400).send("User does not exist!");
    }
    res.status(200).send("Delete successfully!");
  } catch (error) {
    res.status(500).send(error);
  }
});

// Fetch specific user

router.get("/users/:id", async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      res.status(404).send("User does not exist!");
    }
    res.status(200).send(user);
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
