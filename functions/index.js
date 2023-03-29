const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
exports.myFunction = functions.firestore
    .document("/chat/{msg}")
    .onCreate((snapshot, context) => {
      const myTitle = snapshot.data().username == null ?
      "UserName" : snapshot.data().username;
 
      const myBody = snapshot.data().text == null ?
      "Message" : snapshot.data().text;
 
      return admin.messaging().send({
        notification: {
          title: myTitle,
          body: myBody,
        },
        topic: "chat",
      });
    });
