import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import axiosInstance from '@/utils/axiosInstance';

interface AuthContextType {
  user: any | null;
  loading: boolean;
  role: string | null;
  signOut: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<any | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const initializeAuth = async () => {
      const token = localStorage.getItem('token');
      if (token) {
        try {
          // Fetch doctor profile from your Spring Boot /doctor/profile endpoint
          const response = await axiosInstance.get('/doctor/paitents');
          setUser(response.data);
        } catch (error) {
          console.error("Auth initialization failed:", error);
          // If token is invalid/expired, we don't clear it here to avoid loops
          // but we ensure user stays null
          setUser(null);
        }
      }
      setLoading(false);
    };
    initializeAuth();
  }, []);

  const signOut = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('refreshToken');
    setUser(null);
    window.location.href = "/#/auth";
  };

  return (
    <AuthContext.Provider value={{ user, loading, role: user?.role ?? 'doctor', signOut }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within AuthProvider');
  return context;
};