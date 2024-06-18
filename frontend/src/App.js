import React, { useState, useEffect } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import LoginPage from './LoginPage';
import HomePage from './HomePage';
import AdminPage from './AdminPage';
import Order from './Order'
import Kitchen from './Kitchen'
import Logout from './Logout'
import { jwtDecode } from "jwt-decode";

const App = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(true); // Loading state

  useEffect(() => {
    if(localStorage.getItem('access_token') !== null){
        setIsLoggedIn(true);
        setIsAdmin(jwtDecode(localStorage.getItem('access_token')).is_superuser);
    }
    setLoading(false); 
    }, [isLoggedIn]);

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
              <Route path="/admin" element={isLoggedIn && isAdmin ? <AdminPage onLogout={handleLogout} /> : <Navigate to="/" replace />} />
              <Route path="/login" element={isLoggedIn ? <Navigate to="/home" replace /> : <LoginPage />} />
              <Route path="/order" element={isLoggedIn ? <Order onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
              <Route path="/kitchen" element={isLoggedIn ? <Kitchen onLogout={handleLogout} /> : <Navigate to="/login" replace />} />
              <Route path="/logout" element={isLoggedIn ? <Logout/> : <Navigate to="/login" replace />} />
    </Routes>
  );
};

export default App;