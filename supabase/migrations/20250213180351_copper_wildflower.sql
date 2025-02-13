/*
  # Initialize settings data
  
  1. Changes
    - Insert initial settings record with default values
*/

INSERT INTO settings (id, restaurant_name, contact_email, contact_phone, address)
VALUES 
  ('00000000-0000-0000-0000-000000000000', 'Foodie''s Diner', NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;