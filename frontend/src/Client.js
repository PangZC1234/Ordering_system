import axios from 'axios';
import { jwtDecode } from "jwt-decode";

const client = axios.create({
  baseURL: 'http://localhost:8000',
});

client.interceptors.request.use(
  async (config) => {
    let token = localStorage.getItem('access_token');
    if (token) {
      const decoded = jwtDecode(token);
      const now = Date.now().valueOf() / 1000;

      if (decoded.exp < now) {
        try {
          const response = await client.post('/token/refresh/', {
            refresh: localStorage.getItem('refresh_token'),
          });
          localStorage.setItem('access_token', response.data.access);
          token = response.data.access;
        } catch (error) {
          localStorage.removeItem('access_token');
          localStorage.removeItem('refresh_token');
          window.location.href = '/login'; // Redirect to login page
          return Promise.reject(error);
        }
      }

      config.headers['Authorization'] = 'Bearer ' + token;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

client.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      localStorage.removeItem('access_token');
      localStorage.removeItem('refresh_token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

export default client;
