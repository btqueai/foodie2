/*
  # Initial Database Setup for Foodie's Diner

  1. New Tables
    - `settings`
      - `id` (uuid, primary key)
      - `restaurant_name` (text)
      - `contact_email` (text)
      - `contact_phone` (text)
      - `address` (text)
      - `updated_at` (timestamp)
    
    - `reservations`
      - `id` (uuid, primary key)
      - `customer_name` (text)
      - `customer_email` (text)
      - `customer_phone` (text)
      - `date` (date)
      - `time` (time)
      - `guests` (integer)
      - `status` (text)
      - `notes` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Settings table
CREATE TABLE settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  restaurant_name text NOT NULL DEFAULT 'Foodie''s Diner',
  contact_email text,
  contact_phone text,
  address text,
  updated_at timestamptz DEFAULT now()
);

-- Reservations table
CREATE TABLE reservations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_name text NOT NULL,
  customer_email text NOT NULL,
  customer_phone text,
  date date NOT NULL,
  time time NOT NULL,
  guests integer NOT NULL DEFAULT 1,
  status text NOT NULL DEFAULT 'pending',
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reservations ENABLE ROW LEVEL SECURITY;

-- Policies for settings
CREATE POLICY "Allow authenticated users to read settings"
  ON settings
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow authenticated users to update settings"
  ON settings
  FOR UPDATE
  TO authenticated
  USING (true);

-- Policies for reservations
CREATE POLICY "Allow authenticated users to read reservations"
  ON reservations
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow authenticated users to insert reservations"
  ON reservations
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update reservations"
  ON reservations
  FOR UPDATE
  TO authenticated
  USING (true);

-- Insert initial settings
INSERT INTO settings (restaurant_name)
VALUES ('Foodie''s Diner');