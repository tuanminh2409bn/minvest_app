// Import and configure the Firebase SDK
importScripts('https://www.gstatic.com/firebasejs/9.22.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.22.1/firebase-messaging-compat.js');

const firebaseConfig = {
  apiKey: "AIzaSyC4z9Q-lasHcw_gbsYvNod5N8pGkqs3BfE",
  authDomain: "minvestforexapp-33dff.firebaseapp.com",
  projectId: "minvestforexapp-33dff",
  storageBucket: "minvestforexapp-33dff.appspot.com",
  messagingSenderId: "245218403052",
  appId: "1:245218403052:web:30b6a6e919f731eeb03bc9",
  measurementId: "G-CRJG2SPE28"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = payload.notification?.title || payload.data?.title || 'Minvest Notification';
  const notificationOptions = {
    body: payload.notification?.body || payload.data?.body || 'You have a new message.',
    icon: '/icons/Icon-192.png', // Fallback icon
    data: payload.data
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

console.log("Firebase Messaging Service Worker has been set up correctly.");