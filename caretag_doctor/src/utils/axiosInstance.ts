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
    refreshToken,
    {
      headers: {
        'Content-Type': 'text/plain',
        'ngrok-skip-browser-warning': 'true',
      },
    }
  );

  const newToken = data.jwtToken;
  const newRefreshToken = data.refreshToken;

  if (!newToken) throw new Error('No token in refresh response');

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
        window.location.href = '/#/auth';
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

// Response interceptor - handle 401 errors as a safety net
let isRefreshing = false;
let failedQueue: Array<{ resolve: (token: string) => void; reject: (err: Error) => void }> = [];

const processQueue = (error: Error | null, token: string | null) => {
  failedQueue.forEach((p) => {
    if (error) p.reject(error);
    else if (token) p.resolve(token);
  });
  failedQueue = [];
};

axiosInstance.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;

    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        }).then((token) => {
          originalRequest.headers.Authorization = `Bearer ${token}`;
          return axiosInstance(originalRequest);
        });
      }

      originalRequest._retry = true;
      isRefreshing = true;

      try {
        const newToken = await refreshAccessToken();
        processQueue(null, newToken);
        originalRequest.headers.Authorization = `Bearer ${newToken}`;
        return axiosInstance(originalRequest);
      } catch (refreshError) {
        processQueue(refreshError as Error, null);
        localStorage.removeItem('token');
        localStorage.removeItem('refreshToken');
        window.location.href = '/#/auth';
        return Promise.reject(refreshError);
      } finally {
        isRefreshing = false;
      }
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;