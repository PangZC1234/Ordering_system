import './App.css';
import React from 'react';
import { useState } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.css';
import Container from 'react-bootstrap/Container';
import Navbar from 'react-bootstrap/Navbar';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';

const client = axios.create({
  baseURL: "http://localhost:8000",
  withCredentials: true
});

const LoginPage = () => {
    const [registrationToggle, setRegistrationToggle] = useState(false);
    const [email, setEmail] = useState('');
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState(null);
  
    function update_form_btn() {
      if (registrationToggle) {
        document.getElementById("form_btn").innerHTML = "Register";
        setRegistrationToggle(false);
      } else {
        document.getElementById("form_btn").innerHTML = "Log in";
        setRegistrationToggle(true);
      }
    }

    const submitRegistration = async (e) => {
        e.preventDefault();
        setError(null); // Reset error state before attempting registration
        try {
          await client.post(
            "/api/register",
            {
              email: email,
              username: username,
              password: password
            }
          );
    
          // Automatically log in the user after successful registration
          try {
            const user = {
              email: email,
              password: password
             };
              // Create the POST requuest
            const {data} = await client.post('/token/', user ,{headers: {
                'Content-Type': 'application/json'
            }}, {withCredentials: true});
  
            // Initialize the access & refresh token in localstorage.      
            localStorage.clear();
            localStorage.setItem('access_token', data.access);
            localStorage.setItem('refresh_token', data.refresh);
            axios.defaults.headers.common['Authorization'] = `Bearer ${data['access']}`;
            window.location.href = '/';
          } catch (loginError) {
            setError('Registration successful, but login failed. Please try logging in manually.');
          }
        } catch (registrationError) {
          setError('Registration failed. Please check your details and try again.');
        }
      };
    
  
    const submitLogin = async (e) => {
        e.preventDefault();
        setError(null);
        try {
          const user = {
            email: email,
            password: password
           };
            // Create the POST requuest
          const {data} = await client.post('/token/', user ,{headers: {
              'Content-Type': 'application/json'
          }}, {withCredentials: true});

          // Initialize the access & refresh token in localstorage.      
          localStorage.clear();
          localStorage.setItem('access_token', data.access);
          localStorage.setItem('refresh_token', data.refresh);
          axios.defaults.headers.common['Authorization'] = `Bearer ${data['access']}`;
          window.location.href = '/'
        }
        catch (error){
          if (!error.response) {
            // Network error or server is not reachable
            setError('Network error. Please check your internet connection.');
          } else if (error.response.status === 401) {
            // Invalid credentials
            setError('Invalid email or password');
          } else if (error.response.status >= 500) {
            // Server errors
            setError('Server error. Please try again later.');
          } else {
            // Other errors
            setError('An error occurred. Please try again.');
          }
        }
    }
  
    return (
        <div>
        <Navbar bg="dark" variant="dark">
          <Container>
            <Navbar.Brand>Ordering system</Navbar.Brand>
            <Navbar.Toggle />
            <Navbar.Collapse className="justify-content-end">
              <Navbar.Text>
                <Button id="form_btn" onClick={update_form_btn} variant="light">Register</Button>
              </Navbar.Text>
            </Navbar.Collapse>
          </Container>
        </Navbar>
        {
          registrationToggle ? (
            <div className="center">
              <Form onSubmit={e => submitRegistration(e)}>
                <Form.Group className="mb-3" controlId="formBasicEmail">
                  <Form.Label>Email address</Form.Label>
                  <Form.Control type="email" placeholder="Enter email" value={email} onChange={e => setEmail(e.target.value)} />
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicUsername">
                  <Form.Label>Username</Form.Label>
                  <Form.Control type="text" placeholder="Enter username" value={username} onChange={e => setUsername(e.target.value)} />
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicPassword">
                  <Form.Label>Password</Form.Label>
                  <Form.Control type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)} />
                </Form.Group>
                {error && <p style={{ color: 'red' }}>{error}</p>} {/* Display the error message */}
                <Button variant="primary" type="submit">
                  Submit
                </Button>
              </Form>
            </div>        
          ) : (
            <div className="center">
              <Form onSubmit={e => submitLogin(e)}>
                <Form.Group className="mb-3" controlId="formBasicEmail">
                  <Form.Label>Email address</Form.Label>
                  <Form.Control type="email" placeholder="Enter email" value={email} onChange={e => setEmail(e.target.value)} />
                </Form.Group>
                <Form.Group className="mb-3" controlId="formBasicPassword">
                  <Form.Label>Password</Form.Label>
                  <Form.Control type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)} />
                </Form.Group>
                {error && <p style={{ color: 'red' }}>{error}</p>} {/* Display the error message */}
                <Button variant="primary" type="submit">
                  Submit
                </Button>
              </Form>
            </div>
          )
        }
        </div>
      );
}

export default LoginPage;
