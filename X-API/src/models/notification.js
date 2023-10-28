const mongoose = require("mongoose");

const notificationSchema = mongoose.Schema({
  username: {
    type: String,
    required: true,
  },
  notiSenderId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "User",
  },
  notiReceiverId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "User",
  },
  notiType: {
    type: String,
  },
  postText: {
    type: String,
  },
});

module.exports = mongoose.model("Notification", notificationSchema);
