import { create } from 'zustand';
import { supabase } from '../lib/supabase';

interface Settings {
  restaurantName: string;
  contactEmail: string | null;
  contactPhone: string | null;
  address: string | null;
}

interface SettingsStore {
  settings: Settings | null;
  loading: boolean;
  error: string | null;
  fetchSettings: () => Promise<void>;
  updateSettings: (settings: Partial<Settings>) => Promise<void>;
}

export const useSettingsStore = create<SettingsStore>((set) => ({
  settings: null,
  loading: false,
  error: null,

  fetchSettings: async () => {
    set({ loading: true, error: null });
    try {
      const { data, error } = await supabase
        .from('settings')
        .select('*')
        .limit(1)
        .maybeSingle();

      if (error) throw error;

      if (data) {
        set({
          settings: {
            restaurantName: data.restaurant_name,
            contactEmail: data.contact_email,
            contactPhone: data.contact_phone,
            address: data.address,
          },
          loading: false,
        });
      }
    } catch (error) {
      set({ error: (error as Error).message, loading: false });
    }
  },

  updateSettings: async (newSettings) => {
    set({ loading: true, error: null });
    try {
      const { error } = await supabase
        .from('settings')
        .update({
          restaurant_name: newSettings.restaurantName,
          contact_email: newSettings.contactEmail,
          contact_phone: newSettings.contactPhone,
          address: newSettings.address,
        })
        .eq('id', '00000000-0000-0000-0000-000000000000');

      if (error) throw error;

      set((state) => ({
        settings: state.settings ? { ...state.settings, ...newSettings } : null,
        loading: false,
      }));
    } catch (error) {
      set({ error: (error as Error).message, loading: false });
    }
  },
}));