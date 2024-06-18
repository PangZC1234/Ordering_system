import axios from 'axios';
import { jwtDecode } from "jwt-decode";

const client = axios.create({
    baseURL: "http://localhost:8000",
    withCredentials: true
  });
  
client.interceptors.request.use(
async (config) => {
    const token = localStorage.getItem('access_token');
    if (token) {
    const decoded = jwtDecode(token);
    const now = Date.now().valueOf() / 1000;
    if (decoded.exp < now) {
        try {
        const response = await client.post('/api/token/refresh/', {
            refresh: localStorage.getItem('refresh_token'),
        });
        localStorage.setItem('access_token', response.data.access);
        config.headers['Authorization'] = 'Bearer ' + response.data.access;
        } catch (error) {
        // Handle token refresh error, e.g., logout user
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
        window.location.href = '/login';
        }
    } else {
        config.headers['Authorization'] = 'Bearer ' + token;
    }
    }
    return config;
},
(error) => {
    return Promise.reject(error);
}
);

  export default client;