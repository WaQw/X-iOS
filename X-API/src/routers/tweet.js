const express = require("express");
const Tweet = require("../models/tweet");
const auth = require("../middleware/auth");
const multer = require("multer");
const sharp = require("sharp");

const router = express.Router();
const upload = multer({ limits: { fileSize: 100000000 } });

// Post one tweet

router.post("/tweets", auth, async (req, res) => {
  const tweet = new Tweet({
    ...req.body,
    user: req.user._id,
  });
  try {
    await tweet.save();
    res.status(201).send(tweet);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Fetch all tweets

router.get("/tweets", async (req, res) => {
  try {
    const tweets = await Tweet.find({});
    res.status(200).send(tweets);
  } catch (error) {
    res.status(500).send(error);
  }
});

// Post tweet's image

router.post(
  "/tweets/:id/image",
  auth,
  upload.single("upload"),
  async (req, res) => {
    const tweet = await Tweet.findOne({ _id: req.params.id });
    if (!tweet) {
      throw new Error("Cannot find the tweet!");
    }
    const buffer = await sharp(req.file.buffer)
      .resize({ width: 350, height: 350 })
      .png()
      .toBuffer();
    tweet.image = buffer;
    await tweet.save();
    res.send();
  },
  (error, req, res, next) => {
    res.status(400).send({ error: error.message });
  }
);

// Get image

router.get("/tweets/:id/image", async (req, res) => {
  try {
    const tweet = await Tweet.findOne({ _id: req.params.id });
    if (!tweet && !tweet.image) {
      throw new Error("Image does not exist!");
    }
    res.set("Content-Type", "image/jpg");
    res.send(tweet.image);
  } catch (error) {
    res.status(400).send(error);
  }
});

// Like a tweet

router.put("/tweets/:id/like", auth, async (req, res) => {
  try {
    const tweet = await Tweet.findById(req.params.id);
    if (!tweet) {
      throw new Error("Tweet does not exist!");
    }
    if (!tweet.likes.includes(req.user.id)) {
      await tweet.updateOne({ $push: { likes: req.user.id } });
      res.status(200).json("You likes this tweet!");
    } else {
      res.status(403).json("You have already liked this tweet!");
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

// Unlike a tweet

router.put("/tweets/:id/unlike", auth, async (req, res) => {
  try {
    const tweet = await Tweet.findById(req.params.id);
    if (!tweet) {
      throw new Error("Tweet does not exist!");
    }
    if (tweet.likes.includes(req.user.id)) {
      await tweet.updateOne({ $pull: { likes: req.user.id } });
      res.status(200).json("You unlikes this tweet!");
    } else {
      res.status(403).json("You did not like this tweet!");
    }
  } catch (error) {
    res.status(500).json(error);
  }
});

// Fetch tweets of a user

router.get("/tweets/:id", async (req, res) => {
  try {
    const tweets = await Tweet.find({ user: req.params.id });
    if (!tweets) {
      res.status(404).send();
    }
    res.status(200).send(tweets);
  } catch (error) {
    res.status(500).send(error);
  }
});

module.exports = router;
