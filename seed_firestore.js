// Firestore Seed Data Script (Node.js)
// Run: node seed_firestore.js
// Install: npm install firebase-admin
// Download serviceAccountKey.json from Firebase Console → Project Settings → Service Accounts

const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const BASE = 'districts/dindigul/markets/oddanchatram';

async function seed() {
  console.log('🌱 Seeding Sandhai Rate Firestore...\n');

  // ── Vegetables ─────────────────────────────────────────────
  const vegetables = [
    { id: 'tomato',     tamil_name: 'தக்காளி',    english_name: 'Tomato',     today_price: 14,  yesterday_price: 12, unit: 'kg' },
    { id: 'onion',      tamil_name: 'வெங்காயம்',  english_name: 'Onion',      today_price: 22,  yesterday_price: 20, unit: 'kg' },
    { id: 'potato',     tamil_name: 'உருளைக்கிழங்கு', english_name: 'Potato', today_price: 30, yesterday_price: 30, unit: 'kg' },
    { id: 'brinjal',    tamil_name: 'கத்திரிக்காய்', english_name: 'Brinjal', today_price: 28, yesterday_price: 32, unit: 'kg' },
    { id: 'carrot',     tamil_name: 'கேரட்',       english_name: 'Carrot',     today_price: 40,  yesterday_price: 38, unit: 'kg' },
    { id: 'beans',      tamil_name: 'பீன்ஸ்',      english_name: 'Beans',      today_price: 60,  yesterday_price: 55, unit: 'kg' },
    { id: 'ladyfinger', tamil_name: 'வெண்டைக்காய்', english_name: 'Ladyfinger', today_price: 35, yesterday_price: 40, unit: 'kg' },
    { id: 'drumstick',  tamil_name: 'முருங்கைக்காய்', english_name: 'Drumstick', today_price: 50, yesterday_price: 45, unit: 'kg' },
    { id: 'cabbage',    tamil_name: 'முட்டைகோஸ்', english_name: 'Cabbage',    today_price: 18,  yesterday_price: 20, unit: 'kg' },
    { id: 'cauliflower',tamil_name: 'காலிஃப்ளவர்', english_name: 'Cauliflower', today_price: 45, yesterday_price: 50, unit: 'kg' },
    { id: 'greenchilli',tamil_name: 'பச்சை மிளகாய்', english_name: 'Green Chilli', today_price: 80, yesterday_price: 70, unit: 'kg' },
    { id: 'garlic',     tamil_name: 'பூண்டு',      english_name: 'Garlic',     today_price: 200, yesterday_price: 190, unit: 'kg' },
    { id: 'ginger',     tamil_name: 'இஞ்சி',       english_name: 'Ginger',     today_price: 150, yesterday_price: 160, unit: 'kg' },
  ];

  for (const v of vegetables) {
    await db.doc(`${BASE}/vegetables/${v.id}`).set({
      tamil_name: v.tamil_name,
      english_name: v.english_name,
      today_price: v.today_price,
      yesterday_price: v.yesterday_price,
      unit: v.unit,
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });
    console.log(`  ✅ Vegetable: ${v.english_name}`);
  }

  // ── Egg ────────────────────────────────────────────────────
  await db.doc(`${BASE}/egg`).set({
    price_per_egg: 5.80,
    price_per_tray: 174,     // 30 eggs
    price_per_100: 580,      // 100 eggs
    yesterday_price: 5.60,
    updated_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  console.log('  ✅ Egg prices');

  // ── Fuel ───────────────────────────────────────────────────
  await db.doc(`${BASE}/fuel`).set({
    petrol: 102.45,
    diesel: 94.10,
    yesterday_petrol: 102.45,
    yesterday_diesel: 94.10,
    updated_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  console.log('  ✅ Fuel prices');

  // ── Gold ───────────────────────────────────────────────────
  await db.doc(`${BASE}/gold`).set({
    gold_22k: 7250,
    gold_24k: 7900,
    silver: 92,
    yesterday_gold_22k: 7200,
    yesterday_gold_24k: 7850,
    yesterday_silver: 90,
    updated_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  console.log('  ✅ Gold prices');

  console.log('\n🎉 Seeding complete! Check Firebase Console.');
  process.exit(0);
}

seed().catch(console.error);
