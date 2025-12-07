
const admin = require('firebase-admin');
const fs = require('fs');

// --- Konfiguracja ---
// 1. Pobierz plik klucza prywatnego z konsoli Firebase:
//    Project Settings -> Service accounts -> Generate new private key
// 2. Zmień nazwę pliku na 'serviceAccountKey.json' i umieść go w katalogu 'scripts'.
// 3. Wklej poniżej URL swojej bazy danych.
const serviceAccount = require('./serviceAccountKey.json');
const databaseURL = 'https://loreofthering-e2742.firebaseio.com'; // np. 'https://your-project-id.firebaseio.com'
// --------------------

// Inicjalizacja Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: databaseURL
});

const db = admin.firestore();
const questions = JSON.parse(fs.readFileSync('./questions.json', 'utf8'));

async function uploadQuestions() {
  const collectionRef = db.collection('questions');
  
  console.log('Rozpoczynanie przesyłania pytań...');

  const batch = db.batch();

  questions.forEach(question => {
    const docRef = collectionRef.doc(); // Automatycznie generuj ID
    batch.set(docRef, question);
  });

  try {
    await batch.commit();
    console.log(`Pomyślnie przesłano ${questions.length} pytań!`);
  } catch (error) {
    console.error('Błąd podczas przesyłania pytań:', error);
  }
  process.exit(0);
}

uploadQuestions();
