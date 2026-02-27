import axios from 'axios';

const BASE_URL = 'https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev';

const axiosInstance = axios.create({
  baseURL: BASE_URL,
  headers: {
    'ngrok-skip-browser-warning': 'true',
  },
});

const isTokenExpired = (token: string): boolean => {
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    // exp is in seconds, Date.now() is in milliseconds
    return payload.exp * 1000 < Date.now();
  } catch {
    return true; // treat malformed token as expired
  }
};

const refreshAccessToken = async (): Promise<string> => {
  const refreshToken = localStorage.getItem('refreshToken');
  if (!refreshToken) throw new Error('No refresh token available');

  const { data } = await axios.post(
    `${BASE_URL}/auth/refresh`,
    { refreshToken },
    { headers: { 'ngrok-skip-browser-warning': 'true' } }
  );

  const newToken = data.token ?? data.accessToken;
  const newRefreshToken = data.refreshToken;

  localStorage.setItem('token', newToken);
  if (newRefreshToken) localStorage.setItem('refreshToken', newRefreshToken);

  return newToken;
};

// Request interceptor - check expiry, refresh if needed, then attach token
axiosInstance.interceptors.request.use(
  async (config) => {
    let token = localStorage.getItem('token');

    if (token && isTokenExpired(token)) {
      try {
        token = await refreshAccessToken();
      } catch {
        localStorage.removeItem('token');
        localStorage.removeItem('refreshToken');
        window.location.href = '/login';
        return Promise.reject(new Error('Session expired. Please log in again.'));
      }
    }

    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    return config;
  },
  (error) => Promise.reject(error)
);

export default axiosInstance;