importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyA99HRQhOpoCTirxZxFEKiGk9uL7PTMvgQ",
    authDomain: "justitis-b275e.firebaseapp.com",
    projectId: "justitis-b275e",
    storageBucket: "justitis-b275e.appspot.com",
    messagingSenderId: "977297428392",
    appId: "1:977297428392:web:29a7a7a70e4a757c8f579d",
    measurementId: "G-P54X9HW32V"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});