# Loopy Live — Supabase two-device demo

## Architecture

Student phone
→ Loopy web/PWA
→ Supabase `loopy_state`
→ Supabase Realtime
→ Admin laptop

The UI and business logic come from the current Loopy review build. Supabase is used only as the shared data layer.

## Food options

Exactly these four:
1. Panner Curry and Rice
2. Chicken Curry and Rice
3. Burger and Fries
4. Chicken Noodle Soup

## Step 1 — Supabase

1. Create a Supabase project.
2. Open SQL Editor.
3. Paste all of `supabase.sql`.
4. Click Run.
5. Confirm the final query shows `loopy_state` inside the `supabase_realtime` publication.

## Step 2 — Get credentials

In Supabase open Connect or Settings → API Keys.

Copy:
- Project URL
- Publishable key (`sb_publishable_...`)

Put them in `index.html`:

    const SUPABASE_URL="YOUR_SUPABASE_URL";
    const SUPABASE_KEY="YOUR_SUPABASE_PUBLISHABLE_KEY";

Do not put a secret/service-role key in this website.

## Step 3 — Host

Supabase is the backend/database. The static website can be hosted on GitHub Pages.

Upload the contents of this folder to a GitHub repository:
- `index.html`
- `manifest.webmanifest`
- `sw.js`
- `icon.svg`
- `.github/workflows/deploy.yml`

Then open GitHub:
Settings → Pages → Source → GitHub Actions.

GitHub will publish the website over HTTPS.

## Step 4 — Laptop

Open the published Loopy URL.

Admin:
- School ID: `admin1`
- Username: `admin`
- Password: `admin@1`

Leave the Admin Dashboard open.

## Step 5 — Phone

Open the exact same URL.

Student:
- School ID: `LOOPLY1`
- Password: `student@1`
- Username: any demo name

Use the browser's Add to Home Screen / Install option to use Loopy like a mobile app.

## Step 6 — Test live syncing

1. Laptop: Admin → Dashboard.
2. Phone: Student → Food.
3. Select `Panner Curry and Rice`.
4. The change is written to Supabase.
5. Realtime sends the change to the laptop.
6. The admin dashboard re-renders from the database.
7. Test Resources → Request on the phone.
8. Approve the request on the laptop.
9. The phone sees the approved status.

The implementation uses Supabase Postgres Changes plus a 4-second fallback read.

## Demo security

This database policy is intentionally permissive for a competition demo. Anyone with the public demo URL can reach the shared demo row. Do not enter real student personal data.

For production, use Supabase Auth, role-based Row Level Security, campus-level access controls, and separate tables for students, food choices, listings, requests and logs.
