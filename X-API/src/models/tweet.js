const mongoose = require("mongoose");

const tweetSchema = new mongoose.Schema(
  {
    text: {
      type: String,
      required: true,
      trim: true,
    },
    user: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      required: true,
      trim: true,
    },
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    image: {
      type: Buffer,
    },
    likes: {
      type: Array,
      default: [],
    },
  },
  {
    timestamps: true,
  }
);

// Help to determine whether a tweet has image

tweetSchema.methods.toJSON = function () {
  const tweet = this;
  const tweetObj = tweet.toObject();
  if (tweetObj.image) {
    tweetObj.image = "true";
  }
  return tweetObj;
};

const Tweet = mongoose.model("Tweet", tweetSchema);

module.exports = Tweet;
