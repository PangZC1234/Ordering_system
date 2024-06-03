import './App.css';
import React from 'react';
import { useState } from 'react';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.css';
import Container from 'react-bootstrap/Container';
import Navbar from 'react-bootstrap/Navbar';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';


axios.defaults.xsrfCookieName = 'csrftoken';
axios.defaults.xsrfHeaderName = 'X-CSRFToken';
axios.defaults.withCredentials = true;

const client = axios.create({
  baseURL: "http://localhost:8000"
});

const LoginPage = ({ onLogin }) => {
    const [currentUser, setCurrentUser] = useState();
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
          const registerResponse = await client.post(
            "/api/register",
            {
              email: email,
              username: username,
              password: password
            }
          );
    
          // Automatically log in the user after successful registration
          try {
            const response = await client.post(
                "/api/login",
                {
                email: email,
                password: password
                }, { withCredentials: true }
                );
            onLogin();
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
            const response = await client.post(
            "/api/login",
            {
            email: email,
            password: password
            }, { withCredentials: true }
            );
            onLogin();
        }
        catch (error){
            setError('Invalid email or password'); // Set an error message
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
                  <Form.Text className="text-muted">
                    We'll never share your email with anyone else.
                  </Form.Text>
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
                  <Form.Text className="text-muted">
                    We'll never share your email with anyone else.
                  </Form.Text>
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
