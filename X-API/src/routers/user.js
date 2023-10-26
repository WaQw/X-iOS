const express = require("express");
const User = require("../models/user");
const multer = require("multer");
const sharp = require("sharp");
const auth = require("../middleware/auth");

// Original Router

const router = new express.Router();

// Helpers

const upload = multer({
  limits: {
    fileSize: 100000000,
  },
});

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

// Post user's avatar

router.post(
  "/users/me/avatar",
  auth,
  upload.single("avatar"),
  async (req, res) => {
    const buffer = await sharp(req.file.buffer)
      .resize({ width: 250, height: 250 })
      .png()
      .toBuffer();
    if (req.user.avatar != null) {
      req.user.avatar = null;
      req.user.avatarExists = false;
    }
    req.user.avatar = buffer;
    req.user.avatarExists = true;
    await req.user.save();
    res.send(buffer);
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

// Get user's avatar

router.get("/users/:id/avatar", async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user || !user.avatar) {
      throw new Error("Avatar does not exist!");
    }
    res.set("Content-Type", "image/jpg");
    res.send(user.avatar);
  } catch (error) {
    res.status(404).send(error);
  }
});

// Follow others

router.put("/users/:id/follow", auth, async (req, res) => {
  if (req.params.id != req.user.id) {
    try {
      const user = await User.findById(req.params.id);
      if (!user.followers.includes(req.user.id)) {
        await user.updateOne({ $push: { followers: req.user.id } });
        await req.user.updateOne({ $push: { followings: req.params.id } });
        res.status(200).json("Successfully followed!");
      } else {
        res.status(403).json("You have already been following this user!");
      }
    } catch (error) {
      res.status(500).json(error);
    }
  } else {
    res.status(403).json("You cannot follow yourself...");
  }
});

// Unfollow others

router.put("/users/:id/unfollow", auth, async (req, res) => {
  if (req.params.id != req.user.id) {
    try {
      const user = await User.findById(req.params.id);
      if (user.followers.includes(req.user.id)) {
        await user.updateOne({ $pull: { followers: req.user.id } });
        await req.user.updateOne({ $pull: { followings: req.params.id } });
        res.status(200).json("Successfully unfollowed!");
      } else {
        res.status(403).json("You have not followed this user yet!");
      }
    } catch (error) {
      res.status(500).json(error);
    }
  } else {
    res.status(403).json("You cannot unfollow yourself...");
  }
});

// Update user profile

router.patch("/users/update", auth, async (req, res) => {
  const allowedUpdates = [
    "name",
    "email",
    "password",
    "website",
    "bio",
    "location",
  ];
  const updates = Object.keys(req.body);
  const isValidOperations = updates.every((update) =>
    allowedUpdates.includes(update)
  );
  if (!isValidOperations) {
    return res.status(400).send({ error: "Invalid request!" });
  }
  try {
    const user = req.user;
    updates.forEach((update) => {
      user[update] = req.body[update];
    });
    await user.save();
    res.status(200).send(user);
  } catch (error) {
    res.status(500).json(error);
  }
});

module.exports = router;
