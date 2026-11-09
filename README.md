# Campus Service Request System

A Flutter + Hive mobile app where students report campus problems
(e.g. broken AC) and an admin tracks them to resolution.

## Features
- Submit a request with title and urgency (Low / Medium / High)
- List sorted by urgency, High first
- Admin moves status: Pending -> In Progress -> Resolved
- Students cannot change status (Admin only)
- Data saved on the phone (works offline)

## Run
flutter pub get
flutter run

## CI
GitHub Actions runs flutter analyze on every push.

## Team
Umar (24SW138),Asadullah Malik (24SW74), Bilal Ahmed (24SW135), Mubashir Ahmed Khaskheli (24SW35)
