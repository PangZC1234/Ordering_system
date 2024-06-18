import React, { useState, useEffect } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import LoginPage from './LoginPage';
import HomePage from './HomePage';
import AdminPage from './AdminPage';
import Order from './Order'
import Kitchen from './Kitchen'
import Logout from './Logout'
import axios from 'axios';
import Container from 'react-bootstrap/Container';
import Navbar from 'react-bootstrap/Navbar';
import Button from 'react-bootstrap/Button';
import Nav from 'react-bootstrap/Nav'

const client = axios.create({
  baseURL: "http://localhost:8000"
});

const App = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(true); // Loading state
  
  function submitLogout(e) {
    e.preventDefault();
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    client.post(
      "/api/logout",
      {withCredentials: true}
    );
  }

  useEffect(() => {
    if(localStorage.getItem('access_token') !== null){
        setIsLoggedIn(true);
    }
    setLoading(false); 
    }, [isLoggedIn]);

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
    <>
      <Routes>
              <Route path="/" element={isLoggedIn ? <Navigate to={"/home"} replace /> : <Navigate to="/login" replace />} />
              <Route path="/home" element={isLoggedIn ? <HomePage isAdmin={isAdmin} onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
              <Route path="/admin" element={isLoggedIn && isAdmin ? <AdminPage onLogout={handleLogout} /> : <Navigate to="/" replace />} />
              <Route path="/login" element={isLoggedIn ? <Navigate to="/home" replace /> : <LoginPage onLogin={handleLogin} />} />
              <Route path="/order" element={isLoggedIn ? <Order onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
              <Route path="/kitchen" element={isLoggedIn ? <Kitchen onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
              <Route path="/logout" element={isLoggedIn ? <Logout/> : <Navigate to="/login" replace />} />
    </Routes></>
  );
};

export default App;