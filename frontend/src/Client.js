import axios from 'axios';

const client = axios.create({
    baseURL: "http://localhost",
    withCredentials: true
  });

client.interceptors.request.use(
async (config) => {
    const token = localStorage.getItem('access_token');
    if (token) {
        config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
},
(error) => {
    return Promise.reject(error);
}
);

// Response interceptor
client.interceptors.response.use(
    (response) => response,
    async (error) => {
      const originalRequest = error.config;
      originalRequest._retry = originalRequest._retry || false; // Default _retry to false
  
      // Handle 401 Unauthorized errors
      if (error.response?.status === 401 && !originalRequest._retry) {
        originalRequest._retry = true;
        try {
          const refreshToken = localStorage.getItem('refresh_token');
          if (!refreshToken) {
            throw new Error('No refresh token available');
          }
  
          // Call your refresh token endpoint to obtain new access token
          const response = await client.post('/token/refresh/', {
            refresh: refreshToken,
          });
  
          // If refresh token request is successful, update tokens
          localStorage.setItem('access_token', response.data.access);
          localStorage.setItem('refresh_token', response.data.refresh);
  
          // Retry the original request with the new access token
          originalRequest.headers.Authorization = `Bearer ${response.data.access}`;
          return client(originalRequest);
        } catch (error) {
          // Refresh token request failed, logout user or handle as needed
          console.error('Failed to refresh token:', error);
          localStorage.removeItem('access_token');
          localStorage.removeItem('refresh_token');
          // Redirect to login page or handle logout
          window.location.href = '/login';
          return Promise.reject(error);
        }
      }
  
      // For other errors, reject the promise
      return Promise.reject(error);
    }
  );
  


export default client;