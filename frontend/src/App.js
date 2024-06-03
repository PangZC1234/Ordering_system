import React, { useState, useEffect } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import LoginPage from './LoginPage';
import HomePage from './HomePage';
import AdminPage from './AdminPage';
import Order from './Order'
import Kitchen from './Kitchen'
import axios from 'axios';

const client = axios.create({
  baseURL: "http://localhost:8000"
});

/* Custom hook to save the last visited route to localStorage
const useSaveLastRoute = (isLoggedIn) => {
  const [location, setLocation] = useState('');

  useEffect(() => {
    if (isLoggedIn) {
      setLocation(window.location.pathname);
    }
  }, [isLoggedIn]);

  return location;
};*/

const App = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const location = useLocation();
  const [loading, setLoading] = useState(true); // Loading state
  
  useEffect(() => {
    // Check if the user is already logged in
    client.get('/api/user', { withCredentials: true })
      .then(response => {
        if (response.status === 200) {
          setIsLoggedIn(true);
          setIsAdmin(response.data.user.is_superuser);
          // Set the last route when user logs in
        }
      })
      .catch(error => {
        console.error('User not authenticated:', error);
      })
      .finally(() => {
        setLoading(false); // Set loading to false after check is complete
      });
  }, [location.pathname]);

  const handleLogin = () => {
    setIsLoggedIn(true);
    // Fetch user information after login to check admin status
    client.get('/api/user', { withCredentials: true })
      .then(response => {
        if (response.status === 200) {
          setIsAdmin(response.data.user.is_superuser);
        }
      })
      .catch(error => {
        console.error('Failed to fetch user info:', error);
      });
  };

  const handleLogout = () => {
    setIsLoggedIn(false);
  };

  if (loading) {
    // Show a loading spinner or placeholder while checking authentication
    return <div>Loading...</div>;
  }

  return (
    <Routes>
      <Route path="/" element={isLoggedIn ? <Navigate to={"/home"} replace /> : <Navigate to="/login" replace />} />
      <Route path="/home" element={isLoggedIn ? <HomePage isAdmin={isAdmin} onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
      <Route path="/admin" element={isLoggedIn && isAdmin ? <AdminPage onLogout={handleLogout} /> : <Navigate to="/" replace/>} />
      <Route path="/login" element={isLoggedIn ? <Navigate to="/home" replace/> : <LoginPage onLogin={handleLogin} />} />
      <Route path="/order" element={isLoggedIn ? <Order onLogout={handleLogout} /> : <Navigate to="/login" replace/>} />
      <Route path="/kitchen" element={isLoggedIn ? <Kitchen onLogout={handleLogout} /> : <Navigate to="/login" replace/>} />
    </Routes>
  );
};

export default App;
